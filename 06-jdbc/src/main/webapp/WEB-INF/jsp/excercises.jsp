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
              <li><a href="introduction">Introduction</a></li>
              <li class="active"><a href="excercises">Excercises</a></li>
              <li><a href="tests">Tests</a></li>
            </ul>
          </div><!--/.nav-collapse -->
        </div>
      </div>
    </div>

    <div class="container">

<div class="page-header">
<h1>Excercises</h1>
</div>
<h2>Preparations</h2>
<div class="row">
<div class="span9">
<p>Change to the Menagerie directory:</p>
<pre class="prettyprint linenums">
C:\> cd C:\HiCollege\Liquibase\Labs\Menagerie
</pre>
<p>Start the H2 database server and Menagerie web application:</p>
<pre class="prettyprint linenums">
C:\HiCollege\Liquibase\Labs\Menagerie> mvn -q tomcat:run
May 14, 2012 1:57:44 PM org.apache.catalina.startup.Embedded start
INFO: Starting tomcat server
May 14, 2012 1:57:44 PM org.apache.catalina.core.StandardEngine start
INFO: Starting Servlet Engine: Apache Tomcat/6.0.29
May 14, 2012 1:57:45 PM org.apache.catalina.core.ApplicationContext log
INFO: Initializing Spring root WebApplicationContext
May 14, 2012 1:57:47 PM org.apache.catalina.core.ApplicationContext log
INFO: Initializing Spring FrameworkServlet 'spring'
May 14, 2012 1:57:47 PM org.apache.coyote.http11.Http11Protocol init
INFO: Initializing Coyote HTTP/1.1 on http-8080
May 14, 2012 1:57:47 PM org.apache.coyote.http11.Http11Protocol start
INFO: Starting Coyote HTTP/1.1 on http-8080
</pre>
<p>The web application is available at <a href="http://localhost:8080/menagerie">http://localhost:8080/menagerie</a>.</p>
<p>The H2 console is available at <a href="http://localhost:8082/">http://localhost:8082/</a>.</p>
</div>
</div>

<div class="page-header">
<h1>Excercise 1 <small>Baseline</small></h1>
</div>

<div class="row">
<div class="span9">
<p>There are several ways you can create the initial liquibase changelog.
In this excercise we will generate the baseline schema from an existing 
database using the <code>generateChangeLog</code> command.
The schema could also be generated from other tools such as <code>hbm2ddl</code> or a using database vendor supplied tool.</p>

<p/><!-- add some room -->
<p><span class="label label-info">1.1</span> Start with creating a <code>liquibase.properties</code> file in the current directory. This will save a lot of unecessary typing when using liquibase from the command line.</p>

<ul>
<li>The jdbc url of the database is <code>jdbc:h2:tcp://localhost/prod</code>
<li>Both the username and password for this database is <code>sa</code>.
<li>The jdbc driver is <code>org.h2.Driver</code>.
<li>The H2 jdbc driver is already available on the classpath (see liquibase.bat script), so it's not necessary to specify the classpath.
<li>Specify <code>changelog.xml</code> as the changelog to use (the option is called changeLogFile).
</ul>

<p>See <a href="introduction">Introduction</a> or the <a href="http://www.liquibase.org/manual/liquibase.properties">Liquibase Manual</a> for an example liquibase.properties file. </p>

<p/>
<p><span class="label label-info">1.2</span> Run liquibase <code>generateChangeLog</code> command to generate the changelog.</p>
<p>This should create a changelog.xml file in the current directory. The changelog should contain two change sets, one for each of the two tables PET and EVENT.
The change set author and id will have values generated by liquibase.</p>
<p>For example:</p>
<pre class="prettyprint linenums">
&lt;changeSet author=&quot;joel (generated)&quot; id=&quot;1337023810043-1&quot;&gt;
&lt;changeSet author=&quot;joel (generated)&quot; id=&quot;1337023810043-2&quot;&gt;
</pre>

<p/>
<p><span class="label label-info">1.3</span> Edit the generated changelog.xml and remove the <code>(generated)</code> part and change the id to <code>PET001:X</code> where X is the change set number.</p>

<pre class="prettyprint linenums">
&lt;changeSet author=&quot;joel&quot; id=&quot;PET001:1&quot;&gt; 
&lt;changeSet author=&quot;joel&quot; id=&quot;PET001:2&quot;&gt;
</pre>
<p>PETXXX is an imaginary issue number scheme which we will be using to identify our change sets.</p>

<p/>
<p><span class="label label-info">1.4</span> Rename changelog.xml to PET001.xml and create a new (empty) changelog.xml which includes PET001.xml.</p>
<p>See <a href="http://www.liquibase.org/manual/include">http://www.liquibase.org/manual/include</a>.
<p>We are now finished with the organizing the changelogs.
<ul>
<li>liquibase.properties: Liquibase default options file.
<li>changelog.xml: Should contain a single <code>&lt;include&gt;</code> element which includes the PET001.xml file. 
<li>PET001.xml: Should contain the two generated change sets above (with sane values for id and author).
</ul>
<p>The only thing remaining is to mark the change sets as executed in the prod database and then tag the database.</p>
</p>
<p><span class="label label-info">1.5</span> Run liqubase <code>changelogSync</code>.
<p>What would happen if we ran liquibase update instead?</p>
</p>
<p><span class="label label-info">1.6</span> Tag the database with the tag <code>exercise1</code>.


</div>
</div><!-- /Excercise 1 -->

<div class="page-header">
 <h1>Excercise 2 <small> Update</small></h1>
</div>
<div class="row">
<div class="span9">
<p><span class="label label-info">2.1</span> Apply the generated changelog from Excercise 1 to an empty test database.</p>
<p>The test database has the url <code>jdbc:h2:tcp://localhost/test</code> and same username and password as prod.
<p><span class="label label-info">2.2</span> Run a diff of the prod and test databases.</p>
<p>Edit liquibase.properties and add prod as the reference database.</p>
<p>See <a href="http://www.liquibase.org/manual/diff">http://www.liquibase.org/manual/diff</a>.</p>
<p><span class="label label-info">2.3</span> Tag the database with <code>excercise2</code>.</p>
</div>
</div>

<!--   -->
<!-- 3 -->
<!--   -->


<div class="page-header">
 <h1>Excercise 3 <small> Data</small></h1>
</div>
<div class="row">
<div class="span9">
<p><span class="label label-info">3.1</span> Use the <code>generateChangeLog</code> with appropriate parameters to generate the changelog.</p>
<p>Since we will only run this command once, there is not much point in updating the liquibase.properties file. Instead specify the options on the command line:</p> 
<pre class="prettyprint linenums">
C:\> liquibase --url=jdbc:h2:tcp://localhost/prod --diffTypes=data --dataOutputDirectory=csv --changeLogFile=PET003.xml generateChangeLog
</pre>
<p>The <code>--diffTypes=data</code> option instructs liquibase to only generate load data commands and the <code>--dataOutputDirectory=csv</code> specifies where the generated csv files should be stored.</p>
<p>Also note the we override the <code>changeLogFile</code> option to write directly to PET003.xml instead of changelog.xml, so we don't have to create the file and copy the change sets manually.</p>
<p><span class="label label-info">3.2</span> Include the generated PET003.xml file in changelog.xml.</p>
<p>Don't forget to update the generated author and id attributes in the PET003.xml file.</p>
<p><span class="label label-info">3.3</span> Set the <code>context</code> attribute to "test" for these two change sets.</p>
<p>Contexts is a way to filtering the change sets that gets executed by liquibase. In this case we don't want these change sets to be applied in production.</p>
<p><span class="label label-warning">Note</span> By default, if no context is specified when invoking liquibase, all change sets will be applied. To change so that liquibase only runs change sets with no context specified, the <code>contexts</code> option should be set to "default" in liquibase.properties.</p> 
<p><span class="label label-info">3.4</span> Update liquibas.properties and set the <code>contexts</code> options to <code>default</code>.</p> 
<p><span class="label label-info">3.5</span> Apply the generated change sets to the test database.</p> 
<p><span class="label label-info">3.6</span> Tag the test database with <code>excercise3</code>.</p> 
</div>
</div>


<!--   -->
<!-- 4 -->
<!--   -->

<div class="page-header">
 <h1>Excercise 4 <small> Rename Column</small></h1>
</div>
<div class="row">
<div class="span9">
<p><span class="label label-info">4.1</span> Use the rename column refactoring command to rename columns.</p>
<p>Create a new changelog called PET004.xml and include it in changelog.xml.</p>
<p>Use the <code>renameColumn</code> command to rename the following columns:</p>
<ul>
<li>Rename the "NAME" column in EVENT table to "PETNAME"</li>
<li>Rename the "DATE" column in EVENT table to "DATECREATED"</li>
<li>Rename the "SEX" column in PET table to "GENDER"</li>
</ul>
<p>Use one change set per rename command (i.e. three change sets in total).</p>
<p><span class="label label-info">4.2</span> Apply the changes to the test database.</p>
<p><span class="label label-info">4.3</span> Tag the test database as <code>excercise4</code>.</p>
</div>
</div>




<!--   -->
<!-- 5 -->
<!--   -->

<div class="page-header">
 <h1>Excercise 5 <small> Constraints</small></h1>
</div>
<div class="row">
<div class="span9">
<p><span class="label label-info">5.1</span> Add primary key to PET table.</p>
<p>Create a new changelog called PET005.xml and include it in changelog.xml.</p>
<p>Use the <code>addPrimaryKey</code> refactoring command to add NAME as primary key for PET. Name the primary key "PK_PET".</p>
<p><span class="label label-info">5.2</span> Add foreign key from EVENT to PET table.</p>
<p>Use the <code>addForeignKeyConstraint</code> refactoring command to add foreign key between EVENT and PET tables. Name the foreign key "FK_EVENT_PET".</p>
<p><span class="label label-info">5.3</span> Try to apply the changes to the test database.</p>
<p>This should fail because the NAME column is nullable in PET. Fix the problem by adding a not null constraint and re-apply the changes.</p>
<p><span class="label label-info">5.4</span> Tag the test database as <code>excercise5</code>.</p>
</div>
</div>

<div class="page-header">
 <h1>Excercise 6 <small> Create Table</small></h1>
</div>
<div class="row">
<div class="span9">
<p><span class="label label-info">6.1</span> Create a new OWNER table.</p>
<p>Create a new changelog called PET006.xml and include it in changelog.xml.</p>
<p>The OWNER table should have the following columns.</p>
<ul>
<li>FIRSTNAME VARCHAR(20) PRIMARY KEY NOT NULL
<li>LASTNAME VARCHAR(20)
<li>GENDER VARCHAR(1)
<li>EMAIL VARCHAR(30)
<li>ADDRESS VARCHAR(40)
</ul>
<p>Name the primary key PK_OWNER.</p>
<p><span class="label label-info">6.2</span> Populate the table with distinct owners from the PET table.</p>
<p>You may use either the insert or a custom SQL command. Feel free to make up the values for the remaining columns (i.e. LASTNAME, GENDER,EMAIL and ADDRESS).</p>
<p><span class="label label-info">6.3</span> Add a foreign key constraint from PET to OWNER. Name the foreign key FK_PET_OWNER.</p>
<p><span class="label label-info">6.4</span> Apply the changes to the test database.</p>
<p><span class="label label-info">6.5</span> Tag the test database as <code>excercise6</code>.</p>
</div>
</div>



<div class="page-header">
 <h1>Excercise 7 <small> Lookup Table</small></h1>
</div>
<div class="row">
<div class="span9">
<p><span class="label label-info">7.1</span> Create lookup tables for GENDER and SPECIES in PET table.</p>
<p>Create a new changelog called PET007.xml and include it in changelog.xml.</p>
<p>Use the built-in <code>addLookupTable</code> refactoring command to extract the GENDER and SPECIES to separate tables. Be sure to name the foreign keys appropriately.</p>
<p><span class="label label-info">7.2</span> Apply the changes to the test database.</p>
<p><span class="label label-info">7.3</span> Tag the test database as <code>excercise7</code>.</p>
</div>
</div>


<div class="page-header">
 <h1>Excercise 8 <small> Views</small></h1>
</div>
<div class="row">
<div class="span9">
<p><span class="label label-info">8.1</span> Create a view that calculates the age of each pet.</p>
<p>Create a new changelog called PET008.xml and include it in changelog.xml.</p>
<p>Use the <code>createView</code> refactoring command to add the following view. Give it the name <code>V_PETAGE</code>.
<pre class="prettyprint linenums">
SELECT name,
       birth,
       death,
       (year(curdate())-year(birth)) AS age 
FROM pet
ORDER BY age
</pre>
<p><span class="label label-info">8.2</span> Apply the changes to the test database.</p>
<p>Notice that the age calculation is incorrect and does not take dead pets into account. 
Replace the previous view with the following definition:</p>
<pre class="prettyprint linenums">
SELECT name,
       birth,
       death,
       (year(curdate())-year(birth)) - (right(curdate(),5) &lt; right(birth,5)) AS age 
FROM pet
WHERE death IS NULL
UNION
SELECT name,
       birth,
       death,
       (year(death)-year(birth)) - (right(death,5) &lt; right(birth,5)) AS age 
FROM pet
WHERE death IS NOT NULL
ORDER BY age
</pre>
<p><span class="label label-warning">Note</span> You may need to use the <code>CDATA</code> block to escape some characters.</p>
<p><span class="label label-info">8.3</span> Apply the changes to the test database.</p>
<p><span class="label label-info">8.4</span> Tag the test database as <code>excercise8</code>.</p>
</div>
</div>



<!--   -->
<!-- 9 -->
<!--   -->

<div class="page-header">
 <h1>Excercise 9 <small> Surrogate Key</small></h1>
</div>
<div class="row">
<div class="span9">
<p>Introduce an auto incremented ID primary key column to the PET table and remap the associated foreign key in EVENT table.</p>
<p><span class="label label-info">9.1</span> Drop the primary key on PET table and the associated foreign key on EVENT table.</p>
<p>Create a new changelog called PET009.xml and include it in changelog.xml.</p>
<p><span class="label label-info">9.2</span> Add an auto incremented ID column to PET table.</p>
<p>Add a new ID column to the PET table and add the <code>autoIncrement</code> attribute (note that in H2 using autoincrement automatically makes the column the primary key).</p>
<p><span class="label label-info">9.3</span> Add a new PETID column to the EVENT table.</p>
<p>Add a new PETID column to the EVENT table and populate it with ID:s from the PET table (eg. use <code>valueComputed</code>.)</p>
<p><span class="label label-info">9.4</span> Add foreign key from EVENT to PET table.</p>
<p>Make PETID in EVENT table a foreign key to ID in PET table.</p>
<p><span class="label label-info">9.5</span> Apply the changes to the test database.</p>
<p><span class="label label-info">9.6</span> Tag the test database as <code>excercise9</code>.</p>
</div>
</div>

<!--    -->
<!-- 10 -->
<!--    -->

<div class="page-header">
 <h1>Excercise 10 <small> Rollback</small></h1>
</div>
<div class="row">
<div class="span9">
<p><span class="label label-info">10.1</span> Go through all the change sets and make sure it is possible to roll them back.</p>
<p><span class="label label-info">10.2</span> Tag the test database as <code>excercise10</code>.</p>
</div>
</div>


<!--    -->
<!-- 11 -->
<!--    -->

<div class="page-header">
 <h1>Excercise 11 <small> Update Prod</small></h1>
</div>
<div class="row">
<div class="span9">
<p>Run all the changes made so far on the prod database.</p>
<p><span class="label label-info">11.1</span> Apply the changes to the prod database.</p>
<p><span class="label label-info">11.2</span> Tag the prod database as <code>excercise11</code>.</p>
</div>
</div>

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
