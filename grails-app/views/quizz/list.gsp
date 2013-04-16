
<%@ page import="qnrsoft.Quizz" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<title>QnR - Quizz List</title>
	</head>
	<body>
		<a href="#list-quizz" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				
				<shiro:hasRole name="ROLE_TEACHER">
					<li><g:link class="create" action="create">New Quizz</g:link></li>
					<li><g:link class="list" controller="answer" action="list">Answer List</g:link></li>
				</shiro:hasRole>
				
				<shiro:isLoggedIn><li class="log"><g:link controller="auth" action="signOut"><g:message code="default.logout.label" default="Logout" /></g:link></li></shiro:isLoggedIn>
				<shiro:isNotLoggedIn><li class="log"><g:link controller="auth" action="login" params="[targetUri: '/quizz/list']"><g:message code="default.signin.label" default="Sign in" /></g:link></li></shiro:isNotLoggedIn>
			</ul>
		</div>
		<div id="list-quizz" class="content scaffold-list" role="main">
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<h1>Quizz List</h1>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="question" title="${message(code: 'quizz.question.label', default: 'Question')}" />
					
						<shiro:hasRole name="ROLE_TEACHER">
						<g:sortableColumn property="onScreen" title="${message(code: 'quizz.onScreen.label', default: 'On Screen')}" />
						</shiro:hasRole>
					
						<g:sortableColumn property="state" title="${message(code: 'quizz.state.label', default: 'State')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${quizzInstanceList}" status="i" var="quizzInstance">
				
					<shiro:hasRole name="ROLE_TEACHER">
						<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<g:set var="quest" value="${fieldValue(bean: quizzInstance, field: "question")}" />
					
						<td><g:link action="show" id="${quizzInstance.id}">
							${quest.length() <= 35 ? quest : quest.substring(0, 35)}
						</g:link></td>
					
						<td><g:formatBoolean boolean="${quizzInstance.onScreen}" /></td>
					
						<td>${fieldValue(bean: quizzInstance, field: "state")}</td>					
					</tr>
					
					</shiro:hasRole>
					
					<shiro:isNotLoggedIn>
						<g:if test="${quizzInstance.onScreen}">
							<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
						
							<g:set var="quest" value="${fieldValue(bean: quizzInstance, field: "question")}" />
						
							<td><g:link action="show" id="${quizzInstance.id}">
								${quest.length() <= 35 ? quest : quest.substring(0, 35)}
							</g:link></td>
						
							<td>${fieldValue(bean: quizzInstance, field: "state")}</td>
						
							</tr>					
						</g:if>
					</shiro:isNotLoggedIn>
					
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${quizzInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
