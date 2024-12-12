//
//  ContentView.swift
//  DepositCalculator
//
//  Created by Rassul Bessimbekov on 12.12.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var amount: String = ""
    @State private var selectedPeriod: PlacementPeriod = .threeMonths
    
    private var finalAmount: Double {
        // Convert string to number, handling both dot and comma as decimal separators
        let cleanedAmount = amount.replacingOccurrences(of: ",", with: ".")
        guard let amountValue = Double(cleanedAmount) else { return 0 }
        
        let calculation = DepositCalculation(amount: amountValue, period: selectedPeriod)
        return calculation.calculateFinalAmount()
    }
    
    func formatCurrency (_ payload: Double) -> String {
        return "\(String(format: "%.2f", payload).replacingOccurrences(of:".", with:","))₸"
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Deposit Calculator")
                .font(.largeTitle)
                .padding()
            
            VStack(alignment: .leading/*, spacing: 10*/) {
                Text("Deposit amount")
                    .padding(.horizontal)

                HStack {
                    TextField("Enter amount", text: $amount)
                        .keyboardType(.decimalPad)
                        .padding(12)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                        .padding(.leading)
                        .padding(.bottom, 5)
                        .font(.system(size: 14))
                    Text("₸")
                        .padding(.trailing)
                        .font(.title)
                    
                }
                
                Picker("Select period", selection: $selectedPeriod) {
                    ForEach(PlacementPeriod.allCases, id: \.self) { period in
                        Text(period.displayText)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
            }
            
            VStack {
                Text("💰You will save up   ")
                    .font(.headline)
                Text(formatCurrency(finalAmount))
                    .font(.system(size: 34, weight: .bold))
                    .foregroundColor(.green)
                Text("*It is the preliminary calculation")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding()
            .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 5) {
                Text("Rate of return: \(String(format: "%.1f", selectedPeriod.rateOfReturn))%")
                    .foregroundColor(.gray)
                Text("Effective rate: \(String(format: "%.1f", selectedPeriod.effectiveRate))%")
                    .foregroundColor(.gray)
            }
            .padding()
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
} 
