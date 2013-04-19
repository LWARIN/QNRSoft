package qnrsoft



import grails.test.mixin.*
import org.junit.*

/**
 * See the API for {@link grails.test.mixin.domain.DomainClassUnitTestMixin} for usage instructions
 */
@TestFor(Answer)
class AnswerTests {

	void testConstraints() {
		Answer ans = new Answer()

		assert !ans.validate()
		assert "nullable" == ans.errors["answer"].code

		ans = new Answer(answer:"4",
		status:"Status",
		validity:"Wrong",
		comment:"",
		voteCount:0)

		assert !ans.validate()
		assert "not.inList" == ans.errors["status"].code

		Quizz q = new Quizz(question:"2+2?",
		onScreen:false,
		state:"Opened",
		voteCount:0)

		ans = new Answer(answer : "Je dirais que ca fait 4",
		status : Answer.STATUS_APPROVED, validity : Answer.VALIDITY_CORRECT,
		comment : "salut", voteCount: 0, quizz: q)

		ans.validate()
	}
}
