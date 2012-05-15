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
      td.outcome-column {
      text-align:center;
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
              <li><a href="excercises">Excercises</a></li>                           
              <li class="active"><a href="tests">Tests</a></li>
            </ul>
          </div><!--/.nav-collapse -->
        </div>
      </div>
    </div>

    <div class="container">

<div class="page-header">
<h1>Progress</h1>
</div>
      <div class="row">      
        <div class="span9">

	      	<div class="progress">
	      		<div class="bar" style="width:${progress}%;"></div>
	      	</div>

          <h2>Excercise 1 <small>Baseline</small></h2>
          <p>Create a baseline schema by generating a changelog from an existing database.</p>

          <table id="test-results" class="table table-bordered table-condensed">
          <thead>
          <tr>
            <th style="padding-right:0px;padding-left:0;text-align:center;width:0px;"></th>
            <th>Test Case</th>
            <th>Remark</th>
          </tr>
          </thead>
          <tbody>
			<c:forEach items="${results}" var="result">
			<c:if test="${result.description.testClass.simpleName == 'ExcerciseBaselineTest'}">
			<c:if test="${not result.passed}">
				<tr>
					<td class="outcome-column"><span class="label label-important">FAIL</span></td>
					<td class="test-column">${result.description.methodName}</td>
					<td>${result.failure.message}</td>
				</tr>
			</c:if>
			<c:if test="${result.passed}">
				<tr>
					<td class="outcome-column"><span class="label label-success">PASS</span></td>
					<td class="test-column">${result.description.methodName}</td>
					<td></td>
				</tr>
			</c:if>
			</c:if>
			</c:forEach>
			
          </tbody>
          </table>
          
        </div>

        </div><!-- /row -->

		<div class="row">
			<div class="span9">
				<h2>Excercise 2 <small>Update</small></h2>
				<p>Apply the generated changelog to an empty test database.</p>
				<table id="test-results" class="table table-bordered table-condensed">
					<thead>
						<tr>
							<th></th>
							<th>Test</th>
							<th>Remark</th>
						</tr>
					</thead>
					<tbody>
			<c:forEach items="${results}" var="result">
			<c:if test="${result.description.testClass.simpleName == 'ExcerciseUpdateTest'}">
			<c:if test="${not result.passed}">
				<tr>
					<td class="outcome-column"><span class="label label-important">FAIL</span></td>
					<td class="test-column">${result.description.methodName}</td>
					<td>${result.failure.message}</td>
				</tr>
			</c:if>
			<c:if test="${result.passed}">
				<tr>
					<td class="outcome-column"><span class="label label-success">PASS</span></td>
					<td class="test-column">${result.description.methodName}</td>
					<td></td>
				</tr>
			</c:if>
			</c:if>
			</c:forEach>
					
					</tbody>
				</table>
			</div>
		</div>

		<div class="row">
			<div class="span9">
				<h2>Excercise 3 <small>Data</small></h2>
				<p>Extract test data from the prod database and insert it to the test database.</p>
				<table id="test-results" class="table table-bordered table-condensed">
					<thead>
						<tr>
							<th></th>
							<th>Test</th>
							<th>Remark</th>
						</tr>
					</thead>
					<tbody>
			<c:forEach items="${results}" var="result">
			<c:if test="${result.description.testClass.simpleName == 'ExcerciseDataTest'}">
			<c:if test="${not result.passed}">
				<tr>
					<td class="outcome-column"><span class="label label-important">FAIL</span></td>
					<td class="test-column">${result.description.methodName}</td>
					<td>${result.failure.message}</td>
				</tr>
			</c:if>
			<c:if test="${result.passed}">
				<tr>
					<td class="outcome-column"><span class="label label-success">PASS</span></td>
					<td class="test-column">${result.description.methodName}</td>
					<td></td>
				</tr>
			</c:if>
			</c:if>
			</c:forEach>
					
					</tbody>
				</table>
			</div>
		</div>



		<div class="row">
			<div class="span9">
				<h2>Excercise 4 <small>Rename Column</small></h2>
				<p>Rename columns in PET and EVENT tables.</p>
				<table id="test-results" class="table table-bordered table-condensed">
				<thead>
					<tr>
						<th></th>
						<th>Test</th>
						<th>Remark</th>
					</tr>
				</thead>
				<tbody>
			<c:forEach items="${results}" var="result">
			<c:if test="${result.description.testClass.simpleName == 'ExcerciseRenameColumnTest'}">
			<c:if test="${not result.passed}">
				<tr>
					<td class="outcome-column"><span class="label label-important">FAIL</span></td>
					<td class="test-column">${result.description.methodName}</td>
					<td>${result.failure.message}</td>
				</tr>
			</c:if>
			<c:if test="${result.passed}">
				<tr>
					<td class="outcome-column"><span class="label label-success">PASS</span></td>
					<td class="test-column">${result.description.methodName}</td>
					<td></td>
				</tr>
			</c:if>
			</c:if>
			</c:forEach>
				
				</tbody>
				</table>
			</div>
		</div>



		<div class="row">
        <div class="span9">
          <h2>Excercise 5 <small>Constraints</small></h2>
          <p>Add primary and foreign key constraints to PET and EVENT tables.</p>
                    
          <table id="test-results" class="table table-bordered table-condensed">
          <thead>
          <tr>
            <th style="padding-right:0px;padding-left:0;text-align:center;width:0px;"></th>
            <th>Test</th>
            <th>Remark</th>
          </tr>
          </thead>
          <tbody>
			<c:forEach items="${results}" var="result">
			<c:if test="${result.description.testClass.simpleName == 'ExcerciseConstraintsTest'}">
			<c:if test="${not result.passed}">
				<tr>
					<td class="outcome-column"><span class="label label-important">FAIL</span></td>
					<td class="test-column">${result.description.methodName}</td>
					<td>${result.failure.message}</td>
				</tr>
			</c:if>
			<c:if test="${result.passed}">
				<tr>
					<td class="outcome-column"><span class="label label-success">PASS</span></td>
					<td class="test-column">${result.description.methodName}</td>
					<td></td>
				</tr>
			</c:if>
			</c:if>
			</c:forEach>
			
          </tbody>
          </table>
          
        </div>
		</div><!-- /row -->
		
		
		
		
		        
		<div class="row">
			<div class="span9">
				<h2>Excercise 6 <small>Create Table</small></h2>
				<p>Create a new OWNER table and populate it with data from the PET table.</p>
				<table id="test-results" class="table table-bordered table-condensed">
					<thead>
						<tr>
							<th></th>
							<th>Test</th>
							<th>Remark</th>
						</tr>
					</thead>
					<tbody>
			<c:forEach items="${results}" var="result">
			<c:if test="${result.description.testClass.simpleName == 'ExcerciseCreateTableTest'}">
			<c:if test="${not result.passed}">
				<tr>
					<td class="outcome-column"><span class="label label-important">FAIL</span></td>
					<td class="test-column">${result.description.methodName}</td>
					<td>${result.failure.message}</td>
				</tr>
			</c:if>
			<c:if test="${result.passed}">
				<tr>
					<td class="outcome-column"><span class="label label-success">PASS</span></td>
					<td class="test-column">${result.description.methodName}</td>
					<td></td>
				</tr>
			</c:if>
			</c:if>
			</c:forEach>
					
					</tbody>
				</table>
			</div>
		</div>













        


      <div class="row">
        <div class="span9">
          <h2>Excercise 7 <small>Lookup Table</small></h2>
          <p>Extract all the species and genders in the pet table into separate lookup tables.</p>
          <table id="test-results" class="table table-bordered table-condensed">
          <thead>
          <tr>
            <th style="padding-right:0px;padding-left:0;text-align:center;width:0px;"></th>
            <th>Test</th>
            <th>Remark</th>
          </tr>
          </thead>
          <tbody>
			<c:forEach items="${results}" var="result">
			<c:if test="${result.description.testClass.simpleName == 'ExcerciseLookupTableTest'}">
			<c:if test="${not result.passed}">
				<tr>
					<td class="outcome-column"><span class="label label-important">FAIL</span></td>
					<td class="test-column">${result.description.methodName}</td>
					<td>${result.failure.message}</td>
				</tr>
			</c:if>
			<c:if test="${result.passed}">
				<tr>
					<td class="outcome-column"><span class="label label-success">PASS</span></td>
					<td class="test-column">${result.description.methodName}</td>
					<td></td>
				</tr>
			</c:if>
			</c:if>
			</c:forEach>
			
          </tbody>
          </table>
          
        </div>

        </div><!-- /row -->
        
        
        
        
		<div class="row">
			<div class="span9">
				<h2>Excercise 8 <small>Views</small></h2>
				<p>Create a view for calculating the age of pets in the database.</p>
				<table id="test-results" class="table table-bordered table-condensed">
					<thead>
						<tr>
							<th></th>
							<th>Test</th>
							<th>Remark</th>
						</tr>
					</thead>
					<tbody>
			<c:forEach items="${results}" var="result">
			<c:if test="${result.description.testClass.simpleName == 'ExcerciseViewTest'}">
			<c:if test="${not result.passed}">
				<tr>
					<td class="outcome-column"><span class="label label-important">FAIL</span></td>
					<td class="test-column">${result.description.methodName}</td>
					<td>${result.failure.message}</td>
				</tr>
			</c:if>
			<c:if test="${result.passed}">
				<tr>
					<td class="outcome-column"><span class="label label-success">PASS</span></td>
					<td class="test-column">${result.description.methodName}</td>
					<td></td>
				</tr>
			</c:if>
			</c:if>
			</c:forEach>
					
					</tbody>
				</table>
			</div>
		</div>        

		<div class="row">
			<div class="span9">
				<h2>Excercise 9 <small>Surrogate Key</small></h2>
				<p>Introduce an auto incremented ID column to the PET table.</p>
				<table id="test-results" class="table table-bordered table-condensed">
				<thead>
					<tr>
						<th></th>
						<th>Test</th>
						<th>Remark</th>
					</tr>
				</thead>
				<tbody>
			<c:forEach items="${results}" var="result">
			<c:if test="${result.description.testClass.simpleName == 'ExcerciseSurrogateKeyTest'}">
			<c:if test="${not result.passed}">
				<tr>
					<td class="outcome-column"><span class="label label-important">FAIL</span></td>
					<td class="test-column">${result.description.methodName}</td>
					<td>${result.failure.message}</td>
				</tr>
			</c:if>
			<c:if test="${result.passed}">
				<tr>
					<td class="outcome-column"><span class="label label-success">PASS</span></td>
					<td class="test-column">${result.description.methodName}</td>
					<td></td>
				</tr>
			</c:if>
			</c:if>
			</c:forEach>				
				</tbody>
				</table>
			</div>
		</div>
		
	
		<div class="row">
			<div class="span9">
				<h2>Excercise 10 <small>Rollback</small></h2>
				<p>Go through all change sets and make sure that it is possible to roll them back.</p>
				<table id="test-results" class="table table-bordered table-condensed">
				<thead>
					<tr>
						<th></th>
						<th>Test</th>
						<th>Remark</th>
					</tr>
				</thead>
				<tbody>
			<c:forEach items="${results}" var="result">
			<c:if test="${result.description.testClass.simpleName == 'ExcerciseRollbackTest'}">
			<c:if test="${not result.passed}">
				<tr>
					<td class="outcome-column"><span class="label label-important">FAIL</span></td>
					<td class="test-column">${result.description.methodName}</td>
					<td>${result.failure.message}</td>
				</tr>
			</c:if>
			<c:if test="${result.passed}">
				<tr>
					<td class="outcome-column"><span class="label label-success">PASS</span></td>
					<td class="test-column">${result.description.methodName}</td>
					<td></td>
				</tr>
			</c:if>
			</c:if>
			</c:forEach>				
				</tbody>
				</table>
			</div>
		</div>

		<div class="row">
			<div class="span9">
				<h2>Excercise 11 <small>Update Prod</small></h2>
				<p>Run the completed changelog on the prod database.</p>
				<table id="test-results" class="table table-bordered table-condensed">
				<thead>
					<tr>
						<th></th>
						<th>Test</th>
						<th>Remark</th>
					</tr>
				</thead>
				<tbody>
			<c:forEach items="${results}" var="result">
			<c:if test="${result.description.testClass.simpleName == 'ExcerciseUpdateProdTest'}">
			<c:if test="${not result.passed}">
				<tr>
					<td class="outcome-column"><span class="label label-important">FAIL</span></td>
					<td class="test-column">${result.description.methodName}</td>
					<td>${result.failure.message}</td>
				</tr>
			</c:if>
			<c:if test="${result.passed}">
				<tr>
					<td class="outcome-column"><span class="label label-success">PASS</span></td>
					<td class="test-column">${result.description.methodName}</td>
					<td></td>
				</tr>
			</c:if>
			</c:if>
			</c:forEach>				
				</tbody>
				</table>
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
    <script src="resources/js/jquery.tmpl.js"></script>
    <script src="resources/js/prettify.js"></script>
	<script>
		$(function () {
			prettyPrint();	
			$("table td.outcome-column").width("60px");
			$("table td.test-column").width("300px");
		});
	</script>

  </body>
</html>
