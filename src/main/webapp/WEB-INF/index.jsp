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
		
	</div>
</body>
</html>