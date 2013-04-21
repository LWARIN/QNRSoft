package qnrsoft

class Answer {

	static final String STATUS_PENDING = "Pending"
	static final String STATUS_APPROVED = "Approved"
	static final String STATUS_REJECTED = "Rejected"
	static final String VALIDITY_PENDING = "Pending"
	static final String VALIDITY_CORRECT = "Correct"
	static final String VALIDITY_WRONG = "Wrong"

	String answer
	String status
	String validity
	String comment
	int grade = -1
	int voteCount

	static belongsTo = [quizz : Quizz]

	static constraints = {
		answer blank: false
		status blank: false, inList: [
			STATUS_PENDING,
			STATUS_APPROVED,
			STATUS_REJECTED
		]
		validity blank: false, inList: [
			VALIDITY_PENDING,
			VALIDITY_CORRECT,
			VALIDITY_WRONG
		]
		comment blank: true
		grade blank: true, range: -1..10
	}
	
	void resetVoteCount() {
		voteCount = 0;
	}
}
