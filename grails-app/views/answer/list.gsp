
<%@ page import="qnrsoft.Answer" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<title>QnR - Answer List</title>
	</head>
	<body>
		<a href="#list-answer" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create">New Answer</g:link></li>
				<shiro:isLoggedIn><li class="log"><g:link controller="auth" action="signOut"><g:message code="default.logout.label" default="Logout" /></g:link></li></shiro:isLoggedIn>
			</ul>
		</div>
		<div id="list-answer" class="content scaffold-list" role="main">
			<h1>Answer List</h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="answer" title="${message(code: 'answer.answer.label', default: 'Answer')}" />
					
						<g:sortableColumn property="status" title="${message(code: 'answer.status.label', default: 'Status')}" />
					
						<g:sortableColumn property="validity" title="${message(code: 'answer.validity.label', default: 'Validity')}" />
					
						<g:sortableColumn property="comment" title="${message(code: 'answer.comment.label', default: 'Comment')}" />
					
						<th><g:message code="answer.quizz.label" default="Quizz" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${answerInstanceList}" status="i" var="answerInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${answerInstance.id}">${fieldValue(bean: answerInstance, field: "answer")}</g:link></td>
					
						<td>${fieldValue(bean: answerInstance, field: "status")}</td>
					
						<td>${fieldValue(bean: answerInstance, field: "validity")}</td>
					
						<td>${fieldValue(bean: answerInstance, field: "comment")}</td>
					
						<td>${fieldValue(bean: answerInstance, field: "quizz")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${answerInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
