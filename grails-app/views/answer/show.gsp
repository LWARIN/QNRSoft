
<%@ page import="qnrsoft.Answer" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<title>QnR - Answer</title>
	</head>
	<body>
		<a href="#show-answer" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="back" controller="quizz" action="show" id="${answerInstance?.quizz?.id}">Back to Quizz</g:link></li>
				<li><g:link class="list" controller="answer" action="list">Answer List</g:link></li>
				<shiro:isLoggedIn><li class="log"><g:link controller="auth" action="signOut">Logout: <shiro:principal/></g:link></li></shiro:isLoggedIn>
			</ul>
		</div>
		<div id="show-answer" class="content scaffold-show" role="main">
			<h1>Answer</h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list answer">
			
				<g:if test="${answerInstance?.answer}">
				<li class="fieldcontain">
					<span id="answer-label" class="property-label"><g:message code="answer.answer.label" default="Answer" /></span>
					
						<span class="property-value" aria-labelledby="answer-label"><g:fieldValue bean="${answerInstance}" field="answer"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${answerInstance?.status}">
				<li class="fieldcontain">
					<span id="status-label" class="property-label"><g:message code="answer.status.label" default="Status" /></span>
					
						<span class="property-value" aria-labelledby="status-label"><g:fieldValue bean="${answerInstance}" field="status"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${answerInstance?.validity}">
				<li class="fieldcontain">
					<span id="validity-label" class="property-label"><g:message code="answer.validity.label" default="Validity" /></span>
					
						<span class="property-value" aria-labelledby="validity-label"><g:fieldValue bean="${answerInstance}" field="validity"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${answerInstance?.comment != null}">
				<li class="fieldcontain">
					<span id="comment-label" class="property-label"><g:message code="answer.comment.label" default="Comment" /></span>
					
						<span class="property-value" aria-labelledby="comment-label"><g:fieldValue bean="${answerInstance}" field="comment"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${answerInstance?.id}" />
					<g:link class="edit" action="edit" id="${answerInstance?.id}">Edit Answer</g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
					<g:link action="comment" id="${answerInstance?.id}">Edit Comment</g:link>
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
