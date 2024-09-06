<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Gamelink Dashboard</title>
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

.invitationcards {
	display: flex;
	flex-wrap: wrap;
	gap: 20px;
	justify-content: center;
}

.card {
	background-color: #2c2c2c;
	border: 2px solid #ff4500;
	border-radius: 8px;
	overflow: hidden;
	max-width: 300px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.7);
}

.card-header, .card-footer {
	background-color: #2c2c2c;
	color: #f0f0f0;
	text-align: center;
	font-size: 1.1rem;
	padding: 10px;
}

.card-body {
	padding: 15px;
	color: #d3d3d3;
}

.card-body p {
	margin-bottom: 10px;
}
</style>
</head>
<body>
	<div class="appcontainer">
		<div class="navcontainer">
			<div class="nav">
				<h1>Welcome to Gamelink, ${user.getFirstName()}!</h1>
			</div>
			<div class="nav2">
				<a class="btn btn-primary" href="/invitations/new">Create
					Invitation</a> <a class="btn btn-primary" href="/logout">Logout</a>
			</div>
		</div>

		<div class="invitationcards">
			<c:forEach var="invitation" items="${invitations}">
				<div class="card">
					<div class="card-header">
						<a href="/invitations/${invitation.getId()}"
							style="color: #ff4500;">${invitation.getGameName()}</a>
					</div>
					<div class="card-body">
						<p>
							Platform:
							<c:out value="${invitation.getPlatform()}" />
						</p>
						<p>
							Availability:
							<c:out value="${invitation.getAvailablity()}" />
						</p>
						<p>
							Description:
							<c:out value="${invitation.getDescription()}" />
						</p>
					</div>
					<div class="card-footer">
						<c:choose>
							<c:when
								test="${invitation.getAdminuser().getId() == user.getId()}">
								<a class="btn btn-primary"
									href="/invitations/edit/${invitation.getId()}">Edit</a>
								<a class="btn btn-primary"
									href="/invitations/delete/${invitation.getId()}">Delete</a>
							</c:when>
							<c:otherwise>
								<a class="btn btn-primary"
									href="/invitations/${invitation.getId()}">I'd like to play</a>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
</body>
</html>