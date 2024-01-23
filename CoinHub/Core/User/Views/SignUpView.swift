import SwiftUI
import RealmSwift

struct SignUpView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    
    @State private var isEmailValid: Bool = false
    @State private var isPasswordValid: Bool = false
    @State private var registrationCompleted = false

    @State private var showAlert = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    
    @Binding var isSignUpActive: Bool
    @Environment(\.presentationMode) var presentationMode
            
    @EnvironmentObject var userViewModel: UserViewModel
    
    var body: some View {
        ZStack {
            Color("ThemeColor")
                .ignoresSafeArea()

            VStack {
                Text("Sign Up")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.pink)
                    .animation(.none)

                TextField("Email", text: $email)
                    .customTextFieldStyle(placeholder: "", text: $email, backgroundColor: Color("RowColor"), textColor: Color.pink)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .autocapitalization(.none)
                    .onChange(of: email, perform: { value in
                        isEmailValid = isValidEmail(value)
                    })

                SecureField("Password", text: $password)
                    .customSecureFieldStyle(placeholder: "", text: $email, backgroundColor: Color("RowColor"), textColor: Color.pink)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .textContentType(.none)
                    .onChange(of: password, perform: { value in
                        isPasswordValid = isValidPassword(value)
                    })

                SecureField("Confirm Password", text: $confirmPassword)
                    .customSecureFieldStyle(placeholder: "", text: $email, backgroundColor: Color("RowColor"), textColor: Color.pink)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .textContentType(.none)

                Button(action: {
                    validateAndSignUp()
                }) {
                    VStack(spacing: 2) {
                        Text("Create Account")
                            .frame(width: 150, height: 42)
                            .foregroundColor(.white)
                            .background(.pink)
                            .cornerRadius(12)
                    }
                }
                .padding()
                .disabled(!(isEmailValid && isPasswordValid && password == confirmPassword))
                .onTapGesture {
                    DispatchQueue.main.async {
                        validateAndSignUp()
                    }
                }

                Spacer()
            }
            .padding()
            .alert(isPresented: $showAlert) {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }

    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }

    private func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Z])(?=.*[0-9]).{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
    }

    private func validateAndSignUp() {
        if isEmailValid && isPasswordValid && password == confirmPassword {
            if userViewModel.doesUserExistWithEmail(email) {
                showAlert(title: "Error", message: "Email already exists. Please use a different email.")
            } else {
                userViewModel.createUser(email: email, password: password)
                showAlert(title: "Success", message: "Sign Up successful")
                // Закрыть SignUpView после успешной регистрации
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
        } else {
            var errorMessage = "Sign Up failed. Please check your input:\n"

            if !isEmailValid {
                errorMessage += "- Invalid email address\n"
            }

            if !isPasswordValid {
                errorMessage += "- Invalid password. Password must have at least 8 characters, one uppercase letter, and one digit.\n"
            }

            if password != confirmPassword {
                errorMessage += "- Passwords do not match\n"
            }

            showAlert(title: "Error", message: errorMessage)
        }
    }

    private func showAlert(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        showAlert = true
    }
}
