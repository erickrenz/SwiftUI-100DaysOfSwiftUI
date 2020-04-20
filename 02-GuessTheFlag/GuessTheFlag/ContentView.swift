//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Eric Krenz on 4/14/20.
//  Copyright © 2020 Eric Krenz. All rights reserved.
//

import SwiftUI

struct FlagImage: ViewModifier {
    var image: String
    
    func body(content: Content) -> some View {
        Image(image)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color .black, lineWidth: 1))
            .shadow(color: .black, radius: 2)
    }
}

extension View {
    func flagStyle(flag: String) -> some View {
        self.modifier(FlagImage(image: flag))
    }
}

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    @State private var userScore = 0
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Monaco", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                ForEach(0..<3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }){
                        Image(self.countries[number])
                            .flagStyle(flag: self.countries[number])
                    }
                }
                
                Text("Your score is \(userScore)")
                    .foregroundColor(.white)
                    .fontWeight(.black)
                
                Spacer()
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("\(scoreMessage)"), dismissButton: .default(Text("Continue")) {
                    self.askQuestion()
                })
        }
    }
    
    func flagTapped(_ number: Int) {
        if(number == correctAnswer) {
            scoreTitle = "Correct"
            userScore += 1
            scoreMessage = "Your score is \(userScore)"
        } else {
            scoreTitle = "Wrong"
            scoreMessage = "That is the flag of \(countries[number])"
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
