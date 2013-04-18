
<%@ page import="qnrsoft.Quizz" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<title>QnR - Statistics</title>
	</head>
	<body>
		<gvisualization:apiImport/>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<shiro:hasRole name="ROLE_TEACHER">
					<li><g:link class="back" controller="quizz" action="show" id="${quizzInstance?.id}">Back to Quizz</g:link></li>					
				</shiro:hasRole>
				<li><g:link class="list" controller="quizz" action="list">Quizz List</g:link></li>
				<shiro:isLoggedIn><li class="log"><g:link controller="auth" action="signOut">Logout: <shiro:principal/></g:link></li></shiro:isLoggedIn>
				<shiro:isNotLoggedIn><li class="log"><g:link controller="auth" action="login" params="[targetUri: '/stats/show/' + quizzInstance?.id]">Sign in</g:link></li></shiro:isNotLoggedIn>
			</ul>
		</div>
		<div class="content scaffold-show" role="main">
			<h1>Quizz #${quizzInstance?.id}: Results</h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:if test="${flash.error}">
				<div class="errors" role="status">${flash.error}</div>
			</g:if>
			
			<shiro:hasRole name="ROLE_TEACHER">
				<gvisualization:pieCoreChart elementId="piechart" title="${quizzInstance.question + " (" + (quizzInstance.voteCount as String) + " votes)"}" width="${750}" height="${600}" columns="${columns}" data="${answers}" />
			
				<span style="display: block; margin-left: 15%"><div id="piechart"></div></span>
			</shiro:hasRole>
			
			<ol class="property-list">
				<g:each in="${test}" var="b">
					<li class="fieldcontain">
						<span id="answers-label" class="property-label">${b.answer + " (" + b.validity + ")"}</span>
						<span class="property-value" aria-labelledby="answers-label">${b.comment}</span>
					</li>
				</g:each>
			</ol>
			
		</div>
	</body>
</html>
