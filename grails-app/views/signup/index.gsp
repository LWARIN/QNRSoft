<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="layout" content="main" />
<title>Sign up</title>

<link rel="stylesheet" href="${resource(dir: 'css', file: 'login.css')}" type="text/css">

</head>
<body>
	<div class="nav" role="navigation">
		<ul>
			<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
		</ul>
	</div>
	<div class="content scaffold-show">
		<h1>Sign Up Form</h1>
	</div>
	<g:if test="${flash.message}">
		<div class="message">
			${flash.message}
		</div>
	</g:if>
	<g:hasErrors bean="${user}">
		<div class="alert alert-error">
			<g:renderErrors bean="${user}" as="list" />
		</div>
	</g:hasErrors>
	<g:if test="${flash.error}">
		<div class="errors" role="status">${flash.error}</div>
	</g:if>
	
	<div id="containerSignUp">

		<g:form action="register">

			<label for="username">Username:</label> 
			<input type="name" name="username" value="${user.username}"/>
			 
			<label for="password">Password:</label>
			<input type="password" name="password" value=""/>
			
			<label for="passwordConf">Confirm Password:</label>
			<input type="password" name="passwordConf" value=""/>

			<div id="lower">
				
				<input name="submit" type="submit" value="Sign up">

			</div>

		</g:form>

	</div>
</body>
</html>