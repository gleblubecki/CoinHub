import Foundation
import SwiftUI

extension SecureField {
    func customSecureFieldStyle(placeholder: String, text: Binding<String>, backgroundColor: Color, textColor: Color) -> some View {
        self
            .padding(10)
            .background(RoundedRectangle(cornerRadius: 8).fill(backgroundColor))
            .textFieldStyle(PlainTextFieldStyle())
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(Color("RowColor"), lineWidth: 1)
            )
            .foregroundColor(text.wrappedValue.isEmpty ? textColor : Color.primary)
            .font(.body)
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .padding([.leading, .trailing])
            .overlay(
                Text(placeholder)
                    .foregroundColor(Color.secondary)
                    .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 0))
                    .background(backgroundColor.opacity(0), alignment: .leading),
                alignment: .leading
            )
            .onTapGesture {
                if text.wrappedValue.isEmpty {
                    withAnimation {
                        text.wrappedValue = ""
                    }
                }
            }
    }
}
