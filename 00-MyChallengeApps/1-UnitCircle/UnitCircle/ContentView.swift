//
//  ContentView.swift
//  UnitCircle
//
//  Created by Eric Krenz on 4/13/20.
//  Copyright © 2020 Eric Krenz. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var oldAngle = ""
    @State private var oldUnit = 0
    @State private var newUnit = 0
    
    let measures = ["Degrees", "Radians", "Gradians", "Revolutions"]
    
    var newAngle: Measurement<UnitAngle> {
        let originalAngle = Double(oldAngle) ?? 0
        var convertedToDegrees = Measurement(value: 0, unit: UnitAngle.degrees)
        
        switch oldUnit {
        case 0:
            convertedToDegrees = Measurement(value: originalAngle, unit: UnitAngle.degrees)
        case 1:
            let radians = Measurement(value: originalAngle, unit: UnitAngle.radians)
            convertedToDegrees = radians.converted(to: .degrees)
        case 2:
            let radians = Measurement(value: originalAngle, unit: UnitAngle.gradians)
            convertedToDegrees = radians.converted(to: .degrees)
        case 3:
            let revolutions = Measurement(value: originalAngle, unit: UnitAngle.revolutions)
            convertedToDegrees = revolutions.converted(to: .degrees)
        default:
            convertedToDegrees = Measurement(value: 0, unit: UnitAngle.degrees)
        }
        
        switch newUnit {
        case 0:
            return convertedToDegrees
        case 1:
            return convertedToDegrees.converted(to: .radians)
        case 2:
            return convertedToDegrees.converted(to: .gradians)
        case 3:
            return convertedToDegrees.converted(to: .revolutions)
        default:
            return Measurement(value: 0, unit: UnitAngle.degrees)
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Initial Measurement")) {
                    TextField("Angle in \(self.measures[oldUnit])", text: $oldAngle)
                        .keyboardType(.decimalPad)
                    
                    Picker("Unit Type", selection: $oldUnit) {
                        ForEach(0..<measures.count) {
                            Text("\(self.measures[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Calculated Measurement")) {
                    Text("\(newAngle.value)")
                    
                    Picker("Unit Type", selection: $newUnit) {
                        ForEach(0..<measures.count) {
                            Text("\(self.measures[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            .navigationBarTitle("UnitCircle")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
