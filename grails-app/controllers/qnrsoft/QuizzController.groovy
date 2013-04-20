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
			redirect(uri: '/notFound')
			return
		}
		
		if (!SecurityUtils.getSubject().hasRole("ROLE_TEACHER")) {
			if (quizzInstance.state == Quizz.STATE_VOTING) {
				redirect(controller:"vote", action: "show", id: id)
				return
			}
			else if (quizzInstance.state == Quizz.STATE_CLOSED) {
				redirect(controller: "stats", action: "show", id: id)
				return
			}
		}

		[quizzInstance: quizzInstance]
	}
	
	def onScreen(Long id) {
		def quizzInstance = Quizz.lock(id)
		if (!quizzInstance) {
			redirect(uri: '/notFound')
			return
		}
		
		quizzInstance.onScreen = !quizzInstance.onScreen
		quizzInstance.save()
		
		flash.message = "The quizz is now " +
			(quizzInstance.onScreen ? "visible" : "hidden") + " for students."
		redirect(action: "show", id: id)
	}
	
	def resetVotes(Long id) {
		def quizzInstance = Quizz.lock(id)
		if (!quizzInstance) {
			redirect(uri: '/notFound')
			return
		}		
		
		for (Answer answer : quizzInstance.answers) {
			answer.voteCount = 0
		}
		quizzInstance.voteCount = 0;
		
		// Sauvegarde des réponses en cascade		
		quizzInstance.save()
		
		flash.message = "The votes for this quizz have been reset."
		redirect(action: "show", id: id)
	}

	def edit(Long id) {
		def quizzInstance = Quizz.get(id)
		if (!quizzInstance) {
			flash.message = message(code: 'default.not.found.message', args: [
				message(code: 'quizz.label', default: 'Quizz'),
				id
			])
			redirect(uri: '/notFound')
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
			redirect(uri: '/notFound')
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
			redirect(uri: '/notFound')
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
