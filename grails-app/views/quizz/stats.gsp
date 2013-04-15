
<%@ page import="qnrsoft.Quizz" %>
<%@ page import="qnrsoft.Answer" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'quizz.label', default: 'Quizz')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<gvisualization:apiImport/>
		<a href="#show-quizz" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<shiro:hasRole name="ROLE_TEACHER"><li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li></shiro:hasRole>
				<shiro:isLoggedIn><li class="log"><g:link controller="auth" action="signOut"><g:message code="default.logout.label" default="Logout" /></g:link></li></shiro:isLoggedIn>
				<shiro:isNotLoggedIn><li class="log"><g:link controller="auth" action="login"><g:message code="default.signin.label" default="Sign in" /></g:link></li></shiro:isNotLoggedIn>
			</ul>
		</div>
		<div id="show-quizz" class="content scaffold-show" role="main">
			<h1>Quizz #${quizzInstance?.id}</h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:if test="${flash.error}">
			<div class="errors" role="status">${flash.error}</div>
			</g:if>
			
			<%
				def columns = [['string', 'Answer'], ['number', 'Number of Votes']]
				def answers = []
			 %>
			
			<g:each in="${quizzInstance.answers}" var="a">
				<% answers.add([a.answer, a.voteCount]) %>
			</g:each>
			
			<gvisualization:pieCoreChart elementId="piechart" title="Vote Results" width="${750}" height="${600}" 
			 columns="${columns}" data="${answers}" />
			<div id="piechart"></div>
			
		</div>
	</body>
</html>
