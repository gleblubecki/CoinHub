import SwiftUI

struct BuyerRowView: View {
    
    let coin: Coin
    
    var body: some View {
        ZStack {
            HStack {
                Text("\(coin.rank)")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                    .frame(minWidth: 30)
                
                AsyncImage(url: URL(string: coin.image)) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                        
                    case .failure:
                        Text("Не удалось загрузить изображение")
                        
                    case .empty:
                        ProgressView()
                        
                    @unknown default:
                        EmptyView()
                    }
                }
                
                Text(coin.symbol.uppercased())
                    .font(.headline)
                    .padding(.leading, 6)
                    .foregroundColor(.white)
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("\(currencyFormatter.string(from: NSNumber(value: coin.currentPrice)) ?? "")")
                        .bold()
                        .foregroundColor(.white)
                    
                    Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
                        .foregroundColor(
                            (coin.priceChangePercentage24H ?? 0) >= 0 ?
                            Color.green : Color.red
                        )
                }
            }
        }
    }
    
    var currencyFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "en_US")
        return formatter
    }
}

struct BuyerRowView_Previews: PreviewProvider {
    static var previews: some View {
        BuyerRowView(coin: dev.coin)
    }
}
