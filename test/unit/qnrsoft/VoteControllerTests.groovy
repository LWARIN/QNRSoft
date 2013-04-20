package qnrsoft



import grails.test.mixin.*
import org.junit.*

/**
 * See the API for {@link grails.test.mixin.web.ControllerUnitTestMixin} for usage instructions
 */
@TestFor(VoteController)
@Mock(Quizz)
class VoteControllerTests {
	
	def populateValidParams(params) {
		assert params != null
		params["question"] = "2+2?"
		params["onScreen"] = true
		params["state"] = 'Closed'
		params["voteCount"] = 70
	}

    void testShow() {
		controller.show()
		
		assert response.redirectedUrl == "/notFound"
		
		response.reset()
		
		populateValidParams(params)
		def quizz = new Quizz(params)
		
		assert quizz.save() != null
		
		params.id = quizz.id
		controller.show()
		
		assert response.redirectedUrl == '/forbidden'
	}
	
	void testSubmit() {
		controller.submit()
		
		assert response.redirectedUrl == "/notFound"
	}
	
	void testReopen() {
		controller.reopen()
		
		assert response.redirectedUrl == "/notFound"
		
		response.reset()
		
		populateValidParams(params)
		def quizz = new Quizz(params)
		
		assert quizz.save() != null
		
		params.id = quizz.id
		controller.reopen()
		
		assert flash.message != null
		assert response.redirectedUrl == "/quizz/show/$params.id"
	}
	
	void testStart() {
		controller.start()
		
		assert response.redirectedUrl == "/notFound"
		
		response.reset()
		
		populateValidParams(params)
		def quizz = new Quizz(params)
		
		assert quizz.save() != null
		
		params.id = quizz.id
		controller.start()
		
		assert flash.message != null
		assert response.redirectedUrl == "/quizz/show/$params.id"
	}
	
	void testEnd() {
		controller.end()
		
		assert response.redirectedUrl == "/notFound"
		
		response.reset()
		
		populateValidParams(params)
		def quizz = new Quizz(params)
		
		assert quizz.save() != null
		
		params.id = quizz.id
		controller.end()
		
		assert flash.error != null
	}
}
