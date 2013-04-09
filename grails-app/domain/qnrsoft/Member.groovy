package qnrsoft

class Member {
	
	String email
	String password
	String lastname
	String firstname

    static constraints = {
		email blank: false, email: true, unique: true
		password blank: false
		lastname blank: false
		firstname blank: false
    }
}
