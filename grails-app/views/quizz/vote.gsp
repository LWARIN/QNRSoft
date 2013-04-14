
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
			<g:form action="submitVote">
				<ol class="property-list quizz">
				
					<g:if test="${quizzInstance?.question}">
					<li class="fieldcontain">
						<span id="question-label" class="property-label"><g:message code="quizz.question.label" default="Question" /></span>
						
							<span class="property-value" aria-labelledby="question-label"><g:fieldValue bean="${quizzInstance}" field="question"/></span>
						
					</li>
					</g:if>
				
					<g:if test="${quizzInstance?.onScreen != null}">
					<li class="fieldcontain">
						<span id="onScreen-label" class="property-label"><g:message code="quizz.onScreen.label" default="On Screen" /></span>
						
							<span class="property-value" aria-labelledby="onScreen-label"><g:formatBoolean boolean="${quizzInstance?.onScreen}" /></span>
						
					</li>
					</g:if>
				
					<g:if test="${quizzInstance?.answers}">
				
					<li class="fieldcontain">
						<span id="answers-label" class="property-label">Answers</span>
						
							<g:each in="${quizzInstance.answers}" var="a">
							<g:if test="${a.status == Answer.STATUS_APPROVED}">
								<span class="property-value" aria-labelledby="answers-label"><g:checkBox name="checkAnswers" value="${a.id}" checked="false"/><g:fieldValue bean="${a}" field="answer"/></span>
							</g:if>						
							</g:each>
						
					</li>
					
					</g:if>				
		
				</ol>
			
				<shiro:lacksRole name="ROLE_TEACHER">
					<!-- TODO code ?? -->
					<fieldset class="buttons">
						<!-- On a besoin du hiddenField qui sert de parametre a la methode submitVote -->
						<g:hiddenField name="id" value="${quizzInstance?.id}" />
						<g:actionSubmit value="Submit Vote" class="submit" action="submitVote" onclick="return confirm('${message(code: 'default.button.submit.confirm.message', default: 'Really submit your vote?')}');" />
					</fieldset>
				</shiro:lacksRole>
			</g:form>
		</div>
	</body>
</html>
