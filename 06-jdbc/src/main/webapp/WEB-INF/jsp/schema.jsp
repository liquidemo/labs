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
              <li><a href="home">Home</a></li>
              <li><a href="pets">Pets</a></li>
              <li><a href="events">Events</a></li>
              <li><a href="changelog">Changelog</a></li>
              <li class="active"><a href="schema">Schema</a></li>
            </ul>
          </div><!--/.nav-collapse -->
        </div>
      </div>
    </div>

    <div class="container-fluid">

<div class="row-fluid">

<div class="span3">
<div class="well sidebar-nav">
            <ul class="nav nav-list">
              <li class="nav-header">Tables</li>
<c:forEach items="${schema.tables}" var="table">
<c:if test="${table.type == 'table'}">
              <li><a href="#${table.name}">${table.name}</a></li>
</c:if>
</c:forEach>              
              <li class="nav-header">Views</li>
<c:forEach items="${schema.tables}" var="view">
<c:if test="${view.type == 'view'}">
              <li><a href="#${view.name}">${view.name}</a></li>
</c:if>
</c:forEach>              
            </ul>
          </div>
</div>

<div class="span9">

<div class="page-header">
<h1>Tables</h1>
</div>

<c:forEach items="${schema.tables}" var="table">
<c:if test="${table.type == 'table'}">
      <div class="row-fluid">
        <div >
	  <div style="position:relative;top:-30px;">
	  <a name="${table.name}">&nbsp;</a>
	  </div>
          
          <h2>${table.name}</h2>
          <p>${table.remarks}</p>
          <table class="table table-bordered table-striped ${table.name}">
          <thead>
          <tr>
            <th>Name</th>
            <th>Type</th>
            <th>Size</th>
            <th>Remark</th>
          </tr>
          </thead>
          <tbody>
			<c:forEach items="${table.columns}" var="column">
				<tr class="column ${column.name}">
					<td class="column-name">${column.name}</td>
					<td class="column-type">${column.type}</td>
					<td class="column-size">${column.size}</td>
					<td class="column-remarks">${column.remarks}</td>
				</tr>
			</c:forEach>
          </tbody>
          </table>
          
        </div>
        
        </div><!-- /row -->
        
        <div class="row-fluid">
        	<div class="well">
        	<h6>Primary Key</h6>
        	<h6>Foreign Keys</h6>
        	<h6>Indices</h6>
        	</div>
        </div>
</c:if>
</c:forEach>      

<div class="page-header">      
<h1>Views</h1>
</div>

<c:forEach items="${schema.tables}" var="table">
<c:if test="${table.type == 'view'}">
      <div class="row-fluid">
        <div>
          
          <h2><c:out value="${table.name}"/></h2>
          <p>${table.remarks}</p>
          <table class="table table-bordered table-striped">
          <thead>
          <tr>
            <th>Name</th>
            <th>Type</th>
            <th>Size</th>
            <th>Remark</th>
          </tr>
          </thead>
          <tbody>
			<c:forEach items="${table.columns}" var="column">
				<tr>
					<td><c:out value="${column.name}" /></td>
					<td><c:out value="${column.type}" /></td>
					<td><c:out value="${column.size}" /></td>
					<td><c:out value="${column.remarks}" /></td>
				</tr>
			</c:forEach>
          </tbody>
          </table>   
          
        </div>
        
        </div><!-- /row -->
</c:if>
</c:forEach>      
  	  
      <hr>

      <footer>
        <p>&copy; ACME 2012</p>
      </footer>

</div> <!-- /span9 -->
</div> <!-- /row -->


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

	<script>
	
	var schemas = ${schemajson};
	
	$(function () {
		var schema = schemas[1];
		$.each(schema.tables, function (index, table) {
			// highlight primary keys 
			if (table.primaryKey) {
				$.each(table.primaryKey.columns, function (index, column) {
					var selector = (".table.{table} .column.{column} .column-name"
					    .replace("{table}",table.name)
					    .replace("{column}",column));
					$(selector).css({"font-weight":"bold","color":"black"});
				});				
			}
			// highlight foreign keys 
			if (table.foreignKeys) {
				$.each(table.foreignKeys, function (index, foreignKey) {
					$.each(foreignKey.columns, function (index, column) {
						var selector = (".table.{table} .column.{column} .column-name"
						    .replace("{table}",table.name)
						    .replace("{column}",column.column));
						$(selector).css({"color":"blue"});
					});
				});				
			}
		});
	    
	});	    
	</script>

  </body>
</html>
