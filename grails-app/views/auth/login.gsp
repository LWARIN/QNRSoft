<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="layout" content="main" />
<title>Authentication</title>

<link rel="stylesheet" href="${resource(dir: 'css', file: 'login.css')}" type="text/css">

</head>
<body>
	<div class="nav" role="navigation">
		<ul>
			<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
		</ul>
	</div>
	<div class="content scaffold-show">
		<h1>Authentication</h1>
	</div>
	<g:if test="${flash.message}">
		<div class="message">
			${flash.message}
		</div>
	</g:if>
	<g:if test="${flash.error}">
		<div class="errors" role="status">${flash.error}</div>
	</g:if>
	<div id="container">

		<g:form action="signIn">
		
			<input type="hidden" name="targetUri" value="${targetUri}" />

			<label for="username">Username:</label> 
			<input type="name" name="username" value="${username}"/>
			 
			<label for="password">Password:</label>
			<input type="password" name="password" value=""/>

			<div id="lower">

				<g:checkBox type="checkbox" name="rememberMe" value="${rememberMe}" />
				<label class="check" for="rememberMe">Remember me</label> 
				
				<input type="submit" value="Sign in">

			</div>

		</g:form>

	</div>
</body>
</html>