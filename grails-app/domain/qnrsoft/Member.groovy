package qnrsoft

class Member {
	
	String id
	String password
	String lastname
	String firstname

    static constraints = {
		id blank: false, email: true, unique: true
		password blank: false
		lastname blank: false
		firstname blank: false
    }
}
