import RealmSwift
import SwiftUI

class TransactionViewModel: ObservableObject {
    private var transaction: Transaction
    
    init(transaction: Transaction) {
        self.transaction = transaction
    }
}
