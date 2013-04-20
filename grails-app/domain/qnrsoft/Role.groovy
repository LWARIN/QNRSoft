package qnrsoft

class Role {
    String name

    static hasMany = [ users: User, permissions: String ]
    static belongsTo = User

    static constraints = {
        name blank: false, unique: true
    }
}
