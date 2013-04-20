package qnrsoft

class User {
    String username
    String passwordHash
    
    static hasMany = [ roles: Role, permissions: String ]

    static constraints = {
        username email: true, blank: false, unique: true
    }
}
