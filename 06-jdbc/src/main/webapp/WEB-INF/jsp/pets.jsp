<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
      table#pets-table tbody tr.pet td {
      	cursor: pointer;
      }
      table#pets-table.table-striped tbody tr.pet.active td {
      	font-weight: regular;
      	background-image: -webkit-linear-gradient(top, whiteSmoke 0%,#EEE 100%);
      	color: #08C;
      }
    </style>
    <link href="resources/css/bootstrap-responsive.css" rel="stylesheet">
    <link href="resources/css/datepicker.css" rel="stylesheet">

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
              <li class="active"><a href="pets">Pets</a></li>
              <li><a href="events">Events</a></li>
              <li><a href="changelog">Changelog</a></li>
              <li><a href="schema">Schema</a></li>
            </ul>
          </div><!--/.nav-collapse -->
        </div>
      </div>
    </div>

    <div class="container">

<div class="page-header">
<h1>Pets</h1>
</div>

      <div class="row">
        <div class="span12">
          <table id="pets-table" class="table table-bordered table-striped">
          <thead>
          <tr>
            <th style="padding-right:0px"></th>
            <th>Name</th>
            <th>Owner</th>
            <th>Species</th>
            <th>Sex</th>
            <th>Birth</th>
            <th>Death</th>
          </tr>
          </thead>
          <tbody>
          <c:if test="${fn:length(pets)>0}">
			<c:forEach items="${pets}" var="pet">
				<tr class="pet">
					<td style="padding-right:0px;padding-left:0;text-align:center;"><input type='radio' style="margin:0;padding:0"></td>
					<td class="name">${pet.name}</td>
					<td class="owner">${pet.owner}</td>
					<td class="species">${pet.species}</td>
					<td class="sex">${pet.sex}</td>
					<td class="birth">${pet.birth}</td>
					<td class="death">${pet.death}</td>
				</tr>
			</c:forEach>
		  </c:if>
		  <c:if test="${fn:length(pets)==0}">
		  <tr><td colspan="7">There are no pets in the database.</tr>
		  </c:if>
          </tbody>
          </table>

<p>
<a id="add-pet-btn" class="btn btn-primary" data-toggle="modal" href="#modal-add-pet">Add pet &raquo;</a> 
<a id="remove-pet-btn" class="btn" data-toggle="modal" href="#modal-remove-pet" disabled>Remove pet &raquo;</a> 
<a id="edit-pet-btn" class="btn"  data-toggle="modal" href="#modal-edit-pet" disabled>Edit pet &raquo;</a>
</p>          

        </div>
        
        </div><!-- /row -->
 	  
      <hr>

      <footer>
        <p>&copy; ACME 2012</p>
      </footer>

    </div> <!-- /container -->

<div id="modal-remove-pet" class="modal pet remove" style="display:none;">
  <div class="modal-header">
    <button class="close" data-dismiss="modal">×</button>
    <h3>Remove pet</h3>
  </div>
  <div class="modal-body">
    <p>Are you sure you want to remove <span class="pet-name"></span>?</p>
  	<form action="pets/remove" method="POST">
		<input id="name" name="name" type="hidden">
	</form>
  </div>
  <div class="modal-footer">
    <a href="#" data-dismiss="modal" class="btn">Cancel</a>
    <a href="#" class="btn btn-primary remove">Remove</a>
  </div>  
</div>

<div id="modal-add-pet" class="modal pet add" style="display:none;">
  
  <div class="modal-header">
    <button class="close" data-dismiss="modal">×</button>
    <h3>Add pet</h3>
  </div>
  <div class="modal-body">
  
<form class="form-horizontal" action="pets/add" method="POST">
        <fieldset>
          <div class="control-group">
            <label class="control-label" for="name">Name</label>
            <div class="controls">
              <input id="name" name="name" type="text" class="input-xlarge">
            </div>
          </div>
          <div class="control-group">
            <label class="control-label" for="owner">Owner</label>
            <div class="controls">
              <input id="owner" name="owner" type="text" class="input-xlarge">
            </div>
          </div>          
          <div class="control-group">
            <label class="control-label" for="species">Species</label>
            <div class="controls">
              <select id="species" name="species">
                <option value="bird">Bird</option>
                <option value="cat">Cat</option>
                <option value="dog">Dog</option>
                <option value="snake">Snake</option>
                <option value="hamster">Hamster</option>
              </select>
            </div>
          </div>          
          <div class="control-group">
            <label class="control-label" for="sex">Sex</label>
            <div class="controls">
              <select id="sex" name="sex">
                <option value="m">Male</option>
                <option value="f">Female</option>
              </select>
            </div>
          </div>
          <div class="control-group">
            <label class="control-label" for="birth">Birth</label>
            <div class="controls">
			  <div id="birth" name="birth" class="input-append date" data-date="2012-12-02" data-date-format="yyyy-mm-dd">
                <input type="text" class="input-xlarge">
                <span class="add-on" style="margin-left:-5px;"><i class="icon-th"></i></span>
              </div>
            </div>
          </div>          
          <div class="control-group">
            <label class="control-label" for="death">Death</label>
            <div class="controls">
			  <div id="death" name="death" class="input-append date" data-date="2012-12-02" data-date-format="yyyy-mm-dd">
                <input type="text"  class="input-xlarge">
                <span class="add-on" style="margin-left:-5px;"><i class="icon-th"></i></span>
              </div>
            </div>
          </div>          
        </fieldset>
      </form>
  </div>
  <div class="modal-footer">
    <a href="#" data-dismiss="modal" class="btn">Cancel</a>
    <a href="#" class="btn btn-primary add">Save changes</a>
  </div>
</div>

<div id="modal-edit-pet" class="modal pet edit" style="display:none;">
  
  <div class="modal-header">
    <button class="close" data-dismiss="modal">×</button>
    <h3>Edit pet</h3>
  </div>
  <div class="modal-body">
  
<form class="form-horizontal" action="pets/edit" method="POST">
		<input id="oldname" name="oldname" type="hidden">
        <fieldset>
          <div class="control-group">
            <label class="control-label" for="name">Name</label>
            <div class="controls">
              <input id="name" name="name" type="text" class="input-xlarge">
            </div>
          </div>
          <div class="control-group">
            <label class="control-label" for="owner">Owner</label>
            <div class="controls">
              <input id="owner" name="owner" type="text" class="input-xlarge">
            </div>
          </div>          
          <div class="control-group">
            <label class="control-label" for="species">Species</label>
            <div class="controls">
              <select id="species" name="species">
                <option value="bird">Bird</option>
                <option value="cat">Cat</option>
                <option value="dog">Dog</option>
                <option value="snake">Snake</option>
                <option value="hamster">Hamster</option>
              </select>
            </div>
          </div>          
          <div class="control-group">
            <label class="control-label" for="sex">Sex</label>
            <div class="controls">
              <select id="sex" name="sex">
                <option value="m">Male</option>
                <option value="f">Female</option>
              </select>
            </div>
          </div>
          <div class="control-group">
            <label class="control-label" for="birth">Birth</label>
            <div class="controls">
			  <div class="input-append date" data-date="2012-12-02" data-date-format="yyyy-mm-dd">
                <input id="birth" name="birth" type="text" class="input-xlarge">
                <span class="add-on" style="margin-left:-5px;"><i class="icon-th"></i></span>
              </div>
            </div>
          </div>          
          <div class="control-group">
            <label class="control-label" for="death">Death</label>
            <div class="controls">
			  <div class="input-append date" data-date="2012-12-02" data-date-format="yyyy-mm-dd">
                <input id="death" name="death" type="text"  class="input-xlarge">
                <span class="add-on" style="margin-left:-5px;"><i class="icon-th"></i></span>
              </div>
            </div>
          </div>          
        </fieldset>
      </form>
  </div>
  <div class="modal-footer">
    <a href="#" data-dismiss="modal" class="btn">Cancel</a>
    <a href="#" class="btn btn-primary edit">Save changes</a>
  </div>
</div>

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
    <script src="resources/js/bootstrap-datepicker.js"></script>
    <script>
      $(function () {
    	  var selected = null;
    	  var row = {};
    	  $(".modal .date").datepicker();
    	  $(".modal.pet.remove").on("show", function () {
    		 $(this).find("span.pet-name").text(selected);
    		 $(this).find("form input:hidden").val(selected);
    	  });
    	  $(".modal.pet.edit").on("show", function () {
    		  $(this).find("#oldname").val(row.name);
    		  $(this).find("#name").val(row.name);
    		  $(this).find("#owner").val(row.owner);
    		  $(this).find("#species").val(row.species);
    		  $(this).find("#sex").val(row.sex);
    		  $(this).find("#birth").val(row.birth);
    		  $(this).find("#death").val(row.death);
     	  });
    	  $(".modal.pet.remove .btn.remove").click(function () {
    		  $(".modal.pet.remove form").submit();
    		  $(".modal.pet.remove").modal("hide");
    	  });
    	  $(".modal.pet.add .btn.add").click(function () {
    		  $(".modal.pet.add form").submit();
    		  $(".modal.pet.add").modal("hide");
    	  });
    	  $(".modal.pet.edit .btn.edit").click(function () {
    		  $(".modal.pet.edit form").submit();
    		  $(".modal.pet.edit").modal("hide");
    	  });
    	  $("#pets-table tr.pet td").click(function () {
    		$(this).closest("tbody").find("tr").removeClass("active");
    		$(this).closest("tbody").find("tr td:nth-of-type(1) input").attr("checked",false);
			$(this).closest("tr").addClass("active");
			$(this).closest("tr").find("td:nth-of-type(1) input").attr("checked",true);
			
			$tr = $(this).closest("tr")
			selected = $tr.find("td.name").text();
			row = {
				"name":$tr.find(".name").text(),
				"owner":$tr.find(".owner").text(),
				"species":$tr.find(".species").text(),
				"sex":$tr.find(".sex").text(),
				"birth":$tr.find(".birth").text(),
				"death":$tr.find(".death").text()
			};
			$("#remove-pet-btn").removeAttr("disabled");
			$("#edit-pet-btn").removeAttr("disabled");
    	  });
      });
    </script>
  </body>
</html>
