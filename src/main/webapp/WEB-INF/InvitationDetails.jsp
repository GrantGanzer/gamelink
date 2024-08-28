<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
				<h1>${show.getName()}</h1>
			</div>
			<div class="nav2">
				<a class="btn btn-primary" href="/shows">Back to all shows</a> <a
					class="btn btn-primary" href="/logout">Logout</a>
			</div>
		</div>
		<div class="infocard">
			<c:choose>
				<c:when test="${show.getAdminuser().getId() == user.getId()}">
					<h2>show details...</h2>
					<p>Show Name: ${show.getName()}</p>
					<p>Venue: ${show.getVenue()}</p>
					<p>Posted By: You</p>
					<p>Ticket Price: $ ${show.getPrice()}</p>
					<p>Show Date: ${show.getShowdateformatted()}</p>
					<p>Description: ${show.getDescription()}</p>
					<p>
						<a class="btn btn-primary" href="/shows/edit/${show.getId()}">Edit</a>
						<a class="btn btn-primary" href="/shows/delete/${show.getId()}">Delete</a>
						<a class="btn btn-primary" href="/shows/guestlist/${show.getId()}">Guest
							List</a>
					</p>
				</c:when>
				<c:otherwise>
					<h2>show details...</h2>
					<p>Show Name: ${show.getName()}</p>
					<p>Venue: ${show.getVenue()}</p>
					<p>Posted By: ${show.adminuser.getFirstName()}</p>
					<p>Show Date: ${show.getShowdateformatted()}</p>
					<p>Description: ${show.getDescription()}</p>
					<div class="card border-dark mb-3" style="max-width: 18rem;">
						<div class="card-header">How to get on the list...</div>
						<div class="card-body">
							<p>Ticket Price: $ ${show.getPrice()}</p>
							<p>
								Send ${show.adminuser.getFirstName()} $${show.getPrice()} <a
									href="${show.payurl}">here</a> and then click the rsvp button
								below... <br> Once they confirm your payment you'll be
								added to the guest list!
							</p>
						</div>
					</div>
					<c:choose>
						<c:when test="${rsvp == false && confirmed == false}">
							<a class="btn btn-primary"
								href="/shows/rsvp/${show.getId()}/${user.getId()}">Rsvp</a>
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${rsvp == true && confirmed == false}">
									<a class="btn btn-primary"
										href="/shows/rsvp/${show.getId()}/${user.getId()}">You've
										already sent an rsvp</a>
								</c:when>
								<c:otherwise>
									<h2 />Your
										ticket has been confirmed see you at the show!</h2>
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</body>
</html>