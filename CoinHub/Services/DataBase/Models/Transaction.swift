import RealmSwift

class Transaction: Object, Identifiable {
    @Persisted(primaryKey: true) var transactionID: ObjectId
    @Persisted var user: User?
    @Persisted var type: String
    @Persisted var amount: Double

    convenience init(user: User?, type: String, amount: Double, cryptoCurrency: String? = nil, cryptoAmount: Double? = nil) {
        self.init()
        self.transactionID = ObjectId.generate()
        self.user = user
        self.type = type
        self.amount = amount
    }
}
