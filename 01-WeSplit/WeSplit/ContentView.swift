//
//  ContentView.swift
//  WeSplit
//
//  Created by Eric Krenz on 4/10/20.
//  Copyright © 2020 Eric Krenz. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmmount = ""
    @State private var numberOfPeople = ""
    @State private var tipPercentage = 2
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalAfterTip: Double {
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmmount = Double(checkAmmount) ?? 0
        
        let tipValue = orderAmmount / 100 * tipSelection
        let grandTotal = orderAmmount + tipValue
        
        return grandTotal
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople) ?? 1
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmmount = Double(checkAmmount) ?? 0
        
        let tipValue = orderAmmount / 100 * tipSelection
        let grandTotal = orderAmmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmmount)
                        .keyboardType(.decimalPad)
                    
                    TextField("Number of People", text: $numberOfPeople)
                        .keyboardType(.decimalPad)
                    /*
                     Picker("Number of People", selection: $numberOfPeople) {
                     ForEach(2 ..< 100) {
                     Text("\($0) people")
                     }
                     }
                     */
                }
                
                Section(header: Text("How much tip do you want to leave?")) {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Total After Tip:")) {
                    if totalAfterTip == Double(checkAmmount) {
                        Text("$\(totalAfterTip, specifier: "%.2f")")
                            .foregroundColor(.red)
                    } else {
                        Text("$\(totalAfterTip, specifier: "%.2f")")
                    }
                }
                
                Section(header: Text("Amount Per Person:")) {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
                .navigationBarTitle("WeSplit")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
