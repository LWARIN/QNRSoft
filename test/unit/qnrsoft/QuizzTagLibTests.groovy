package qnrsoft



import grails.test.mixin.*
import org.junit.*

/**
 * See the API for {@link grails.test.mixin.web.GroovyPageUnitTestMixin} for usage instructions
 */
@TestFor(QuizzTagLib)
class QuizzTagLibTests {

    void testQuizzStateTag() {
		assert applyTemplate('<quizz:isOpened state="${state}">${"Salut"}</quizz:isOpened>', [state: Quizz.STATE_OPENED]) == "Salut"
		assert applyTemplate('<quizz:isVoting state="${state}">${"Salut"}</quizz:isVoting>', [state: Quizz.STATE_OPENED]) == ""
		assert applyTemplate('<quizz:isClosed state="${state}">${"Salut"}</quizz:isClosed>', [state: Quizz.STATE_CLOSED]) == "Salut"
	}
}
