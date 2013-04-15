<%@ page import="qnrsoft.Quizz" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<title>QnR - Create Quizz</title>
	</head>
	<body>
		<a href="#create-quizz" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list">Quizz List</g:link></li>
			</ul>
		</div>
		<div id="create-quizz" class="content scaffold-create" role="main">
			<h1>New Quizz</h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${quizzInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${quizzInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form action="save" >
				<fieldset class="form">
					<g:render template="form"/>
				</fieldset>
				<fieldset class="buttons">
					<g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
