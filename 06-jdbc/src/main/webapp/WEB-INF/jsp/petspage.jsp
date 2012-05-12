<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<h1>Pets</h1>

<table>
	<tr>
		<td width="50">Name</td>
		<td width="150">Owner</td>
		<td width="150">Species</td>
		<td width="50">Sex</td>
		<td width="50">Birth</td>
		<td width="50">Death</td>
	</tr>
	<c:forEach items="${pets}" var="pet">
		<tr>
			<td><c:out value="${pet.name}" /></td>
			<td><c:out value="${pet.owner}" /></td>
			<td><c:out value="${pet.species}" /></td>
			<td><c:out value="${pet.sex}" /></td>
			<td><c:out value="${pet.birth}" /></td>
			<td><c:out value="${pet.death}" /></td>
		</tr>
	</c:forEach>
</table>

<form method="POST" action="pets" enctype="application/x-www-form-urlencoded">
  <label for="name">Name:</label>
  <input id="name" type="text" name="name">
  <label for="owner">Owner:</label>
  <input id="owner" type="text" name="owner">
  <label for="species">Species:</label>
  <input id="species" type="text" name="species">
  <label for="sex">Sex:</label>
  <input id="sex" type="text" name="sex">
  <input type="submit" value="submit">
</form>

</body>
</html>