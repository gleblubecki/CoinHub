import SwiftUI

struct TopUpView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    
    @Binding var isShowingTopUp: Bool

    @State private var amount: String = ""
    
    var body: some View {
        VStack {
            Text("Top Up Balance")
                .foregroundColor(.pink)
                .fontWeight(.semibold)
                .font(.title)
            
            TextField("Enter ammount", text: $amount)
                .customTextFieldStyle(placeholder: "", text: $amount, backgroundColor: Color("RowColor"), textColor: Color.pink)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .autocapitalization(.none)
                .keyboardType(.numberPad)

            Button(action: {
                if let topUpAmount = Double(amount) {
                    userViewModel.topUpBalance(amount: topUpAmount)
                    amount = ""
                    isShowingTopUp = false
                }
            }) {
                Text("Top Up")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.pink)
                    .cornerRadius(10)
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
}

