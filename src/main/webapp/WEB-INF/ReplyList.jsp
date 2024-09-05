<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Gamelink Guest List</title>
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet" href="/css/main.css" />
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
	padding: 20px;
}

.navcontainer {
	display: flex;
	justify-content: space-between;
	align-items: center;
	background-color: #2c2c2c;
	padding: 15px;
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
	margin-bottom: 30px;
}

.nav h1 {
	font-size: 1.5rem;
	margin: 0;
	color: #ff4500;
}

.btn-primary {
	background-color: #ff4500;
	border: none;
	font-size: 1rem;
}

.btn-primary:hover {
	background-color: #ff6347;
}

.guestinfo {
	margin-top: 30px;
}

table {
	width: 100%;
	margin-bottom: 20px;
}

th, td {
	padding: 10px;
	text-align: left;
}

th {
	background-color: #2c2c2c;
	color: #ff4500;
}

td {
	background-color: #2c2c2c;
	color: #d3d3d3;
}

.confirm-btn {
	background-color: #32cd32;
	border: none;
	padding: 5px 10px;
	color: white;
	cursor: pointer;
	font-size: 0.9rem;
}

.confirm-btn:hover {
	background-color: #3cb371;
}
</style>
</head>
<body>
	<div class="appcontainer">
		<div class="navcontainer">
			<div class="nav">
				<h1>${invitation.getGameName()}Guest List</h1>
			</div>
			<div class="nav2">
				<a class="btn btn-primary" href="/invitations">Back to all
					invitations</a> <a class="btn btn-primary" href="/logout">Logout</a>
			</div>
		</div>
		<div class="guestinfo">
			<h2>Players Interested</h2>
			<table class="table table-striped table-bordered">
				<thead>
					<tr>
						<th scope="col">First Name</th>
						<th scope="col">Last Name</th>
						<th scope="col">Confirm</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="user" items="${guestlist}">
						<tr>
							<td>${user.getFirstName()}</td>
							<td>${user.getLastName()}</td>
							<td>
								<form action="/invitations/confirm" method="post">
									<input type="hidden" name="userId" value="${user.getId()}">
									<input type="hidden" name="invitationId"
										value="${invitation.getId()}">
									<button type="submit" class="confirm-btn">Confirm</button>
								</form>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<h2>Confirmed Players</h2>
			<table class="table table-striped table-bordered">
				<thead>
					<tr>
						<th scope="col">First Name</th>
						<th scope="col">Last Name</th>
						<th scope="col">Email</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="user" items="${invitation.getRepliesfinal()}">
						<tr>
							<td>${user.getFirstName()}</td>
							<td>${user.getLastName()}</td>
							<td>${user.getEmail()}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<p>Total Gamers RSVP'd: ${invitation.getRepliesfinal().size()}</p>
		</div>
	</div>
</body>
</html>