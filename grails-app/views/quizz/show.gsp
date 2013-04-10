
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
		<a href="#show-quizz" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-quizz" class="content scaffold-show" role="main">
			<h1>Quizz #${quizzInstance?.id}</h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list quizz">
			
				<g:if test="${quizzInstance?.question}">
				<li class="fieldcontain">
					<span id="question-label" class="property-label"><g:message code="quizz.question.label" default="Question" /></span>
					
						<span class="property-value" aria-labelledby="question-label"><g:fieldValue bean="${quizzInstance}" field="question"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${quizzInstance?.onScreen}">
				<li class="fieldcontain">
					<span id="onScreen-label" class="property-label"><g:message code="quizz.onScreen.label" default="On Screen" /></span>
					
						<span class="property-value" aria-labelledby="onScreen-label"><g:formatBoolean boolean="${quizzInstance?.onScreen}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${quizzInstance?.state}">
				<li class="fieldcontain">
					<span id="state-label" class="property-label"><g:message code="quizz.state.label" default="State" /></span>
					
						<span class="property-value" aria-labelledby="state-label"><g:fieldValue bean="${quizzInstance}" field="state"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${quizzInstance?.answers}">
				<li class="fieldcontain">
					<span id="answers-label" class="property-label">Pending Answers</span>
					
						<g:each in="${quizzInstance.answers}" var="a">
						<g:if test="${a.status == Answer.STATUS_PENDING}">
							<span class="property-value" aria-labelledby="answers-label"><g:link controller="answer" action="show" id="${a.id}">#${a?.id}: ${a?.validity}</g:link></span>
						</g:if>						
						</g:each>
					
				</li>
				
				<li class="fieldcontain">
					<span id="answers-label" class="property-label">Approved Answers</span>
					
						<g:each in="${quizzInstance.answers}" var="a">
						<g:if test="${a.status == Answer.STATUS_APPROVED}">
							<span class="property-value" aria-labelledby="answers-label"><g:link controller="answer" action="show" id="${a.id}">#${a?.id}: ${a?.validity}</g:link></span>
						</g:if>						
						</g:each>
					
				</li>
				
				<li class="fieldcontain">
					<span id="answers-label" class="property-label">Rejected Answers</span>
					
						<g:each in="${quizzInstance.answers}" var="a">
						<g:if test="${a.status == Answer.STATUS_REJECTED}">
							<span class="property-value" aria-labelledby="answers-label"><g:link controller="answer" action="show" id="${a.id}">#${a?.id}: ${a?.validity}</g:link></span>
						</g:if>						
						</g:each>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${quizzInstance?.id}" />
					<g:link class="edit" action="edit" id="${quizzInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
