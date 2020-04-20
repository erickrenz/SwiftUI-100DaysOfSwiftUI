//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Eric Krenz on 4/15/20.
//  Copyright © 2020 Eric Krenz. All rights reserved.
//

import SwiftUI

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
            .padding()
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

extension View {
    func titleStyle() -> some View {
        self.modifier(Title())
    }
}

struct Watermark: ViewModifier {
    var text: String
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .background(Color.black)
        }
    }
}

extension View {
    func watermarked(with text: String) -> some View {
        self.modifier(Watermark(text: text))
    }
}

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.blue
                .frame(width: 300, height: 200)
                .watermarked(with: "krenz.co")
            
            Text("Hello, World!")
                .titleStyle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
