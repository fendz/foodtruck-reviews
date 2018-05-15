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
	<link type="text/css" rel="stylesheet" href="/css/logreg.css">
	<script defer src="https://use.fontawesome.com/releases/v5.0.6/js/all.js"></script>
</head>
<body>
	<div class="container">

    <section class="section log-reg">

        <!-- box header -->
        <div class="hero is-dark">
            <div class="hero-body is-bold">
                <h1 class="title">Welcome to FoodTrucks</h1>
            </div>
        </div>

        <!-- box body -->
        <div class="box">
            
            <!-- form selection tabs -->
            <div class="tabs is-centered is-medium">
                <ul>
                    <li>
                        <a href="/sign_up">
                            <span class="icon is-small">
                                <i class="fas fa-user-plus"></i>
                            </span>
                            <span>Sign up</span>
                        </a>
                    </li>
                    <li class="is-active">
                        <a href="/sign_in">
                            <span class="icon is-small">
                                <i class="fas fa-sign-in-alt"></i>
                            </span>
                            <span>Sign in</span>
                        </a>
                    </li>
                </ul>
            </div>

            <!-- login form -->
            <form action="/login" method="post">
            	<c:if test="${errors != null}">
	                <div class="notification is-danger">
						<button class="delete"></button>
					  	${errors}
					</div>
				</c:if>
                <div class="field">
                    <label class="label">Email</label>
                    <div class="control has-icons-left">
                        <input class="input" type="text" name="email" placeholder="Email">
                        <span class="icon is-small is-left">
                            <i class="fas fa-envelope"></i>
                        </span>
                    </div>
                </div>
                <div class="field">
                    <label class="label">Password</label>
                    <div class="control has-icons-left">
                        <input class="input" type="password" name="password" placeholder="Password">
                        <span class="icon is-small is-left">
                            <i class="fas fa-lock"></i>
                        </span>
                    </div>
                </div>
                <div class="at-bottom">
                	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/> 
                	<input class="button is-primary" type="submit" value="Sign In">
               		<a href="/" class="button is-info">Cancel</a>
               	</div>
            </form>

        </div>
    </section>

    <!-- error messages just hanging out -->

</div>
</body>
</html>