import SwiftUI

struct InfoView: View {
    var body: some View {
        Image("CoinLogo")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 200, height: 200)
        
        VStack {
            Text("About App")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.pink)
            
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .frame(width: 350, height: 260)
                    .foregroundColor(Color("RowColor"))
                
                Text("CoinHub is a mobile application created as part of Andersen's iOS Intensive. The app provides users with a user-friendly interface to track current cryptocurrency rates, simulate buying and selling cryptocurrency, and register an account for personalized settings. CoinHub allows users to analyze market data and stay up-to-date.")
                    .multilineTextAlignment(.center)
                    .font(.headline)
                    .frame(width: 270)
                    .foregroundColor(.white)
                    .padding(.horizontal, 5)
                    .padding(.top, 5)
            }
        }
        .edgesIgnoringSafeArea(.all)
        
        Spacer()
    }
}

#Preview {
    InfoView()
}
