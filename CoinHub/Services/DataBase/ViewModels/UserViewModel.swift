import RealmSwift
import SwiftUI


class UserViewModel: ObservableObject {
    private var realm: Realm

    @Published var currentUser: User?
    @Published var isUserLoggedIn = false
    
    @Published var transactions: [Transaction] = []
    
    @Published var consolidatedCryptoHoldings: [String: Double] = [:]

    init(realm: Realm = try! Realm()) {
        self.realm = realm
        if let email = UserDefaults.standard.string(forKey: "currentUserEmail") {
            let predicate = NSPredicate(format: "email == %@", email)
            currentUser = realm.objects(User.self).filter(predicate).first
            isUserLoggedIn = currentUser != nil
        }
    }

    func doesUserExistWithEmail(_ email: String) -> Bool {
        let predicate = NSPredicate(format: "email == %@", email)
        return realm.objects(User.self).filter(predicate).count > 0
    }

    func createUser(email: String, password: String) {
        guard !doesUserExistWithEmail(email) else {
            return
        }

        let newUser = User()
        newUser.email = email
        newUser.password = password

        do {
            try realm.write {
                realm.add(newUser)
            }
        } catch {
            print("Error saving user: \(error.localizedDescription)")
        }
    }

    func loadCurrentUser() {
        currentUser = getCurrentUser()
    }

    func logOut() {
        UserDefaults.standard.removeObject(forKey: "currentUserEmail")
        currentUser = nil
        isUserLoggedIn = false
    }
    
    func loginUser(email: String, password: String) -> Bool {
        let predicate = NSPredicate(format: "email == %@ AND password == %@", email, password)
        if let user = realm.objects(User.self).filter(predicate).first {
            UserDefaults.standard.set(user.email, forKey: "currentUserEmail")
            currentUser = user
            fetchTransactionsForCurrentUser()
            isUserLoggedIn = true
            return true
        } else {
            return false
        }
    }

    private func getCurrentUser() -> User? {
        guard let email = UserDefaults.standard.string(forKey: "currentUserEmail") else { return nil }
        let predicate = NSPredicate(format: "email == %@", email)
        return realm.objects(User.self).filter(predicate).first
    }
    
    func topUpBalance(amount: Double) {
        guard let user = currentUser else {
            return
        }

        DispatchQueue.main.async {
            do {
                try self.realm.write {
                    user.balance += amount
                    self.objectWillChange.send()
                }
            } catch {
                print("Error topping up balance: \(error.localizedDescription)")
            }
        }
    }
    
    func purchaseCurrency(coin: Coin, amount: Double) {
        guard let user = currentUser else { return }

        let totalCost = amount * coin.currentPrice

        if user.balance >= totalCost {
            do {
                try realm.write {
                    user.balance -= totalCost

                    let transaction = Transaction()
                    transaction.transactionID = ObjectId.generate()
                    transaction.user = user
                    transaction.type = coin.name
                    transaction.amount = amount

                    realm.add(transaction)
                    
                    DispatchQueue.main.async {
                        self.fetchTransactionsForCurrentUser()
                    }
                }
            } catch {
                print("Error in purchasing currency: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchTransactionsForCurrentUser() {
        guard let currentUser = currentUser else {
            transactions = []
            return
        }

        let filteredTransactions = realm.objects(Transaction.self).filter("user == %@", currentUser)
        transactions = Array(filteredTransactions)
        consolidateCryptoHoldings()
    }
    
    func consolidateCryptoHoldings() {
         var holdings: [String: Double] = [:]

         for transaction in transactions {
             let cryptoName = transaction.type
             let amount = transaction.amount

             holdings[cryptoName, default: 0] += amount
         }

         consolidatedCryptoHoldings = holdings
     }
}
