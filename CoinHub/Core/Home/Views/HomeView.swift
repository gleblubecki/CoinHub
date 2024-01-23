import SwiftUI

struct HomeView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @StateObject var coinDataService = CoinDataService()

    var body: some View {
        TabView {
            CurrencyView()
                .tabItem {
                    Label("Currency", systemImage: "arrow.down.left.arrow.up.right")
                }
            
            BuyerView()
                .tabItem {
                    Label("Wallet", systemImage: "wallet.pass")
                }

            AccountView()
                .tabItem {
                    Label("Account", systemImage: "brain.head.profile")
                }
        }
        .accentColor(Color.pink)

    }
}

#Preview {
    HomeView()
}
