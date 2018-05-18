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
		
		<!-- Website Greeting -->
		<div class="hero is-dark">
            <div class="hero-body is-bold">
                <h1 class="title">
                	<span><i class="fas fa-truck"></i></span>
                	<span>Foodtrucks</span>
                </h1>
            </div>
        </div>
        
        <!-- Basically a navbar -->
        <div class="tabs is-medium is-centered">
        	<ul>
            	<li class="is-active">
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
		
		<!-- Show a welcome message to the user -->
		<c:if test="${welcome != null}">
			<div class="notification is-primary">		
				${welcome}
			</div>
		</c:if>
		
		<!-- Show error messages to the user -->
		<c:if test="${errors != null}">
			<div class="notification is-danger">		
				${errors}
			</div>
		</c:if>
	
		<!-- All the foodtrucks ordered by average rating -->
		<c:forEach items="${foodtrucks}" var="foodtruck">	
			<article class="media">
			    <figure class="media-left">
			        <p class="image is-64x64">
			            <i class="fas fa-truck is-large fa-3x"></i>
			        </p>
			    </figure>
			        <div class="media-content">
			        	<div class="content">
			        		<p>
			        			<strong>${foodtruck.name}</strong>
			        			<br>
			        			Style: ${foodtruck.style}
			        			<br>
			        			Description: ${foodtruck.description}
			        			<br>
			        			Rating: ${foodtruck.avgRating} <span class="stars">${foodtruck.avgRating}</span>
			      			</p>
			    		</div>
			  		</div>
			  		<div class="media-right">
			  			<c:if test="${user.id == foodtruck.op.id}">
			  				<a href="/foodtruck/${foodtruck.id}/edit" class="button is-info">Edit</a>
			  			</c:if>
			    		<a href="/foodtruck/${foodtruck.id}" class="button is-primary">Review</a>
			  		</div>
			</article>
		</c:forEach>
			
	</div>
	
	<!-- renders the star icons -->
	<script type="text/javascript" src="/js/stars.js"></script>
	
</body>
</html>