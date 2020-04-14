//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Eric Krenz on 4/14/20.
//  Copyright © 2020 Eric Krenz. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.yellow.edgesIgnoringSafeArea(.all)
            Text("My Content")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
