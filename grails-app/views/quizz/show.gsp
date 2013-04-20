
<%@ page import="qnrsoft.Quizz" %>
<%@ page import="qnrsoft.Answer" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<title>QnR - Quizz #${quizzInstance?.id}</title>
	</head>
	<body>
		<a href="#show-quizz" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list">Quizz List</g:link></li>
				<shiro:hasRole name="ROLE_TEACHER"><li><g:link class="create" action="create">New Quizz</g:link></li></shiro:hasRole>
				<shiro:isLoggedIn><li class="log"><g:link controller="auth" action="signOut">Logout: <shiro:principal/></g:link></li></shiro:isLoggedIn>
				<shiro:isNotLoggedIn><li class="log"><g:link controller="auth" action="login" params="[targetUri: '/quizz/show/' + quizzInstance?.id]"><g:message code="default.signin.label" default="Sign in" /></g:link></li></shiro:isNotLoggedIn>
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
			<ol class="property-list quizz">
			
				<g:if test="${quizzInstance?.question}">
				<li class="fieldcontain">
					<span id="question-label" class="property-label"><g:message code="quizz.question.label" default="Question" /></span>
					
					<span class="property-value" aria-labelledby="question-label"><g:fieldValue bean="${quizzInstance}" field="question"/></span>
					
				</li>
				</g:if>
				<shiro:hasRole name="ROLE_TEACHER">		
					<li class="fieldcontain">
						<span id="onScreen-label" class="property-label"><g:message code="quizz.onScreen.label" default="On Screen" /></span>
						
						<span class="property-value" aria-labelledby="onScreen-label"><g:formatBoolean boolean="${quizzInstance?.onScreen}" /></span>
						
					</li>
			
				
					<g:if test="${quizzInstance?.state}">
					<li class="fieldcontain">
						<span id="state-label" class="property-label"><g:message code="quizz.state.label" default="State" /></span>
						
						<span class="property-value" aria-labelledby="state-label"><g:fieldValue bean="${quizzInstance}" field="state"/></span>
						
					</li>
					</g:if>
					
					<g:if test="${quizzInstance?.voteCount != null}">
					<li class="fieldcontain">
						<span id="voteCount-label" class="property-label"><g:message code="quizz.voteCount.label" default="Total Votes" /></span>
						
						<span class="property-value" aria-labelledby="state-label"><g:fieldValue bean="${quizzInstance}" field="voteCount"/></span>
						
					</li>
					</g:if>
				</shiro:hasRole>	
				<g:if test="${quizzInstance?.answers}">
				<shiro:hasRole name="ROLE_TEACHER">
				<li class="fieldcontain">
					<span id="answers-label" class="property-label">Pending Answers</span>
					
					<g:each in="${quizzInstance.answers}" var="a">
					<answer:isPending status="${a.status}">
						<span class="property-value" aria-labelledby="answers-label">
							<g:link controller="answer" action="edit" id="${a.id}">
								${a?.answer} - ${a?.validity}<answer:grade value="${a?.grade}"> (Grade: ${a?.grade})</answer:grade>
							</g:link>
						</span>
					</answer:isPending>		
					</g:each>
					
				</li>
				
				<li class="fieldcontain">
					<span id="answers-label" class="property-label">Approved Answers</span>
					
					<g:each in="${quizzInstance.answers}" var="a">
					<answer:isApproved status="${a.status}">
						<span class="property-value" aria-labelledby="answers-label">
							<g:link controller="answer" action="edit" id="${a?.id}">
								${a?.answer} - ${a?.validity}<answer:grade value="${a?.grade}"> (Grade: ${a?.grade})</answer:grade>
							</g:link>
						</span>
					</answer:isApproved>		
					</g:each>
					
				</li>
				
				<li class="fieldcontain">
					<span id="answers-label" class="property-label">Rejected Answers</span>
					
					<g:each in="${quizzInstance.answers}" var="a">
					<answer:isRejected status="${a.status}">
						<span class="property-value" aria-labelledby="answers-label">
							<g:link controller="answer" action="edit" id="${a?.id}">
								${a?.answer} - ${a?.validity}<answer:grade value="${a?.grade}"> (Grade: ${a?.grade})</answer:grade>
							</g:link>
						</span>
					</answer:isRejected>		
					</g:each>
					
				</li>
				</shiro:hasRole>
				<shiro:hasRole name="ROLE_STUDENT">
					<li class="fieldcontain">
					<span id="answers-label" class="property-label">Submited Answers</span>
					
					<g:each in="${quizzInstance.answers}" var="a">
						<span class="property-value" aria-labelledby="answers-label">
							<g:fieldValue bean="${a}" field="answer"/>
						</span>	
					</g:each>
					
				</li>
				</shiro:hasRole>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${quizzInstance?.id}" />					
					
					<shiro:hasRole name="ROLE_TEACHER">
						<g:link class="edit" action="edit" id="${quizzInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
						<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
						<g:if test="${!quizzInstance?.onScreen}">
							<g:link action="onScreen" id="${quizzInstance?.id}">Set on Screen</g:link>
						</g:if>
						<g:else>
							<g:link action="onScreen" id="${quizzInstance?.id}">Hide</g:link>
						</g:else>
					</shiro:hasRole>
					
					<quizz:isOpened state="${quizzInstance?.state}">						
						<shiro:hasRole name="ROLE_TEACHER">
							<g:link class="attach" controller="answer" action="create" params="['quizz.id': quizzInstance?.id, question: quizzInstance?.question]">Add Answer</g:link>
							<g:link controller="vote" action="start" id="${quizzInstance?.id}">Start Vote</g:link>
							<g:if test="${quizzInstance.voteCount > 0}">
								<g:link action="resetVotes" id="${quizzInstance?.id}" onclick="return confirm('Do you really want to reset all the votes?');">Reset Votes</g:link>	
							</g:if>
						</shiro:hasRole>
						<shiro:lacksRole name="ROLE_TEACHER">
							<g:link class="attach" controller="answer" action="create" params="['quizz.id': quizzInstance?.id, question: quizzInstance?.question]">Suggest Answer</g:link>
						</shiro:lacksRole>
					</quizz:isOpened>
					
					<quizz:isVoting state="${quizzInstance?.state}">
						<g:link class="show" controller="vote" action="show" id="${quizzInstance?.id}">View Vote</g:link>
						<shiro:hasRole name="ROLE_TEACHER">
							<g:link controller="vote" action="reopen" id="${quizzInstance?.id}">Reopen</g:link>
							<g:link controller="vote" action="end" id="${quizzInstance?.id}">End Vote</g:link>
							<g:link action="resetVotes" id="${quizzInstance?.id}" onclick="return confirm('Do you really want to reset all the votes?');">Reset Votes</g:link>	
						</shiro:hasRole>
					</quizz:isVoting>
					
					<quizz:isClosed state="${quizzInstance?.state}">
						<shiro:hasRole name="ROLE_TEACHER"><g:link controller="vote" action="start" id="${quizzInstance?.id}">Restart Vote</g:link></shiro:hasRole>
						<g:link class="stats" controller="stats" action="show" id="${quizzInstance?.id}">Show Stats</g:link>
					</quizz:isClosed>
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
