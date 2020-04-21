//
//  ContentView.swift
//  BetterRest
//
//  Created by Eric Krenz on 4/20/20.
//  Copyright © 2020 Eric Krenz. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("When do you want to wake up?")
                    .font(.headline)) {
                        
                        DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                            .datePickerStyle(WheelDatePickerStyle())
                }
                
                Section(header: Text("Desired Amount of Sleep:")
                    .font(.headline)) {
                        
                        Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                            Text("\(sleepAmount, specifier: "%g") hours")
                        }
                }
                
                Section(header: Text("Daily Coffee Intake:")
                    .font(.headline)) {
                        
                        /*
                         Stepper(value: $coffeeAmount, in: 1...20) {
                         if coffeeAmount == 1 {
                         Text("1 cup")
                         } else {
                         Text("\(coffeeAmount) cups")
                         }
                         }
                         */
                        
                        Picker("Cups of Coffee", selection: $coffeeAmount) {
                            ForEach(0 ..< 20) {
                                if $0 == 1 {
                                    Text("\($0) cup")
                                } else {
                                    Text("\($0) cups")
                                }
                            }
                        }
                }
                
                Section(header: Text("Your ideal bedtime is...")
                    .font(.headline)) {
                        
                        Text("\(self.calculateBedtime())")
                            .font(.title)
                            .fontWeight(.black)
                }
            }
            .navigationBarTitle("Better Rest")
            /*
             .navigationBarItems(trailing:
             Button(action: calculateBedtime) {
             Text("Calculate")
             }
             )
             .alert(isPresented: $showingAlert) {
             Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
             }
             */
        }
    }
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    
    func calculateBedtime() -> String {
        let model = SleepCalculator()
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        
        do {
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            
            return formatter.string(from: sleepTime)
            
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
            showingAlert = true
        }
        
        return "Error"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
