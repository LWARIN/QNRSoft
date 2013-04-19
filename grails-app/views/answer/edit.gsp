<%@ page import="qnrsoft.Answer" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<title>QnR - Edit Answer</title>
	</head>
	<body>
		<a href="#edit-answer" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="back" controller="quizz" action="show" id="${answerInstance?.quizz?.id}">Back to Quizz</g:link></li>
				<shiro:isLoggedIn><li class="log"><g:link controller="auth" action="signOut">Logout: <shiro:principal/></g:link></li></shiro:isLoggedIn>
			</ul>
		</div>
		<div id="edit-answer" class="content scaffold-edit" role="main">
			<h1>Edit Answer</h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${answerInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${answerInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form method="post" >
				<g:hiddenField name="id" value="${answerInstance?.id}" />
				<g:hiddenField name="version" value="${answerInstance?.version}" />
				<fieldset class="form">
					<g:render template="form"/>
				</fieldset>
				<fieldset class="buttons">
					<g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" formnovalidate="" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
