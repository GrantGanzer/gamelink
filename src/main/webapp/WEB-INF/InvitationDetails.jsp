<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${invitation.getGameName()}-InvitationDetails</title>
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

.nav h1, h3 {
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

.infocard h2, .infocard p, tr {
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

.card-header {
	color: #ff4500;
	background-color: #2c2c2c;
}

.card-body {
	background-color: #3c3c3c;
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
				<h1>${invitation.getGameName()}</h1>
			</div>
			<div class="nav2">
				<a class="btn btn-primary" href="/invitations">Back to all
					invitations</a> <a class="btn btn-primary" href="/logout">Logout</a>
			</div>
		</div>
		<div class="infocard">
			<c:choose>
				<c:when test="${invitation.getAdminuser().getId() == user.getId()}">
					<h2>Invitation Details</h2>
					<p>Game Name: ${invitation.getGameName()}</p>
					<p>Platform: ${invitation.getPlatform()}</p>
					<p>Gamertag: ${invitation.getAdminuser().getGamertag()}</p>
					<p>Availability: ${invitation.getAvailablity()}</p>
					<p>Description: ${invitation.getDescription()}</p>
					<p>Posted By: You</p>
					<p>
						<a class="btn btn-primary"
							href="/invitations/edit/${invitation.getId()}">Edit</a> <a
							class="btn btn-primary"
							href="/invitations/delete/${invitation.getId()}">Delete</a>
					</p>
					<div class="guestinfo">
						<h2>Players Interested</h2>
						<table class="table table-bordered">
							<thead>
								<tr>
									<th scope="col">First Name</th>
									<th scope="col">Message</th>
									<th scope="col">Confirm</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="reply" items="${replylist}">
									<c:if test="${reply.getConfirmed() == false}">
										<tr>
											<td>${reply.getUser().getFirstName()}</td>
											<td>${reply.getMessage()}</td>
											<td><form:form
													action="/invitations/reply/confirm/${reply.getId()}/${reply.getInvitation().getId()}"
													method="post" modelAttribute="Reply">
													<input type="hidden" name="_method" value="put">
													<form:input class="form-control" type="hidden"
														name="userId" path="confirmed" id="confirmed"
														value="${true}" />
													<button class="btn btn-primary" type="submit">Confirm</button>
												</form:form></td>
										</tr>
									</c:if>
								</c:forEach>
							</tbody>
						</table>
						<h2>Confirmed Players</h2>
						<table class="table table-bordered">
							<thead>
								<tr>
									<th scope="col">First Name</th>
									<th scope="col">Gamertag</th>
									<th scope="col">Message</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="reply" items="${replylist}">
									<c:if test="${reply.getConfirmed() == true}">
										<tr>
											<td>${reply.getUser().getFirstName()}</td>
											<td>${reply.getUser().getGamertag()}</td>
											<td>${reply.getMessage()}</td>
										</tr>
									</c:if>
								</c:forEach>
							</tbody>
						</table>
						<p>Total Gamers RSVP'd: ${invitation.getReplies().size()}</p>
					</div>
				</c:when>
				<c:otherwise>
					<h2>Invitation Details</h2>
					<p>Game Name: ${invitation.getGameName()}</p>
					<p>Platform: ${invitation.getPlatform()}</p>
					<c:if test="${confirmed == true}">
						<p>Gamertag: ${invitation.getAdminuser().getGamertag()}</p>
					</c:if>
					<p>Availability: ${invitation.getAvailablity()}</p>
					<p>Description: ${invitation.getDescription()}</p>
					<p>Posted By: ${invitation.getAdminuser().getFirstName()}</p>
					<div class="card border-dark mb-3" style="max-width: 18rem;">
						<div class="card-header">Join the Game</div>
						<div class="card-body">
							<p>To join, type your availability below.
								${invitation.getAdminuser().getFirstName()} will confirm your
								request if they'd like to play!</p>
						</div>
					</div>
					<c:choose>
						<c:when test="${replied == false && confirmed == false}">
							<form:form
								action="/invitations/reply/${invitation.getId()}/${user.getId()}"
								method="post" modelAttribute="Reply">
								<div class="form-group">
									<form:label for="message" path="message">Tell ${invitation.getAdminuser().getFirstName()} when you'll be available:</form:label>
									<form:textarea class="form-control" id="message" path="message"
										rows="5" />
									<form:errors class="errors" path="message"
										cssClass="text-danger" />
								</div>
								<button class="btn btn-primary" type="submit">Create a
									Reply</button>
							</form:form>
						</c:when>
						<c:when test="${replied == true && confirmed == false}">
							<h2>You've already sent a reply... it's still being
								confirmed</h2>
						</c:when>
						<c:otherwise>
							<h2>Your reply has been confirmed! See you in the game!</h2>
							<h3>Confirmed Players</h3>
							<p>(Feel free to add the other players confirmed for this
								invitation)</p>
							<table class="table table-bordered">
								<thead>
									<tr>
										<th scope="col">First Name</th>
										<th scope="col">Gamertag</th>
										<th scope="col">Message</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="reply" items="${replylist}">
										<c:if test="${reply.getConfirmed() == true}">
											<tr>
												<td>${reply.getUser().getFirstName()}</td>
												<td>${reply.getUser().getGamertag()}</td>
												<td>${reply.getMessage()}</td>
											</tr>
										</c:if>
									</c:forEach>
								</tbody>
							</table>
						</c:otherwise>
					</c:choose>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</body>
</html>