import SwiftUI

struct BuyerView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    
    @State private var isShowingPurchase = false

    var body: some View {
        ZStack {
            ZStack {
                Color("ThemeColor")
                    .ignoresSafeArea()
                
                VStack {
                    HStack {
                        Spacer()
                        Spacer()
                        Spacer()
                        
                        Text("Wallet")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.pink)
                            .animation(.none)
                        
                        Spacer()
                        Spacer()
                        
                        Button {
                            isShowingPurchase = true
                        } label: {
                            VStack(spacing: 2) {
                                Image(systemName: "dollarsign.arrow.circlepath")
                                    .frame(width: 52, height: 52)
                                    .foregroundColor(.pink)
                                    .background(Color("RowColor"))
                                    .cornerRadius(100)
                            }
                        }
                        .sheet(isPresented: $isShowingPurchase, content: {
                            PurchaseView(isShowingPurchase: $isShowingPurchase)
                        })
                    }
                    .padding()
                    
                    Text("Your Cripto")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .animation(.none)
                                        
                    HStack() {
                        Text("Coin")
                        
                        Spacer()
                        
                        Text("")
                        Text("Amount")
                    }
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                    
                    List {
                        ForEach(Array(userViewModel.consolidatedCryptoHoldings.keys), id: \.self) { key in
                            HStack {
                                
                                
                                Text(key)
                                
                                Spacer()
                                
                                Text("\(userViewModel.consolidatedCryptoHoldings[key] ?? 0, specifier: "%.4f")")
                            }
                            .listRowBackground(Color("ThemeColor"))

                        }
                    }
                    .listStyle(PlainListStyle())
                    .edgesIgnoringSafeArea(.all)
                }
                
            }
            .blur(radius: userViewModel.isUserLoggedIn ? 0 : 10)
            
            if !userViewModel.isUserLoggedIn {
                Text("Log In to access your wallet")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.pink)
                    .animation(.none)
            }

        }
        .onAppear {
            if userViewModel.isUserLoggedIn {
                userViewModel.fetchTransactionsForCurrentUser()
            }
        }
    }
}

#Preview {
    BuyerView()
}
