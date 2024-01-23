import Foundation

extension Double {
    private var currencyFormatter6: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = . currency
        
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6
        return formatter
    }
    
    func asCurrencyWith6Decimals () -> String {
        let number = NSNumber (value: self)
        return currencyFormatter6.string(from: number) ?? "$0.00"
    }
    
    func asNumberString() -> String {
        return String(format: "%.2f", self)
    }
    
    func asPercentString() -> String {
        return asNumberString() + "%"
    }
}
