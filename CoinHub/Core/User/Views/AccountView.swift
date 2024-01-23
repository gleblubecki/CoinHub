import SwiftUI

struct AccountView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @State private var showAlert = false

    var body: some View {
        NavigationView {
            VStack {
                if userViewModel.isUserLoggedIn {
                    LoggedInView()
                        .navigationBarHidden(true)
                } else {
                    LoggedOutView()
                        .navigationBarHidden(true)
                }
            }
            .onChange(of: userViewModel.isUserLoggedIn) { _ in
                userViewModel.loadCurrentUser()
            }
        }
    }
}

#Preview {
    AccountView()
        .environmentObject(UserViewModel())
}
