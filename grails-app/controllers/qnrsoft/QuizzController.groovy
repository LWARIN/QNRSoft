package qnrsoft

import org.springframework.dao.DataIntegrityViolationException
import org.apache.shiro.SecurityUtils

class QuizzController {

	static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

	def index() {
		redirect(action: "list", params: params)
	}

	def list(Integer max) {
		params.max = Math.min(max ?: 10, 100)
		[quizzInstanceList: Quizz.list(params), quizzInstanceTotal: Quizz.count()]
	}

	def create() {
		[quizzInstance: new Quizz(params)]
	}

	def save() {
		def quizzInstance = new Quizz(params)
		if (!quizzInstance.save(flush: true)) {
			render(view: "create", model: [quizzInstance: quizzInstance])
			return
		}

		flash.message = message(code: 'default.created.message', args: [
			message(code: 'quizz.label', default: 'Quizz'),
			quizzInstance.id
		])
		redirect(action: "show", id: quizzInstance.id)
	}

	def show(Long id) {
		def quizzInstance = Quizz.get(id)
		if (!quizzInstance) {
			flash.message = message(code: 'default.not.found.message', args: [
				message(code: 'quizz.label', default: 'Quizz'),
				id
			])
			redirect(action: "list")
			return
		}
		
		if (!SecurityUtils.getSubject().hasRole("ROLE_TEACHER")) {
			if (quizzInstance.state == Quizz.STATE_VOTING) {
				redirect(action: "vote", id: id)
			}
			else if (quizzInstance.state == Quizz.STATE_CLOSED) {
				redirect(action: "showStats", id: id)
			}
			else {
				redirect(action: "list")
			}
			return
		}

		[quizzInstance: quizzInstance]
	}

	def vote(Long id) {
		def quizzInstance = Quizz.get(id)
		if (!quizzInstance || quizzInstance.state != Quizz.STATE_VOTING) {
			render(view: "/error.gsp", exception: 'test')
			return
		}
		
		[quizzInstance: quizzInstance]
	}	
	
	def submitVote(Long id) {
		def checkedAnswers = params.list('checkAnswers')
		def selectedAnswers = Answer.getAll(checkedAnswers)
		
		if (selectedAnswers.isEmpty()) {
			flash.error = "You have to select at least one answer."
			redirect(action: "vote", id: id)
			return
		}
		
		// Traitement des reponses
		// flash.message = message(code: 'default.created.message', args: [message(code: 'answer.label', default: 'Answer'), answerInstance.id])
		//render(selectedAnswers*.answer)
		
		for (Answer answer : selectedAnswers) {
			answer.voteCount++
			answer.save()
		}
		
		flash.message = "Vote accepted."
		redirect(action: "list")
	}
	
	def startVote(Long id) {
		def quizzInstance = Quizz.get(id)
		
		if (!quizzInstance) {
			render(view: "/error.gsp")
			return
		}
		
		if (quizzInstance.state == Quizz.STATE_VOTING) {
			flash.error = "Voting phase has already started."
		}
		else {
			quizzInstance.state = Quizz.STATE_VOTING
			//TODO save cascade
			quizzInstance.save()
			flash.message = "Voting phase started."
		}		
		
		redirect(action: "show", id: id)
	}
	
	def endVote(Long id) {
		def quizzInstance = Quizz.get(id)
		
		if (!quizzInstance) {
			render(view: "/error.gsp")
			return
		}
		
		if (quizzInstance.state == Quizz.STATE_CLOSED) {
			flash.error = "Voting phase is already over."
		}
		else {
			quizzInstance.state = Quizz.STATE_CLOSED
			//TODO save cascade
			quizzInstance.save()
			flash.message = "Voting phase over."
		}
		
		// TODO on va a la page de stats ?
		redirect(action: "show", id: id)
	}
	
	def showStats(Long id) {
		def quizzInstance = Quizz.get(id)
		if (!quizzInstance || quizzInstance.state != Quizz.STATE_CLOSED) {
			render(view: "/error.gsp")
			return
		}
		
		render(view: "stats", model: [quizzInstance: quizzInstance])
	}
	
	def reinit(Long id) {
		def quizzInstance = Quizz.get(id)
		if (!quizzInstance) {
			render(view: "/error.gsp")
			return
		}
		
		for (Answer answer : quizzInstance.answers) {
			answer.voteCount = 0
			answer.save()
		}
		
		redirect(action: "show", id: id)
	}

	def edit(Long id) {
		def quizzInstance = Quizz.get(id)
		if (!quizzInstance) {
			flash.message = message(code: 'default.not.found.message', args: [
				message(code: 'quizz.label', default: 'Quizz'),
				id
			])
			redirect(action: "list")
			return
		}

		[quizzInstance: quizzInstance]
	}

	def update(Long id, Long version) {
		def quizzInstance = Quizz.get(id)
		if (!quizzInstance) {
			flash.message = message(code: 'default.not.found.message', args: [
				message(code: 'quizz.label', default: 'Quizz'),
				id
			])
			redirect(action: "list")
			return
		}

		if (version != null) {
			if (quizzInstance.version > version) {
				quizzInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
						[
							message(code: 'quizz.label', default: 'Quizz')] as Object[],
						"Another user has updated this Quizz while you were editing")
				render(view: "edit", model: [quizzInstance: quizzInstance])
				return
			}
		}

		quizzInstance.properties = params

		if (!quizzInstance.save(flush: true)) {
			render(view: "edit", model: [quizzInstance: quizzInstance])
			return
		}

		flash.message = message(code: 'default.updated.message', args: [
			message(code: 'quizz.label', default: 'Quizz'),
			quizzInstance.id
		])
		redirect(action: "show", id: quizzInstance.id)
	}

	def delete(Long id) {
		def quizzInstance = Quizz.get(id)
		if (!quizzInstance) {
			flash.message = message(code: 'default.not.found.message', args: [
				message(code: 'quizz.label', default: 'Quizz'),
				id
			])
			redirect(action: "list")
			return
		}

		try {
			quizzInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [
				message(code: 'quizz.label', default: 'Quizz'),
				id
			])
			redirect(action: "list")
		}
		catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [
				message(code: 'quizz.label', default: 'Quizz'),
				id
			])
			redirect(action: "show", id: id)
		}
	}
}
