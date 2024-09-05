<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Gamelink Login</title>
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet" href="/css/main.css" />
<style>
body {
	background-color: #1b1b1b;
	color: #f0f0f0;
	font-family: 'Press Start 2P', cursive;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
	margin: 0;
}

.container {
	background: rgba(0, 0, 0, 0.7);
	padding: 30px;
	border-radius: 15px;
	text-align: center;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
}

.form-group label {
	color: #f0f0f0;
}

.btn-primary {
	background-color: #ff4500;
	border: none;
}

.btn-primary:hover {
	background-color: #ff6347;
}

.welcome {
	font-size: 2rem;
	margin-bottom: 20px;
}

.login-title {
	font-size: 1.5rem;
	margin: 20px 0;
}
</style>
</head>
<body>
	<div class="container">
		<h1 class="welcome">Welcome to Gamelink</h1>

		<h2 class="login-title">Create an Account</h2>
		<form:form action="/register" method="post" modelAttribute="newUser"
			class="form-horizontal">
			<div class="form-group">
				<form:label path="firstName">First Name</form:label>
				<form:input class="form-control" path="firstName" />
				<form:errors class="errors" path="firstName" />
			</div>
			<div class="form-group">
				<form:label path="lastName">Last Name</form:label>
				<form:input class="form-control" path="lastName" />
				<form:errors class="errors" path="lastName" />
			</div>
			<div class="form-group">
				<form:label path="gamertag">Gamer Tag</form:label>
				<form:input class="form-control" path="gamertag" />
				<form:errors class="errors" path="gamertag" />
			</div>
			<div class="form-group">
				<form:label path="email">Email</form:label>
				<form:input class="form-control" path="email" />
				<form:errors class="errors" path="email" />
			</div>
			<div class="form-group">
				<form:label path="password">Password</form:label>
				<form:input class="form-control" type="password" path="password" />
				<form:errors class="errors" path="password" />
			</div>
			<div class="form-group">
				<form:label path="confirm">Confirm Password</form:label>
				<form:input class="form-control" type="password" path="confirm" />
				<form:errors class="errors" path="confirm" />
			</div>
			<button type="submit" class="btn btn-primary btn-block">Sign
				Up</button>
		</form:form>

		<h2 class="login-title">Already Have an Account?</h2>
		<form:form action="/login" method="post" modelAttribute="newLogin"
			class="form-horizontal">
			<div class="form-group">
				<form:label path="email">Email</form:label>
				<form:input class="form-control" path="email" />
				<form:errors class="errors" path="email" />
			</div>
			<div class="form-group">
				<form:label path="password">Password</form:label>
				<form:input class="form-control" type="password" path="password" />
				<form:errors class="errors" path="password" />
			</div>
			<button type="submit" class="btn btn-primary btn-block">Log
				In</button>
		</form:form>
	</div>
</body>
</html>