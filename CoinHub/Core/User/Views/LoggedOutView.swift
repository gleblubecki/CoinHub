import SwiftUI
import RealmSwift

struct LoggedOutView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isSignUpActive: Bool = false
    @State private var loginError: Bool = false
    
    @EnvironmentObject var userViewModel: UserViewModel
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        NavigationView {
            ZStack() {
                Color("ThemeColor")
                    .ignoresSafeArea()

                VStack(spacing: 30) {
                    Text("Account")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.pink)
                        .animation(.none)

                    VStack(spacing: 16) {
                        TextField("Email", text: $username)
                            .customTextFieldStyle(placeholder: "", text: $username, backgroundColor: Color("RowColor"), textColor: .pink)

                        SecureField("Password", text: $password)
                            .customSecureFieldStyle(placeholder: "", text: $password, backgroundColor: Color("RowColor"), textColor: .pink)
                    }

                    VStack {
                        Button {
                            loginUser()
                        } label: {
                            VStack(spacing: 2) {
                                Text("Log In")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .frame(width: 72, height: 36)
                                    .foregroundColor(.white)
                                    .background(.pink)
                                    .cornerRadius(12)
                            }
                        }
                        .alert(isPresented: $loginError) {
                            Alert(
                                title: Text("Login Failed"),
                                message: Text("Invalid email or password. Please try again."),
                                dismissButton: .default(Text("OK"))
                            )
                        }

                        NavigationLink(destination: SignUpView(isSignUpActive: $isSignUpActive), isActive: $isSignUpActive) {
                            Button {
                                isSignUpActive = true
                            } label: {
                                VStack(spacing: 2) {
                                    Text("You don't have an account? Sign Up")
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                        .frame(width: 256, height: 55)
                                        .foregroundColor(.pink)
                                }
                            }
                        }
                        .onChange(of: isSignUpActive) { newValue in
                            if newValue {
                                presentationMode.wrappedValue.dismiss()
                            }
                        }
                    }

                    Spacer()
                }
                .padding(30)
            }
            .navigationBarHidden(true)
        }
    }

    private func loginUser() {
        let isLoginSuccessful = userViewModel.loginUser(email: username, password: password)

        if isLoginSuccessful {
            loginError = false
        } else {
            loginError = true
        }
    }
}


#Preview {
    LoggedOutView()
}
