<%@ page import="qnrsoft.Quizz" %>

<div class="fieldcontain ${hasErrors(bean: quizzInstance, field: 'question', 'error')} required">
	<label for="question">
		<g:message code="quizz.question.label" default="Question" />
		<span class="required-indicator">*</span>
	</label>
	<g:textArea name="question" required="" value="${quizzInstance?.question}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: quizzInstance, field: 'onScreen', 'error')} ">
	<label for="onScreen">
		<g:message code="quizz.onScreen.label" default="Display On Screen" />
		
	</label>
	<g:checkBox name="onScreen" value="${quizzInstance?.onScreen}" />
</div>

<div class="fieldcontain ${hasErrors(bean: quizzInstance, field: 'state', 'error')} required">
	<label for="state">
		<g:message code="quizz.state.label" default="State" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="state" from="${quizzInstance.constraints.state.inList}" required="" value="${quizzInstance?.state}" valueMessagePrefix="quizz.state"/>
</div>

