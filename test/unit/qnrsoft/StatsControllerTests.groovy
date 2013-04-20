package qnrsoft



import grails.test.mixin.*
import org.junit.*

/**
 * See the API for {@link grails.test.mixin.web.ControllerUnitTestMixin} for usage instructions
 */
@TestFor(StatsController)
@Mock(Quizz)
class StatsControllerTests {
	
	def populateValidParams(params) {
		assert params != null
		params["question"] = "2+2?"
		params["onScreen"] = true
		params["state"] = 'Opened'
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
		
		assert flash.error != null
		assert response.redirectedUrl == "/quizz/show/$params.id"
	}
}
