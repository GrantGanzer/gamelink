<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet" href="/css/main.css" />
<script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
</head>
<body>
	<div class="appcontainer">
		<div class="navcontainer">
			<div class="nav">
				<h1>Welcome to the Gamelink app, ${user.getFirstName()}!</h1>
			</div>
			<div class="nav2">
				<a class="btn btn-primary" href="/invitations/new">Create your own
					invitation to play...</a> <a class="btn btn-primary" href="/logout">Logout</a>
			</div>
		</div>
		<div class="invitationcards">
			<div class="row row-cols-3 row-cols-md-3 g-4">
				<c:forEach var="invitation" items="${invitations}">
					<div class="col">
						<div class="card border-dark mb-3" style="max-width: 18rem;">
							<div class="card-header">
								<a href="/shows/${invitations.getId()}">${invitations.getGameName()}</a>
							</div>
							<div class="card-body">
								<p>
									Platform:
									<c:out value="${invitation.getPlatform()}"></c:out>
								</p>
								<p>
									Availablity:
									<c:out value="${invitation.getAvailablity()}"></c:out>
								</p>
								<p>
									Gamertag:
									<c:out value="${invitation.getGamertag()}"></c:out>
								</p>
								<p>
									Description:
									<c:out value="${invitation.getDescription()}"></c:out>
								</p>
							</div>
							<div class="card-footer">
								<c:choose>
									<c:when test="${invitation.getAdminuser().getId() == user.getId()}">
										<p>
											<a class="btn btn-primary" href="/invitations/edit/${invitation.getId()}">Edit</a><a
												class="btn btn-primary" href="/invitations/delete/${invitation.getId()}">Delete</a><a
												class="btn btn-primary"
												href="/invitations/replies/${invitation.getId()}">Replies</a>
										</p>
									</c:when>
									<c:otherwise>
										<c:choose>
											<c:when test="${invitation.getRepliesfinal().contains(user)}">
												<p>Your reply has been confirmed! see you at the show</p>
											</c:when>
											<c:otherwise>
												<c:choose>
													<c:when test="${invitation.getReplies().contains(user)}">
														<p>Your reply is still being confirmed... check back
															later</p>
													</c:when>
													<c:otherwise>
														<p>
															<a class="btn btn-primary" href="/invitations/reply/${invitation.getId()}/${user.getId()}">Id like to play</a>
														</p>
													</c:otherwise>
												</c:choose>
											</c:otherwise>
										</c:choose>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
</body>
</html>