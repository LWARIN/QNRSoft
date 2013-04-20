package qnrsoft



import grails.test.mixin.*
import org.junit.*

/**
 * See the API for {@link grails.test.mixin.web.GroovyPageUnitTestMixin} for usage instructions
 */
@TestFor(AnswerTagLib)
class AnswerTagLibTests {

    void testAnswerStatusTag() {		
		assert applyTemplate('<answer:isPending status="${status}">${"Salut"}</answer:isPending>', [status: Answer.STATUS_PENDING]) == "Salut"
		assert applyTemplate('<answer:isApproved status="${status}">${"Salut"}</answer:isApproved>', [status: Answer.STATUS_PENDING]) == ""
		assert applyTemplate('<answer:isRejected status="${status}">${"Salut"}</answer:isRejected>', [status: Answer.STATUS_REJECTED]) == "Salut"		
	}
	
	void testGradeTag() {
		assert applyTemplate('<answer:grade value="${value}">${"Grade"}</answer:grade>', [value: 8]) == "Grade"
	}
}
