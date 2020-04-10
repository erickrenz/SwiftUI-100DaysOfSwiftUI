//
//  ContentView.swift
//  WeSplit
//
//  Created by Eric Krenz on 4/10/20.
//  Copyright © 2020 Eric Krenz. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var tapCount = 0
    @State private var name = ""
    
    let students = ["Harry", "Hermoine", "Ron"]
    @State private var selectedStudent = "Harry"
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Text("Hello, World!")
                }
            
                Button("Tap Count: \(tapCount)") {
                    self.tapCount += 1
                }
                
                Section {
                    TextField("Enter your name...", text: $name)
                    Text("Your name is \(name)")
                }
                
                Picker("Select your student", selection: $selectedStudent) {
                    ForEach(0 ..< students.count) {
                        Text(self.students[$0])
                    }
                }
            }
            .navigationBarTitle(Text("SwiftUI"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
