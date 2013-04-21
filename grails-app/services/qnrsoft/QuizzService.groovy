package qnrsoft

import grails.validation.ValidationException

class QuizzService {

    Quizz retrieveQuizz(id) {
		Quizz.get(id)
	}
	
	boolean saveQuizz(Quizz quizz) {
		if (!quizz.validate()) {
			throw new ValidationException("Quizz is not valid", quizz.errors)
		}
		quizz.save(flush: true)
	}
}
