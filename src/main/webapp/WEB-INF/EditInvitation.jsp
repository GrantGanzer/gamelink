<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit ${invitation.getGameName()} - Invitation Details</title>
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet" href="/css/main.css" />
<script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
<style>
body {
	background-color: #1b1b1b;
	color: #f0f0f0;
	font-family: 'Press Start 2P', cursive;
	margin: 0;
	padding: 0;
	min-height: 100vh;
	display: flex;
	flex-direction: column;
}

.appcontainer {
	max-width: 800px;
	margin: 50px auto;
	padding: 20px;
	background-color: #1c1c1c;
	border-radius: 10px;
	box-shadow: 0 0 20px rgba(0, 0, 0, 0.7);
}

.navcontainer {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 30px;
}

.nav h1 {
	font-size: 2em;
	color: #ff4500;
}

.nav2 a {
	margin-left: 10px;
	color: #ff4500;
	background-color: #333333;
	border: 1px solid #ff4500;
}

.nav2 a:hover {
	background-color: #ff4500;
	color: #ffffff;
}

.infocard h2, .infocard p {
	color: #ff4500;
}

.infocard {
	background-color: #333333;
	padding: 20px;
	border-radius: 10px;
}

.infocard a {
	margin-top: 10px;
	color: #ff4500;
	background-color: #444444;
	border: 1px solid #ff4500;
}

.infocard a:hover {
	background-color: #ff4500;
	color: #ffffff;
}

.form-group label {
	color: #ff4500;
}

.form-group input {
	background-color: #2c2c2c;
	color: #f0f0f0;
	border: 1px solid #ff4500;
}

.form-group input:focus {
	background-color: #3c3c3c;
	color: #ffffff;
}

.btn-primary {
	background-color: #ff4500;
	border: none;
}

.btn-primary:hover {
	background-color: #ff6347;
}
</style>
</head>
<body>
	<div class="appcontainer">
		<div class="navcontainer">
			<div class="nav">
				<h1>Edit Invitation for ${invitation.getGameName()}</h1>
			</div>
			<div class="nav2">
				<a class="btn btn-primary" href="/invitations">Back to all
					invitations</a> <a class="btn btn-primary" href="/logout">Logout</a>
			</div>
		</div>
		<div class="infocard">
			<h2>Edit Invitation Details</h2>
			<form:form action="/invitations/edit/${invitation.getId()}"
				method="post" modelAttribute="Invitation">
				<input type="hidden" name="_method" value="put">

				<div class="form-group">
					<form:label path="gameName">Game Name:</form:label>
					<form:input class="form-control" id="gameName" type="text"
						path="gameName" value="${invitation.getGameName()}" />
					<form:errors class="errors" path="gameName" />
				</div>

				<div class="form-group">
					<form:label path="availablity">Availability:</form:label>
					<form:input class="form-control" id="availablity" type="text"
						path="availablity" value="${invitation.getAvailablity()}" />
					<form:errors class="errors" path="availablity" />
				</div>

				<div class="form-group">
					<form:label path="platform">Platform:</form:label>
					<form:input class="form-control" id="platform" type="text"
						path="platform" value="${invitation.getPlatform()}" />
					<form:errors class="errors" path="platform" />
				</div>

				<div class="form-group">
					<form:label path="description">Description:</form:label>
					<form:input class="form-control" rows="5" cols="60" type="text"
						path="description" id="description"
						value="${invitation.getDescription()}" />
					<form:errors class="errors" path="description" />
				</div>

				<button class="btn btn-primary" type="submit">Update</button>
			</form:form>
		</div>
	</div>
</body>
</html>