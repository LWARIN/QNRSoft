package qnrsoft



import grails.test.mixin.*
import org.junit.*

/**
 * See the API for {@link grails.test.mixin.web.ControllerUnitTestMixin} for usage instructions
 */
@TestFor(SignupController)
class SignupControllerTests {
	
	void testIndex() {
		controller.index()
		assert response.redirectedUrl == null
	}
	
	// Can't test Register method because the needed plugin
	// apparently is not available in test environnement
}
