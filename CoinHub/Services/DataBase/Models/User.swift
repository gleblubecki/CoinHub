import RealmSwift

class User: Object, Identifiable {
    @Persisted(primaryKey: true) var userID: ObjectId
    @Persisted var password: String
    @Persisted var email: String
    @Persisted var balance: Double

    convenience init(email: String, password: String, balance: Double) {
        self.init()
        self.userID = ObjectId.generate()
        self.email = email
        self.password = password
        self.balance = balance
    }
}
