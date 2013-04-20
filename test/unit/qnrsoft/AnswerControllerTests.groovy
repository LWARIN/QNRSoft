package qnrsoft



import org.junit.*
import grails.test.mixin.*

@TestFor(AnswerController)
@Mock(Answer)
class AnswerControllerTests {

    def populateValidParams(params) {
        assert params != null
        params["answer"] = '2'
		params["status"] = 'Pending'
		params["validity"] = 'Wrong'
		params["comment"] = '2'
		params["grade"] = -1
		params["quizz"] = new Quizz()
    }

    void testIndex() {
        controller.index()
        assert "/answer/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.answerInstanceList.size() == 0
        assert model.answerInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.answerInstance != null
    }

    void testSave() {
        controller.save()

        assert model.answerInstance != null
        assert view == '/answer/create'

        response.reset()

		populateValidParams(params)
        controller.save()

        assert response.redirectedUrl != null
        assert controller.flash.message != null
        assert Answer.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/notFound'

        populateValidParams(params)
        def answer = new Answer(params)

        assert answer.save() != null

        params.id = answer.id

        def model = controller.show()

        assert model.answerInstance == answer
    }

    void testEdit() {
        controller.edit()

        assert flash.error != null
        assert response.redirectedUrl == '/notFound'

        populateValidParams(params)
        def answer = new Answer(params)

        assert answer.save() != null

        params.id = answer.id

        def model = controller.edit()

        assert model.answerInstance == answer
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/notFound'

        response.reset()

        populateValidParams(params)
        def answer = new Answer(params)

        assert answer.save() != null

        // test invalid parameters in update
        params.id = answer.id
		params["status"] = 'Status'

        controller.update()

        assert view == "/answer/edit"
        assert model.answerInstance != null

        answer.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl != null
        assert flash.message != null

        //test outdated version number
        response.reset()
        answer.clearErrors()

        populateValidParams(params)
        params.id = answer.id
        params.version = -1
        controller.update()

        assert view == "/answer/edit"
        assert model.answerInstance != null
        assert model.answerInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/notFound'

        response.reset()

        populateValidParams(params)
        def answer = new Answer(params)

        assert answer.save() != null
        assert Answer.count() == 1

        params.id = answer.id

        controller.delete()

        assert Answer.count() == 0
        assert Answer.get(answer.id) == null
        assert response.redirectedUrl != null
    }
}
