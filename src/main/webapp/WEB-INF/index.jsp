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
        
        <div class="tabs is-medium">
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
                	<a href="/logout">
                    	<span class="icon is-small">
                        	<i class="fas fa-sign-out-alt"></i>
                        </span>
                        <span>Sign out</span>
                    </a>
                </li>
                <li>
                	<a href="/foodtrucks/new">
                    	<span class="icon is-small">
                        	<i class="fas fa-truck"></i>
                        </span>
                        <span>Add a truck</span>
                    </a>
                </li>
                </c:if>
            </ul>
		</div>
		
		<c:if test="${user != null}">
	    	<div class="notification is-primary">		
				Welcome back ${user.username}!
			</div>
		</c:if>
	
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
	
	<script>
		const stars = document.getElementsByClassName("stars");
		const full = `<i class="fas fa-star"></i>`;
		const half = `<i class="fas fa-star-half"></i>`;
		const empty = `<i class="far fa-star"></i>`;

		for(let star of stars){
			console.log(star);
			let s = parseFloat(star.innerHTML);
			let t = "";
			for(var i=1; i<=s; i++){
				t += full;
			}
			if(s%1 >= 0.5){
				t += half;
			}
			star.innerHTML = t;
			console.log(t);
		}
	
	</script>
</body>
</html>