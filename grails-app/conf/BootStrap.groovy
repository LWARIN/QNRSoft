import qnrsoft.Answer
import qnrsoft.Quizz
import qnrsoft.Role
import qnrsoft.User

class BootStrap {
	
	def shiroSecurityService

    def init = { servletContext ->
		/*
		// Create the admin role
		def teacherRole = Role.findByName('ROLE_TEACHER') ?:
			new Role(name: 'ROLE_TEACHER').save(flush: true, failOnError: true)

		// Create an admin user
		def adminUser = User.findByUsername('admin') ?:
			new User(username: "admin",
					passwordHash: shiroSecurityService.encodePassword('password'))
					.save(flush: true, failOnError: true)

		// Add roles to the admin user
		assert adminUser.addToRoles(teacherRole)
				.save(flush: true, failOnError: true)
		
		def quizz1 = new Quizz(question : "Combien font 2+2 ?",
			onScreen : true, state : Quizz.STATE_VOTING)
		
		if(!quizz1.save()) {
			quizz1.errors.allErrors.each{error ->
				println "An error occured with quizz1"}
		}
		
		def quizz2 = new Quizz(question : "Ceci est la deuxieme question",
			onScreen : false, state : Quizz.STATE_OPENED)
		
		if(!quizz2.save()) {
			quizz2.errors.allErrors.each{error ->
				println "An error occured with quizz2"}
		}
		
		def answer1 = new Answer(answer : "Je dirais que ca fait 4",
			status : Answer.STATUS_APPROVED, validity : Answer.VALIDITY_CORRECT, comment : "")
		
		def answer2 = new Answer(answer : "5 pour moi",
			status : Answer.STATUS_PENDING, validity : Answer.VALIDITY_PENDING, comment : "")
		
		def answer3 = new Answer(answer : "Obviously ca fait 32",
			status : Answer.STATUS_APPROVED, validity : Answer.VALIDITY_WRONG, comment : "")
		
		def answer4 = new Answer(answer : "Ah j'etais a 724 moi",
			status : Answer.STATUS_REJECTED, validity : Answer.VALIDITY_PENDING, comment : "")
		
		quizz1.addToAnswers(answer1)
		quizz1.addToAnswers(answer2)
		quizz1.addToAnswers(answer3)
		quizz1.addToAnswers(answer4)
		
		*/
    }
    def destroy = {
    }
}
