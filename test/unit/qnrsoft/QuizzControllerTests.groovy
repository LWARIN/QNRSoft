package qnrsoft



import org.junit.*
import grails.test.mixin.*

@TestFor(QuizzController)
@Mock(Quizz)
class QuizzControllerTests {

    def populateValidParams(params) {
        assert params != null
		params["question"] = "2+2?"
		params["onScreen"] = true
		params["state"] = 'Opened'
		params["voteCount"] = 70
    }

    void testIndex() {
        controller.index()
        assert "/quizz/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.quizzInstanceList.size() == 0
        assert model.quizzInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.quizzInstance != null
    }

    void testSave() {
        controller.save()

        assert model.quizzInstance != null
        assert view == '/quizz/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/quizz/show/1'
        assert controller.flash.message != null
        assert Quizz.count() == 1
    }
	
	void testOnScreen() {
		controller.onScreen()
		
		assert response.redirectedUrl == '/notFound'
		
		response.reset()
		
		populateValidParams(params)
		def quizz = new Quizz(params)
		
		assert quizz.save() != null
		
		params.id = quizz.id
		controller.onScreen()		
		
		assert response.redirectedUrl == "/quizz/show/$quizz.id"
		assert flash.message != null
	}
	
	void testResetVotes() {
		controller.resetVotes()
		
		assert response.redirectedUrl == '/notFound'
		
		response.reset()
		
		populateValidParams(params)
		def quizz = new Quizz(params)
		
		assert quizz.save() != null
		
		params.id = quizz.id
		controller.resetVotes()
		
		assert quizz.voteCount == 0
		assert response.redirectedUrl == "/quizz/show/$quizz.id"
		assert flash.message != null
	}

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/notFound'

        populateValidParams(params)
        def quizz = new Quizz(params)

        assert quizz.save() != null

        params.id = quizz.id

        def model = controller.edit()

        assert model.quizzInstance == quizz
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/notFound'

        response.reset()

        populateValidParams(params)
        def quizz = new Quizz(params)

        assert quizz.save() != null

        // test invalid parameters in update
        params.id = quizz.id
		params["state"] = 'State'

        controller.update()

        assert view == "/quizz/edit"
        assert model.quizzInstance != null

        quizz.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/quizz/show/$quizz.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        quizz.clearErrors()

        populateValidParams(params)
        params.id = quizz.id
        params.version = -1
        controller.update()

        assert view == "/quizz/edit"
        assert model.quizzInstance != null
        assert model.quizzInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/notFound'

        response.reset()

        populateValidParams(params)
        def quizz = new Quizz(params)

        assert quizz.save() != null
        assert Quizz.count() == 1

        params.id = quizz.id

        controller.delete()

        assert Quizz.count() == 0
        assert Quizz.get(quizz.id) == null
        assert response.redirectedUrl == '/quizz/list'
    }
}
