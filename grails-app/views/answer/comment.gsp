
<%@ page import="qnrsoft.Answer" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<title>QnR - Answer</title>
	</head>
	<body>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="back" controller="answer" action="show" id="${answerInstance?.id}"><g:message code="default.back.label" default="Back to Answer" /></g:link></li>
				<shiro:isLoggedIn><li class="log"><g:link controller="auth" action="signOut">Logout: <shiro:principal/></g:link></li></shiro:isLoggedIn>
			</ul>
		</div>
		<div id="edit-answer" class="content scaffold-edit" role="main">
			<g:form method="post" >
				<h1>Answer #${answerInstance?.id}: Comment</h1>
				<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
				</g:if>
				<fieldset class="form">
				
					<g:if test="${answerInstance?.answer}">
					<div class="fieldcontain">
						<span id="answer-label" class="property-label"><g:message code="answer.answer.label" default="Answer" /></span>
						
							<span class="property-value" aria-labelledby="answer-label"><g:fieldValue bean="${answerInstance}" field="answer"/></span>
						
					</div>
					</g:if>
				
					<g:if test="${answerInstance?.status}">
					<div class="fieldcontain">
						<span id="status-label" class="property-label"><g:message code="answer.status.label" default="Status" /></span>
						
							<span class="property-value" aria-labelledby="status-label"><g:fieldValue bean="${answerInstance}" field="status"/></span>
						
					</div>
					</g:if>
				
					<g:if test="${answerInstance?.validity}">
					<div class="fieldcontain">
						<span id="validity-label" class="property-label"><g:message code="answer.validity.label" default="Validity" /></span>
						
							<span class="property-value" aria-labelledby="validity-label"><g:fieldValue bean="${answerInstance}" field="validity"/></span>
						
					</div>
					</g:if>
				
					<g:if test="${answerInstance?.comment != null}">
					<div class="fieldcontain">
						<span id="comment-label" class="property-label"><g:message code="answer.comment.label" default="Comment" /></span>
						
						<span class="property-value" aria-labelledby="comment-label"><g:textArea name="comment" bean="${answerInstance}" field="comment"/></span>
						
					</div>
					</g:if>
				</fieldset>
			
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${answerInstance?.id}" />
					<g:hiddenField name="version" value="${answerInstance?.version}" />
					<g:actionSubmit class="save" action="update" value="Ok" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
