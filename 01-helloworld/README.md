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

Change Set
----------

```xml
<changeSet id="helloworld" author="bob">
  <comment>Hello World!</comment>
</changeSet>
```