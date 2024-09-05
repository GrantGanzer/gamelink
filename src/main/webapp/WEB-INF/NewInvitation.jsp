<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create a New Invitation</title>
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

.form-group label {
	font-size: 1.2em;
	color: #ff4500;
}

.form-group input, .form-group textarea {
	background-color: #333333;
	color: #ffffff;
	border: 1px solid #555555;
}

.form-group input:focus, .form-group textarea:focus {
	background-color: #444444;
	border-color: #ff4500;
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
				<h1>Create a New Invitation</h1>
			</div>
			<div class="nav2">
				<a class="btn btn-primary" href="/invitations">Dashboard</a> <a
					class="btn btn-primary" href="/logout">Logout</a>
			</div>
		</div>
		<div class="maincontent">
			<form:form action="/invitations/new" method="post"
				modelAttribute="Invitation">
				<div class="form-group">
					<form:label for="name" path="gameName">Game Name:</form:label>
					<form:input class="form-control" id="name" path="gameName" />
					<form:errors class="errors" path="gameName" cssClass="text-danger" />
				</div>
				<div class="form-group">
					<form:label for="availablity" path="availablity">Availability:</form:label>
					<form:input class="form-control" id="availablity"
						path="availablity" />
					<form:errors class="errors" path="availablity"
						cssClass="text-danger" />
				</div>
				<div class="form-group">
					<form:label for="platform" path="platform">Platform:</form:label>
					<form:input class="form-control" id="platform" path="platform" />
					<form:errors class="errors" path="platform" cssClass="text-danger" />
				</div>
				<div class="form-group">
					<form:label for="description" path="description">Game Description:</form:label>
					<form:textarea class="form-control" id="description"
						path="description" rows="5" />
					<form:errors class="errors" path="description"
						cssClass="text-danger" />
				</div>
				<button class="btn btn-primary" type="submit">Create
					Invitation</button>
			</form:form>
		</div>
	</div>
</body>
</html>