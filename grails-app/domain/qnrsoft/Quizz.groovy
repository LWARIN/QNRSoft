package qnrsoft

class Quizz {
	
	enum State {
		Closed,
		Opened,
		Voting
	}
	
	String question
	boolean onScreen
	State state
	
	static hasMany = [answers : Answer]

    static constraints = {
		question blank: false
		onScreen blank: false
		state blank: false
    }
}
