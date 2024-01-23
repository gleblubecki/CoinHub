import SwiftUI

struct CurrencyView: View {
    @State private var isShowingInfo = false
    @EnvironmentObject private var vm: CurrencyViewModel
    
    var body: some View {
        ZStack {
            Color("ThemeColor")
                .ignoresSafeArea()
            
        
            VStack {
                HStack {
                    Spacer()
                    Spacer()
                    
                    Text("Live Prices")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.pink)
                        .animation(.none)
                    
                    Spacer()
                    
                    Button {
                        isShowingInfo = true
                    } label: {
                        VStack(spacing: 2) {
                            Image(systemName: "info.circle")
                                .frame(width: 52, height: 52)
                                .foregroundColor(.pink)
                                .background(Color("RowColor"))
                                .cornerRadius(100)
                        }
                    }
                    .sheet(isPresented: $isShowingInfo, content: {
                        InfoView()
                    })
                }
                .padding()
                
                HStack() {
                    Text("Coin")
                    
                    Spacer()
                    
                    Text("")
                    Text("Price")
                }
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.horizontal)
                
                List {
                    ForEach(vm.allCoins) { coin in
                            CoinRowView(coin: coin)
                                .listRowBackground(Color("ThemeColor"))

                    }
                }
                .listStyle(PlainListStyle())
                .edgesIgnoringSafeArea(.all)
                .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0)
            }
        }
    }
}

#Preview {
    NavigationView {
        CurrencyView()
            .navigationBarBackButtonHidden(true)
    }
    .environmentObject(CurrencyViewModel())
}
