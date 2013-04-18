package qnrsoft



import grails.test.mixin.*
import org.junit.*

/**
 * See the API for {@link grails.test.mixin.domain.DomainClassUnitTestMixin} for usage instructions
 */
@TestFor(Quizz)
class QuizzTests {

	void testConstraints() {
		Quizz q = new Quizz()

		assert !q.validate()
		assert "nullable" == q.errors["question"].code

		q = new Quizz(question:"2+2?",
			onScreen:false,
			state:"State",
			voteCount:0)

		assert !q.validate()
		assert "not.inList" == q.errors["state"].code

		q = new Quizz(question:"2+2?",
			onScreen:false,
			state:"Opened",
			voteCount:0)

		assert q.validate()
	}
}
