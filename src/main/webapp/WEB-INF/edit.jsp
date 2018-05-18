<!DOCTYPE html>
<html>
<head>
	<title>Foodtrucks</title>
	<meta charset="UTF-8">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
	<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
	<link type="text/css" rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bulma/0.7.1/css/bulma.min.css">
	<link type="text/css" rel="stylesheet" href="/css/style.css">
	<script defer src="https://use.fontawesome.com/releases/v5.0.6/js/all.js"></script>
</head>
<body>
	<div class="container">
		
		<div class="hero is-dark">
            <div class="hero-body is-bold">
                <h1 class="title">
                	<span><i class="fas fa-truck"></i></span>
                	<span>Foodtrucks</span>
                </h1>
            </div>
        </div>
        
        <div class="tabs is-medium is-centered">
        	<ul>
            	<li>
                	<a href="/">
                    	<span class="icon is-small">
                        	<i class="fas fa-table"></i>
                        </span>
                        <span>Dashboard</span>
                    </a>
                </li>
                <c:if test="${user == null}">
                <li>
                	<a href="/sign_up">
                    	<span class="icon is-small">
                        	<i class="fas fa-user-plus"></i>
                        </span>
                        <span>Sign up</span>
                    </a>
                </li>
                <li>
                    <a href="/sign_in">
                        <span class="icon is-small">
                            <i class="fas fa-sign-in-alt"></i>
                        </span>
                        <span>Sign in</span>
                    </a>
                </li>
                </c:if>
                <c:if test="${user != null}">
                <li>
                	<a href="/foodtrucks/new">
                    	<span class="icon is-small">
                        	<i class="fas fa-truck"></i>
                        </span>
                        <span>Add a truck</span>
                    </a>
                </li>
                <li>
                	<p>
                		<span class="icon is-small">
                        	<i class="fas fa-user"></i>
                        </span>
                		<span>${user.username}</span>
                	</p>
                </li>
                <li>
                	<a href="/logout">
                    	<span class="icon is-small">
                        	<i class="fas fa-sign-out-alt"></i>
                        </span>
                        <span>Sign out</span>
                    </a>
                </li>
                </c:if>
            </ul>
		</div>

        <h1 class="title has-text-centered">Edit ${foodtruck.name}</h1>
        
        <div class="columns is-mobile is-centered">
        	<div class="column is-two-thirds is-narrow">
				<form:form method="POST" action="/foodtruck/${foodtruck.id}/update" modelAttribute="foodtruck">
					<div class="field">
		                <label class="label">Name</label>
		                <div class="control has-icons-left">
		                    <form:input path="name" placeholder="Name" class="input"/>
		                    <span class="icon is-small is-left">
		                        <i class="fas fa-utensils"></i>
		                    </span>
		                    <form:errors path="name"/>
		            	</div>
		            </div>
					<div class="field">
		                <label class="label">Style</label>
		                <div class="control has-icons-left">
		                    <form:input path="style" placeholder="Style" class="input"/>
		                    <span class="icon is-small is-left">
		                        <i class="fas fa-utensils"></i>
		                    </span>
		                    <form:errors path="style"/>
		            	</div>
		            </div>
					<div class="field">
		                <label class="label">Description</label>
		                <div class="control has-icons-left">
		                    <form:textarea path="description" placeholder="Description" class="textarea" rows="2"/>
		                    <form:errors path="description"/>
		            	</div>
		            </div>
		            <input type="hidden" name="op" value="${user.id}"/>
		            <button type="submit" class="button is-primary">Submit</button>
		            <a href="/" class="button is-danger">Cancel</a>
				</form:form>
        	</div>
        </div>
		
	</div>
</body>
</html>