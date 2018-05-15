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
                    <li class="is-active">
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
                </ul>
            </div>

            <!-- registration form -->
            <form action="/register" method="post">
                <div class="field">
                    <label class="label">Username</label>
                    <div class="control has-icons-left">
                        <input class="input" type="text" name="username" placeholder="Username">
                        <span class="icon is-small is-left">
                            <i class="fas fa-user"></i>
                        </span>
                    </div>
                </div>
                <c:if test="${errors.username != null}">
	                <div class="notification is-danger">
						<button class="delete"></button>
					  	${errors.username}
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
                <c:if test="${errors.email != null}">
	                <div class="notification is-danger">
						<button class="delete"></button>
					  	${errors.email}
					</div>
				</c:if>
                <div class="field">
                    <label class="label">Password</label>
                    <div class="control has-icons-left">
                        <input class="input" type="password" name="password" placeholder="Password">
                        <span class="icon is-small is-left">
                            <i class="fas fa-lock"></i>
                        </span>
                    </div>
                </div>
                <c:if test="${errors.password != null}">
	                <div class="notification is-danger">
						<button class="delete"></button>
					  	${errors.password}
					</div>
				</c:if>
                <div class="field">
                    <label class="label">Confirm Password</label>
                    <div class="control has-icons-left">
                        <input class="input" type="password" name="confirm" placeholder="Confirm Password">
                        <span class="icon is-small is-left">
                            <i class="fas fa-check"></i>
                        </span>
                    </div>
                </div>
                <c:if test="${errors.confirm != null}">
	                <div class="notification is-danger">
						<button class="delete"></button>
					  	${errors.confirm}
					</div>
				</c:if>
				<div class="at-bottom">
               		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                	<input class="button is-primary" type="submit" value="Sign Up">
               		<a href="/" class="button is-info">Cancel</a>
               	</div>
            </form>

        </div>
    </section>
    
</div>

</body>
</html>