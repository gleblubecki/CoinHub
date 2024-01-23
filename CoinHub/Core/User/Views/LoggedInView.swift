import SwiftUI
import RealmSwift

struct LoggedInView: View {
    @State private var isShowingTopUp = false
    
    @EnvironmentObject var userViewModel: UserViewModel
    
    var body: some View {
        ZStack {
            Color("ThemeColor")
                .ignoresSafeArea()

            VStack(spacing: 30) {
                Text("Account")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.pink)
                    .animation(.none)

                if let user = userViewModel.currentUser {
                    let username = String(user.email.split(separator: "@").first ?? "")
                    
                    Text("Welcome, \(username)")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .animation(.none)
                }

                if let user = userViewModel.currentUser {
                    HStack {
                        Text("Balance:")
                            .foregroundColor(.pink)
                            .fontWeight(.semibold)
                            .font(.title3)

                        Text("\(currencyFormatter.string(from: NSNumber(value: user.balance)) ?? "")")
                            .foregroundColor(.white)
                            .font(.title3)
                        
                        Button {
                            isShowingTopUp = true
                        } label: {
                            VStack(spacing: 2) {
                                Image(systemName: "plus.circle")
                                    .foregroundColor(.pink)
                                    .background(Color("ThemeColor"))
                                    .cornerRadius(100)
                            }
                        }
                        .sheet(isPresented: $isShowingTopUp, content: {
                            TopUpView(isShowingTopUp: $isShowingTopUp)
                        })
                    }
                }

                Spacer()

                Button(action: {
                    userViewModel.logOut()
                }) {
                    Text("Log Out")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(12)
                }
                .padding()
            }
            .padding(30)
        }
        .onAppear {
            userViewModel.loadCurrentUser()
        }
    }
    
    var currencyFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "en_US")
        return formatter
    }
}
