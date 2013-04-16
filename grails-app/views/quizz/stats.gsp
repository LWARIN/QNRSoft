
<%@ page import="qnrsoft.Quizz" %>
<%@ page import="qnrsoft.Answer" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<title>QnR - Stats</title>
	</head>
	<body>
		<gvisualization:apiImport/>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<shiro:hasRole name="ROLE_TEACHER">
					<li><g:link class="back" action="show" id="${quizzInstance?.id}">Back to Quizz</g:link></li>
					<li><g:link class="list" action="list">Quizz List</g:link></li>
				</shiro:hasRole>
				<shiro:isLoggedIn><li class="log"><g:link controller="auth" action="signOut"><g:message code="default.logout.label" default="Logout" /></g:link></li></shiro:isLoggedIn>
				<shiro:isNotLoggedIn><li class="log"><g:link controller="auth" action="login" params="[targetUri: '/quizz/showStats/' + quizzInstance?.id]"><g:message code="default.signin.label" default="Sign in" /></g:link></li></shiro:isNotLoggedIn>
			</ul>
		</div>
		<div class="content scaffold-show" role="main">
			<h1>Quizz #${quizzInstance?.id}: Results Overview</h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:if test="${flash.error}">
				<div class="errors" role="status">${flash.error}</div>
			</g:if>
			
			<%
				def columns = [['string', 'Answer'], ['number', 'Count of Votes']]
				def answers = []
			 %>
			
			<g:each in="${quizzInstance.answers}" var="a">
				<% 
					if (a.status == Answer.STATUS_APPROVED) {
						answers.add([a.answer + ' (' + a.validity + ')', a.voteCount])
					}
				%>
			</g:each>
			
			<gvisualization:pieCoreChart elementId="piechart" title="${quizzInstance.question + " (" + (quizzInstance.voteCount as String) + " votes)"}" width="${750}" height="${600}" columns="${columns}" data="${answers}" />
			
			<span style="display:block;margin-left:15%"><div id="piechart"></div></span>
			
		</div>
	</body>
</html>
