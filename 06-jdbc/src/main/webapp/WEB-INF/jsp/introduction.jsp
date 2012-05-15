<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Menagerie</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <!-- Le styles -->
    <link href="resources/css/bootstrap.css" rel="stylesheet">
    <style type="text/css">
      body {
        padding-top: 60px;
        padding-bottom: 40px;
        overflow-y: scroll;
      }
    </style>
    <link href="resources/css/bootstrap-responsive.css" rel="stylesheet">
	<link href="resources/css/prettify.css" type="text/css" rel="stylesheet" />

    <!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

    <!-- Le fav and touch icons -->
    <link rel="shortcut icon" href="resources/ico/favicon.ico">
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="resources/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="resources/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="resources/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="resources/ico/apple-touch-icon-57-precomposed.png">
  </head>

  <body>

    <div class="navbar navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container">
          <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </a>
          <a class="brand" href="introduction">Menagerie</a>
          <div class="nav-collapse">
            <ul class="nav">
              <li class="active"><a href="introduction">Introduction</a></li>
              <li><a href="excercises">Excercises</a></li>
              <li><a href="tests">Tests</a></li>
            </ul>
          </div><!--/.nav-collapse -->
        </div>
      </div>
    </div>

    <div class="container">

<div class="page-header">      
<h1>Introduction </h1>
</div>

<div class="row">
<div class="span9">
<p>The purpose of this excercise is just to get up and running with liquibase and h2. 
After completing the excercise you should be able to run liquibase commands from
the command line against a local H2 database.</p>
<h2>Preparations</h2>
<p>Add the liquibase and h2 tools to the system path:</p>
<pre class="prettyprint linenums">
<b>C:\> set PATH=%PATH%;c:\hicollege\liquibase\labs\tools\bin</b>
</pre>
<p>Create a liquibase.properties file with the following content:</p>
<pre class="prettyprint linenums">
url: jdbc:h2:file:test
driver: org.h2.Driver
changeLogFile: changelog.xml
contexts: default
username: sa
password: sa
</pre>
<p>This file contains default values for required liquibase parameters so we don't have to
supply them on the command line everytime we run liquibase. 
As can be seen above, we are running liquibase against a file based H2 database called test and 
the changelog.xml in the current directory.</p>
<p>Verify that it is possible to run liquibase:</p>
<pre class="prettyprint linenums">
<b>C:\> liquibase status</b>
INFO 5/10/12 2:00 PM:liquibase: Reading from DATABASECHANGELOG
SA@jdbc:h2:file:test is up to date
Liquibase 'status' Successful
</pre>
<p>This command should also have created a <code>test.h2.db</code> file in the current directory. 
This is the H2 database we specified in the liquibase.properties file and it is created if it
does not already exist.
We can use the h2.bat script to start an interactive SQL session against this database.</p>
<pre class="prettyprint linenums">
<b>C:\> h2 test</b>

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
</pre>
<p>Verify that the database is indeed empty:</p>
<pre class="prettyprint linenums">
<b>sql> SHOW TABLES;</b>
TABLE_NAME | TABLE_SCHEMA
(0 rows, 10 ms)
</pre>

<h2>A simple change set</h2>
<p>Edit the changelog.xml so it has the following content:</p>
<pre class="prettyprint linenums lang-xml">
&lt;?xml version=&quot;1.0&quot; encoding=&quot;UTF-8&quot;?&gt;
&lt;databaseChangeLog
   xmlns=&quot;http://www.liquibase.org/xml/ns/dbchangelog&quot;
   xmlns:xsi=&quot;http://www.w3.org/2001/XMLSchema-instance&quot;
   xsi:schemaLocation=&quot;
      http://www.liquibase.org/xml/ns/dbchangelog
      http://www.liquibase.org/xml/ns/dbchangelog/dbchangelog-2.0.xsd&quot;&gt;

  &lt;!-- Add changeset here! --&gt;
  &lt;changeSet id=&quot;helloworld&quot; author=&quot;bob&quot;&gt;
    &lt;comment&gt;Hello World!&lt;/comment&gt;
  &lt;/changeSet&gt;
  
&lt;/databaseChangeLog&gt;
</pre>
<p>This change set does not contain any refactoring commands and will not make any changes to the schema when applied.
Liquibase will however still track the change set. We can use the <code>status</code> command to see all outstanding changes
that would be applied with liquibase <code>update</code>. 
</p>
<pre class="prettyprint linenums lang-bash">
<b>C:\> liquibase status --verbose</b>
INFO 5/11/12 12:43 AM:liquibase: Reading from DATABASECHANGELOG
1 change sets have not been applied to SA@jdbc:h2:file:test
     changelog.xml::helloworld::bob
Liquibase 'status' Successful
</pre>  
<p>Let's apply it!</p>
<pre class="prettyprint linenums lang-bash">
<b>C:\> liquibase update</b>
INFO 5/11/12 12:45 PM:liquibase: Successfully acquired change log lock
INFO 5/11/12 12:45 PM:liquibase: Reading from DATABASECHANGELOG
INFO 5/11/12 12:45 PM:liquibase: Reading from DATABASECHANGELOG
INFO 5/11/12 12:45 PM:liquibase: ChangeSet changelog.xml::helloworld::bob ran successfully in 1ms
INFO 5/11/12 12:45 PM:liquibase: Successfully released change log lock
Liquibase Update Successful
</pre>
<p>The DATABASECHANGELOG table now contains a single entry:</p>
<pre class="prettyprint linenums lang-bash">
<b>C:\> h2 test</b>
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
</pre>    
<p>If we try to run liquibase update again, liquibase detects that all changes have been
applied and simply exits.</p>
<pre class="prettyprint linenums lang-bash">
<b>C:\> liquibase update</b>
INFO 5/11/12 1:10 PM:liquibase: Successfully acquired change log lock
INFO 5/11/12 1:10 PM:liquibase: Reading from DATABASECHANGELOG
INFO 5/11/12 1:10 PM:liquibase: Reading from DATABASECHANGELOG
INFO 5/11/12 1:10 PM:liquibase: Successfully released change log lock
Liquibase Update Successful
</pre>
<p>This can also be seen by running liquibase status:</p>
<pre class="prettyprint linenums lang-bash">
<b>C:\> liquibase status</b>
INFO 5/11/12 1:08 PM:liquibase: Reading from DATABASECHANGELOG
SA@jdbc:h2:file:test is up to date
Liquibase 'status' Successful
</pre>
<h2>Rolling back</h2>
<p>Liquibase also supports rolling back change sets and for many refactoring commands the rollback statements are created automatically. 
However, some refactorings (eg. "drop table") have no corresponding rollback command and can not be rolled back automatically. 
The &lt;rollback/&gt; command allows the user to specify how a change set should be rolled back and can be used.</p>
<p>Our change set does not contain any commands at all and can safely be rolled back simply by invoking liquibase with the rollbackCount
command, the argument <b>1</b> specifies the number of change sets to rollback:</p>
<pre class="prettyprint linenums lang-bash">
<b>C:\> liquibase rollbackCount 1</b>
INFO 5/14/12 5:17 AM:liquibase: Successfully acquired change log lock
INFO 5/14/12 5:17 AM:liquibase: Reading from DATABASECHANGELOG
INFO 5/14/12 5:17 AM:liquibase: Rolling Back Changeset:changelog.xml::helloworld::bob::(Checksum: 3:d41d8cd98f00b204e9800998ecf8427e)
INFO 5/14/12 5:17 AM:liquibase: Successfully released change log lock
Liquibase Rollback Successful
</pre>
<h2>Next steps</h2>
<p></p>
<a class="btn" href="excercises">Try the Excercises »</a>
</div>
</div><!-- /row -->    
      <hr>

      <footer>
        <p>&copy; ACME 2012</p>
      </footer>

    </div> <!-- /container -->

    <!-- Le javascript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="resources/js/jquery.js"></script>
    <script src="resources/js/bootstrap-transition.js"></script>
    <script src="resources/js/bootstrap-alert.js"></script>
    <script src="resources/js/bootstrap-modal.js"></script>
    <script src="resources/js/bootstrap-dropdown.js"></script>
    <script src="resources/js/bootstrap-scrollspy.js"></script>
    <script src="resources/js/bootstrap-tab.js"></script>
    <script src="resources/js/bootstrap-tooltip.js"></script>
    <script src="resources/js/bootstrap-popover.js"></script>
    <script src="resources/js/bootstrap-button.js"></script>
    <script src="resources/js/bootstrap-collapse.js"></script>
    <script src="resources/js/bootstrap-carousel.js"></script>
    <script src="resources/js/bootstrap-typeahead.js"></script>
    <script src="resources/js/prettify.js"></script>
    <script>
    $(function () {
    	prettyPrint();
    });
    </script>

  </body>
</html>
