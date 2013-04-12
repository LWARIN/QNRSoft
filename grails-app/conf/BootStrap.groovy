import qnrsoft.Answer
import qnrsoft.Quizz

class BootStrap {

    def init = { servletContext ->
		
		def quizz1 = new Quizz(question : "Combien font 2+2 ?",
			onScreen : false, state : Quizz.STATE_VOTING)
		
		if(!quizz1.save()) {
			quizz1.errors.allErrors.each{error ->
				println "An error occured with quizz1"}
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
    }
    def destroy = {
    }
}
