Excercise 1: Hello World
=========================

The purpose of this excercise is just to get up and running with liquibase and h2. 
After completing the excercise you should be able to run liquibase commands from
the command line against a local H2 database.


Preparations
------------

Add the liquibase and h2 tools to the system path:

    C:\> set PATH=%PATH%;c:\hicollege\liquibase\labs\tools\bin

Create a liquibase.properties file with the following content:

    url: jdbc:h2:file:test
    driver: org.h2.Driver
    changeLogFile: changelog.xml
    contexts: default
    username: sa
    password: sa
    
This file contains default values for required liquibase parameters so we don't have to
supply them on the command line everytime we run liquibase.

Verify that it is possible to run liquibase:

    C:\> liquibase status
    INFO 5/10/12 2:00 PM:liquibase: Reading from DATABASECHANGELOG
    SA@jdbc:h2:file:test is up to date
    Liquibase 'status' Successful

This command should also have created a test.h2.db file in the current directory. 
This is the H2 database we specified in the liquibase.properties file and it is created if it
does not already exist.
We can use the h2.bat script to start an interactive SQL session against this database.

    C:\> h2 test

    Welcome to H2 Shell 1.3.166 (2012-04-08)
    Exit with Ctrl+C
    Commands are case insensitive; SQL statements end with ';'
    help or ?      Display this help
    list           Toggle result list / stack trace mode
    maxwidth       Set maximum column width (default is 100)
    autocommit     Enable or disable autocommit
    history        Show the last 20 statements
    quit or exit   Close the connection and exit

    sql>

Verify that the database is indeed empty:

    sql> SHOW TABLES;
    TABLE_NAME | TABLE_SCHEMA
    (0 rows, 10 ms)


A simple change set
-------------------

Edit the changelog.xml so it has the following content:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<databaseChangeLog
   xmlns="http://www.liquibase.org/xml/ns/dbchangelog"
   xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
   xsi:schemaLocation="
      http://www.liquibase.org/xml/ns/dbchangelog
      http://www.liquibase.org/xml/ns/dbchangelog/dbchangelog-2.0.xsd">

  <!-- Add changeset here! -->
  <changeSet id="helloworld" author="bob">
    <comment>Hello World!</comment>
  </changeSet>
  
</databaseChangeLog>
```

This changeset does not actually make any changes to the current schema when applied.

    C:\> liquibase status --verbose
    INFO 5/11/12 12:43 AM:liquibase: Reading from DATABASECHANGELOG
    1 change sets have not been applied to SA@jdbc:h2:file:test
         changelog.xml::helloworld::bob
    Liquibase 'status' Successful
  
Let's apply it!

    C:\> liquibase update
    INFO 5/11/12 12:45 PM:liquibase: Successfully acquired change log lock
    INFO 5/11/12 12:45 PM:liquibase: Reading from DATABASECHANGELOG
    INFO 5/11/12 12:45 PM:liquibase: Reading from DATABASECHANGELOG
    INFO 5/11/12 12:45 PM:liquibase: ChangeSet changelog.xml::helloworld::bob ran successfully in 1ms
    INFO 5/11/12 12:45 PM:liquibase: Successfully released change log lock
    Liquibase Update Successful

The DATABASECHANGELOG table now contains a single entry:

    C:\> h2 test
    sql> LIST;
    Result list mode is now on
    sql> SELECT * FROM DATABASECHANGELOG;
    ID           : helloworld
    AUTHOR       : bob
    FILENAME     : changelog.xml
    DATEEXECUTED : 2012-05-11 12:45:28.857
    ORDEREXECUTED: 1
    EXECTYPE     : EXECUTED
    MD5SUM       : 3:d41d8cd98f00b204e9800998ecf8427e
    DESCRIPTION  : Empty
    COMMENTS     : Hello World!
    TAG          : null
    LIQUIBASE    : 2.0.5
    (1 row, 1 ms)
    
If we try to run liquibase update again, liquibase detects that all changes have been
applied and simply exits.

    C:\> liquibase update
    INFO 5/11/12 1:10 PM:liquibase: Successfully acquired change log lock
    INFO 5/11/12 1:10 PM:liquibase: Reading from DATABASECHANGELOG
    INFO 5/11/12 1:10 PM:liquibase: Reading from DATABASECHANGELOG
    INFO 5/11/12 1:10 PM:liquibase: Successfully released change log lock
    Liquibase Update Successful

This can also be seen by running liquibase status:

    C:\> liquibase status
    INFO 5/11/12 1:08 PM:liquibase: Reading from DATABASECHANGELOG
    SA@jdbc:h2:file:test is up to date
    Liquibase 'status' Successful
