package qnrsoft

class Quizz {
	
	static final String STATE_CLOSED = "Closed";
	static final String STATE_OPENED = "Opened";
	static final String STATE_VOTING = "Voting";
	
	String question
	boolean onScreen
	String state
	
	static hasMany = [answers : Answer]

    static constraints = {
		question blank: false
		onScreen blank: false
		state blank: false, inList: [STATE_CLOSED, STATE_OPENED, STATE_VOTING]
    }
}
