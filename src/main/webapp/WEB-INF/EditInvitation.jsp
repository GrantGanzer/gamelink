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
				<h1>You can change the show... but the show must go on</h1>
			</div>
			<div class="nav2">
				<a class="btn btn-primary" href="/shows">Back to all shows...</a> <a
					class="btn btn-primary" href="/logout">Logout</a>
			</div>
		</div>
		<div class="maincontent">
			<form:form action="/shows/edit/${show.getId()}" method="post"
				modelAttribute="Show">
				<input type="hidden" name="_method" value="put">
				<div class="form-group">
					<form:label class="input-group-text" path="name">Show Name:</form:label>
					<form:input class="form-control" id="name" type="text" path="name"
						value="${showedits.getName()}" />
					<form:errors class="errors" path="name" />
				</div>
				<div class="form-group">
					<form:label class="input-group-text" path="showdate">Show Date:</form:label>
					<form:input class="form-control" id="date" type="date"
						path="showdate" value="${showedits.getShowdate()}" />
					<form:errors class="errors" path="showdate" />
				</div>
				<div class="form-group">
					<form:label class="input-group-text" path="venue">Venue Name:</form:label>
					<form:input class="form-control" id="venue" type="text"
						path="venue" value="${showedits.getVenue()}" />
					<form:errors class="errors" path="venue" />
				</div>
				<div class="form-group">
					<form:label class="input-group-text" path="address">Venue Address:</form:label>
					<form:input class="form-control" id="address" type="text"
						path="address" value="${showedits.getAddress()}" />
					<form:errors class="errors" path="address" />
				</div>
				<div class="form-group">
					<form:label class="input-group-text" path="price">Ticket Price:</form:label>
					<div class="input-group-prepend">
						<label class="input-group-text" id="ticketprice">$</label>
					</div>
					<form:input class="form-control" id="price" type="number"
						path="price" value="${showedits.getPrice()}" />
					<form:errors class="errors" path="price" />
				</div>
				<div class="form-group">
					<form:label class="input-group-text" path="payurl">Payment Link:</form:label>
					<form:input class="form-control" id="payurl" type="text"
						path="payurl" value="${showedits.getPayurl()}" />
					<form:errors class="errors" path="payurl" />
				</div>
				<div class="form-group">
					<form:label class="input-group-text" path="description">Show Description:</form:label>
					<form:errors class="errors" path="description" />
				</div>
				<div class="form-group">
					<form:input class="form-control" rows="5" cols="60" type="text"
						path="description" id="description"
						value="${showedits.getDescription()}" />
				</div>
				<button class=" btn btn-primary" type="submit">Update</button>
			</form:form>
		</div>
	</div>
</body>
</html>