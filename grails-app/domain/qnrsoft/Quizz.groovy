package qnrsoft

class Quizz {
	
	enum State {
		CLOSED,
		SUBMIT,
		VOTE
	}
	
	String question
	boolean onScreen
	State state
	static hasMany = [answers: Answer]

    static constraints = {
		question blank: false
		onScreen blank: false
		state blank: false
		answers maxSize: 10
    }
}
