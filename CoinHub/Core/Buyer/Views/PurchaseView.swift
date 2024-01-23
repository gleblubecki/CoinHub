import SwiftUI

struct PurchaseView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var currencyViewModel: CurrencyViewModel
    @Binding var isShowingPurchase: Bool

    @State private var searchQuery: String = ""
    @State private var selectedCoin: Coin? 
    @State private var amount: String = ""
    
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""

    var body: some View {
        VStack {
            Text("Purchase Crypto")
                .foregroundColor(.pink)
                .fontWeight(.semibold)
                .font(.title2)
            
            TextField("Search currency", text: $searchQuery)
                .customTextFieldStyle(placeholder: "", text: $searchQuery, backgroundColor: Color("RowColor"), textColor: .white)
                .padding()

            if !searchQuery.isEmpty {
                List {
                    ForEach(currencyViewModel.allCoins.filter { $0.name.lowercased().contains(searchQuery.lowercased()) }) { coin in
                        Text(coin.name)
                            .onTapGesture {
                                self.selectedCoin = coin
                                self.searchQuery = coin.name
                            }
                    }
                }
                .listStyle(PlainListStyle())
            }

            if let selectedCoin = selectedCoin {
                HStack{
                    Text("Selected Currency: ")
                        .foregroundColor(.pink)
                    Text("\(selectedCoin.name)")
                    AsyncImage(url: URL(string: selectedCoin.image)) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 30, height: 30)
                }
                
                HStack {
                    Text("Current Price: ")
                        .foregroundColor(.pink)
                    Text("\(currencyFormatter.string(from: NSNumber(value: selectedCoin.currentPrice)) ?? "")")
                }
            }

            TextField("Enter amount", text: $amount)
                .customTextFieldStyle(placeholder: "", text: $amount, backgroundColor: Color("RowColor"), textColor: .white)
                .keyboardType(.decimalPad)
                .padding()

            Button(action: {
                if let coin = selectedCoin, let purchaseAmount = Double(amount), purchaseAmount > 0 {
                    purchaseCrypto(coin: coin, amount: purchaseAmount)
                }
            }) {
                Text("Buy")
                    .padding()
                    .frame(width: 70, height: 40)
                    .foregroundColor(.white)
                    .background(Color.pink)
                    .cornerRadius(10)
            }
            .disabled(selectedCoin == nil || Double(amount) == nil || Double(amount)! <= 0)
            .alert(isPresented: $showingAlert) {
                Alert(
                    title: Text(alertTitle),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("OK")) {
                        if alertTitle == "Success" {
                            userViewModel.fetchTransactionsForCurrentUser()
                            self.isShowingPurchase = false
                        }
                    }
                )
            }

            Spacer()
        }
        .padding()
    }
    
    var currencyFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "en_US")
        return formatter
    }
    
    private func purchaseCrypto(coin: Coin, amount: Double) {
        let totalCost = amount * coin.currentPrice
        if let userBalance = userViewModel.currentUser?.balance, userBalance >= totalCost {
            userViewModel.purchaseCurrency(coin: coin, amount: amount)
            alertTitle = "Success"
            alertMessage = "You have successfully purchased \(amount) \(coin.name)."
            showingAlert = true
        } else {
            alertTitle = "Insufficient Funds"
            alertMessage = "You do not have enough balance to make this purchase."
            showingAlert = true
        }
    }
}
