import SwiftUI

@main
struct CoinHubApp: App {
    @StateObject var vm = CurrencyViewModel()
    @StateObject private var userViewModel = UserViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarBackButtonHidden(true)
                    .preferredColorScheme(.dark)
                    .environmentObject(userViewModel)
            }
            .environmentObject(vm)
        }
    }
}
