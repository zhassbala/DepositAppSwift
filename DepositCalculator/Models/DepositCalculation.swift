import Foundation

// Enum for period selection (3, 6, or 12 months)
enum PlacementPeriod: Int, CaseIterable {
    case threeMonths = 3
    case sixMonths = 6
    case twelveMonths = 12
    
    var displayText: String {
        "\(self.rawValue) months"
    }
    
    // Rate of return for each period
    var rateOfReturn: Double {
        switch self {
        case .threeMonths: return 12.8
        case .sixMonths: return 13.1
        case .twelveMonths: return 13.0
        }
    }
    
    // Effective rate for each period
    var effectiveRate: Double {
        switch self {
        case .threeMonths: return 13.6
        case .sixMonths: return 13.9
        case .twelveMonths: return 13.8
        }
    }
}

struct DepositCalculation {
    // Properties
    let amount: Double
    let period: PlacementPeriod
    
    func calculateFinalAmount() -> Double {
        // Convert annual rate to monthly rate and to decimal
        // Example: 12.8% / 12 = 1.067% per month = 0.01067
        let monthlyRate = period.rateOfReturn / 12 / 100
        
        // Simple interest formula: A = P(1 + rt)
        // where: A = final amount, P = principal (initial amount),
        // r = monthly rate, t = number of months
        return amount * (1 + monthlyRate * Double(period.rawValue))
    }
} 