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
          <a class="brand" href="#">Menagerie</a>
          <div class="nav-collapse">
            <ul class="nav">
              <li class="active"><a href="home">Home</a></li>
              <li><a href="excercises">Excercises</a></li>
              <li><a href="pets">Pets</a></li>
              <li><a href="events">Events</a></li>
              <li><a href="changelog">Changelog</a></li>
              <li><a href="schema">Schema</a></li>
              <li><a href="tests">Tests</a></li>
            </ul>
          </div><!--/.nav-collapse -->
        </div>
      </div>
    </div>

    <div class="container">
	
	
      <div class="row">

        <div class="span9">

         
          <h2>Pets</h2>
           <p> </p>
          
          <table class="table table-bordered">
          <thead>
          <tr>
            <th>Name</th>
            <th>Owner</th>
            <th>Species</th>
            <th>Sex</th>
            <th>Birth</th>
            <th>Death</th>
          </tr>
          </thead>
          <tbody>
			<c:forEach items="${pets}" var="pet">
				<tr>
					<td>${pet.name}</td>
					<td>${pet.owner}</td>
					<td>${pet.species}</td>
					<td>${pet.sex}</td>
					<td>${pet.birth}</td>
					<td>${pet.death}</td>
				</tr>
			</c:forEach>
          </tbody>
          </table>
        </div>
        </div><!-- /row -->
        
      
      
      <div class="row">
        <div class="span9">
          
          <h2>Events</h2>
           <p> </p>
          
          <table class="table table-bordered">
          <thead>
          <tr>
            <th>Name</th>
            <th>Type</th>
            <th>Date</th>
            <th>Remark</th>
          </tr>
          </thead>
          <tbody>
			<c:forEach items="${events}" var="event">
				<tr>
					<td>${event.name}</td>
					<td>${event.type}</td>
					<td>${event.date}</td>
					<td>${event.remark}</td>
				</tr>
			</c:forEach>
          </tbody>
          </table>
          
        </div>
        </div><!-- /row -->      
      
      
      <div class="row">
        <div class="span9">
          
          <h2>Changelog</h2>
           <p> </p>
          
           <table class="table table-bordered ">
          <thead>
          <tr>
            <th>Id</th>
            <th>Author</th>
            <th>Filename</th>
            <th>Dateexecuted</th>
            <th>Exectype</th>
            <th>Md5sum</th>
          </tr>
          </thead>
          <tbody>
			<c:forEach items="${changesets}" var="changeset">
				<tr>
					<td>${changeset.id}</td>
					<td>${changeset.author}</td>
					<td>${changeset.filename}</td>
					<td>${changeset.dateexecuted}</td>
					<td>${changeset.exectype}</td>
					<td>${changeset.md5sum}</td>
				</tr>
			</c:forEach>
          </tbody>
          </table>
          
        </div>
        </div><!-- /row -->            
      
      
      <!-- Example row of columns -->
      <!-- 
      <div class="row">
        <div class="span4">
          <h2>Heading</h2>
           <p>Donec id elit non mi porta gravida at eget metus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Etiam porta sem malesuada magna mollis euismod. Donec sed odio dui. </p>
          <p><a class="btn" href="#">View details &raquo;</a></p>
        </div>
        <div class="span4">
          <h2>Heading</h2>
           <p>Donec id elit non mi porta gravida at eget metus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Etiam porta sem malesuada magna mollis euismod. Donec sed odio dui. </p>
          <p><a class="btn" href="#">View details &raquo;</a></p>
       </div>
        <div class="span4">
          <h2>Heading</h2>
          <p>Donec sed odio dui. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Vestibulum id ligula porta felis euismod semper. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus.</p>
          <p><a class="btn" href="#">View details &raquo;</a></p>
        </div>
      </div>
 	  -->
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