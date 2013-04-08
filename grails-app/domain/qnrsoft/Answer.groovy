package qnrsoft

class Answer {
	
	enum Status {
		APPROVED,
		REJECTED
	}
	
	enum Validity {
		CORRECT,
		WRONG
	}
	
	String answer
	Status status
	Validity validity
	String comment

    static constraints = {
    }
}
