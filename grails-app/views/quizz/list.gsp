
<%@ page import="qnrsoft.Quizz" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'quizz.label', default: 'Quizz')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-quizz" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-quizz" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="question" title="${message(code: 'quizz.question.label', default: 'Question')}" />
					
						<g:sortableColumn property="onScreen" title="${message(code: 'quizz.onScreen.label', default: 'On Screen')}" />
					
						<g:sortableColumn property="state" title="${message(code: 'quizz.state.label', default: 'State')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${quizzInstanceList}" status="i" var="quizzInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<g:set var="quest" value="${fieldValue(bean: quizzInstance, field: "question")}" />
					
						<td><g:link action="show" id="${quizzInstance.id}">
							${quest.length() <= 35 ? quest : quest.substring(0, 35)}
						</g:link></td>
					
						<td><g:formatBoolean boolean="${quizzInstance.onScreen}" /></td>
					
						<td>${fieldValue(bean: quizzInstance, field: "state")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${quizzInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
