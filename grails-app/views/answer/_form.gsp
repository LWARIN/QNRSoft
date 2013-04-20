<%@ page import="qnrsoft.Answer" %>

<div class="fieldcontain">
	<label>
		Question
	</label>
	<g:fieldValue bean="${answerInstance.quizz}" field="question"/>
</div>

<div class="fieldcontain ${hasErrors(bean: answerInstance, field: 'answer', 'error')} required">
	<label for="answer">
		<g:message code="answer.answer.label" default="Answer" />
		<span class="required-indicator">*</span>
	</label>
	<g:textArea name="answer" required="" value="${answerInstance?.answer}"/>
</div>
<shiro:hasRole name="ROLE_TEACHER">
	<div class="fieldcontain ${hasErrors(bean: answerInstance, field: 'status', 'error')} required">
		<label for="status">
			<g:message code="answer.status.label" default="Status" />
			<span class="required-indicator">*</span>
		</label>
		<g:select name="status" from="${answerInstance.constraints.status.inList}" required="" value="${answerInstance?.status}" valueMessagePrefix="answer.status"/>
	</div>
	
	<div class="fieldcontain ${hasErrors(bean: answerInstance, field: 'validity', 'error')} required">
		<label for="validity">
			<g:message code="answer.validity.label" default="Validity" />
			<span class="required-indicator">*</span>
		</label>
		<g:select name="validity" from="${answerInstance.constraints.validity.inList}" required="" value="${answerInstance?.validity}" valueMessagePrefix="answer.validity"/>
	</div>
	
	<div class="fieldcontain ${hasErrors(bean: answerInstance, field: 'comment', 'error')} ">
		<label for="comment">
			<g:message code="answer.comment.label" default="Comment" />		
		</label>
		<g:textArea name="comment" value="${answerInstance?.comment}"/>
		
	</div>
	
	<div class="fieldcontain ${hasErrors(bean: answerInstance, field: 'grade', 'error')} ">
		<label for="grade">
			<g:message code="answer.grade.label" default="Grade" />		
		</label>
		<g:select name="grade" from="${-1..10}" class="range" value="${answerInstance?.grade}" valueMessagePrefix="answer.grade"/>
		Value &lt;-1&gt; will result in displaying no grade for this answer.
	</div>
</shiro:hasRole>

<shiro:hasRole name="ROLE_STUDENT">
	<g:hiddenField name="status" value="${Answer.STATUS_PENDING}" />
	<g:hiddenField name="validity" value="${Answer.VALIDITY_PENDING}" />
	<g:hiddenField name="comment" value="" />
	<g:hiddenField name="grade" value="${-1}" />
</shiro:hasRole>

<%-- Le quizz correspondant à la réponse (on le cache) --%>
<g:hiddenField id="quizz" name="quizz.id" from="${qnrsoft.Quizz.list()}" optionKey="id" required="" value="${answerInstance?.quizz?.id}" class="many-to-one"/>


