import qnrsoft.Answer
import qnrsoft.Quizz
import qnrsoft.Role
import qnrsoft.User

class BootStrap {
	
	def shiroSecurityService

    def init = { servletContext ->	
		
		// Create the admin role
		def teacherRole = Role.findByName('ROLE_TEACHER') ?: 
			new Role(name: 'ROLE_TEACHER').save(flush: true, failOnError: true)		
					
		def studentRole = Role.findByName('ROLE_STUDENT') ?:
			new Role(name: 'ROLE_STUDENT').save(flush: true, failOnError: true)
		
		// Create an admin user
		def adminUser = User.findByUsername('admin@qnr.fr') ?:
			new User(username: "admin@qnr.fr",
					passwordHash: shiroSecurityService.encodePassword('password'))
					.save(flush: true, failOnError: true)
					
		// Create an admin user
		def studUser = User.findByUsername('student@qnr.fr') ?:
			new User(username: "student@qnr.fr",
					passwordHash: shiroSecurityService.encodePassword('password'))
					.save(flush: true, failOnError: true)

		// Add roles to the admin user
		assert adminUser.addToRoles(teacherRole)
				.save(flush: true, failOnError: true)
				
		/*assert studUser.addToRoles(studentRole)
				.save(flush: true, failOnError: true)
		
		def quizz1 = new Quizz(question : "Combien font 2+2 ?",
			onScreen : true, state : Quizz.STATE_CLOSED, voteCount: 80)
		
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
		
		def quizz3 = new Quizz(question : "Un troisème quizz.",
			onScreen : true, state : Quizz.STATE_OPENED)
		
		if(!quizz3.save()) {
			quizz3.errors.allErrors.each{error ->
				println "An error occured with quizz3"}
		}
		
		def answer1 = new Answer(answer : "4",
			status : Answer.STATUS_APPROVED, validity : Answer.VALIDITY_CORRECT, comment : "", voteCount: 75)
		
		def answer2 = new Answer(answer : "5",
			status : Answer.STATUS_PENDING, validity : Answer.VALIDITY_PENDING, comment : "")
		
		def answer3 = new Answer(answer : "32",
			status : Answer.STATUS_APPROVED, validity : Answer.VALIDITY_WRONG, comment : "", voteCount: 19)
		
		def answer4 = new Answer(answer : "724",
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
