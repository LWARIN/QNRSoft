package qnrsoft

class Answer {
	
	enum Status {
		Pending,
		Approved,
		Rejected
	}
	
	enum Validity {
		Pending,
		Correct,
		Wrong
	}
	
	String answer
	Status status
	Validity validity
	String comment
	
	Quizz quizz

    static constraints = {
		answer blank : false
		comment blank : true
    }
}
