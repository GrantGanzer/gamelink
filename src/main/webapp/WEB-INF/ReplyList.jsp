<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
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
				<h1>${show.getName()}Guest List...</h1>
			</div>
			<div class="nav2">
				<a class="btn btn-primary" href="/shows">Back to all shows</a> <a
					class="btn btn-primary" href="/logout">Logout</a>
			</div>
		</div>
		<div class="guestinfo">
			<h2>Payment not confirmed</h2>
			<table class="table table-striped table-bordered">
				<thead>
					<tr>
						<th scope="col">First Name</th>
						<th scope="col">Last Name</th>
						<th scope="col">Paid?</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="attendee" items="${guestlist}">
						<tr>
							<td>${attendee.getFirstName()}</td>
							<td>${attendee.getLastName()}</td>
							<td><div id="paid">
									<a class="btn btn-primary"
										href="/shows/confirm/${show.getId()}/${attendee.getId()}">Confirm
										Guest</a>
								</div></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<h2>Payment confirmed</h2>
			<table class="table table-striped table-bordered">
				<thead>
					<tr>
						<th scope="col">First Name</th>
						<th scope="col">Last Name</th>
						<th scope="col">Email</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="attendee" items="${finalguestlist}">
						<tr>
							<td>${attendee.getFirstName()}</td>
							<td>${attendee.getLastName()}</td>
							<td>${attendee.getEmail()}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<p>Total tickets sold: ${show.getFinalguestlist().size()}</p>
			<p>Revenue: $${show.getFinalguestlist().size() * show.getPrice()}</p>
		</div>
	</div>
</body>
</html>