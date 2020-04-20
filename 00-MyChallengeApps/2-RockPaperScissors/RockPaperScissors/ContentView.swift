//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Eric Krenz on 4/20/20.
//  Copyright © 2020 Eric Krenz. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    // Alert Variables
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    @State private var userScore = 0
    
    // UI Variables
    @State private var userChoice = 1
    @State private var winGame = false
    @State private var cpuChoice = Int.random(in: 0...2)
    
    let allChoices = ["Rock", "Paper", "Scissors"]
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.gray, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                VStack(spacing: 10) {
                    Text("Rock, Paper, Scissors!")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                    Text("Make your selection below...")
                        .foregroundColor(.white)
                }
                
                ForEach(0..<3) { number in
                    Button(action: {
                        self.userChoice = number
                        self.buttonTapped(number)
                    }){
                        Text(self.allChoices[number])
                            .font(.title)
                            .foregroundColor(.black)
                            .fontWeight(.black)
                            .frame(width: 200, height: 75, alignment: .center)
                            .background(Color.white)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color .gray, lineWidth: 1))
                            .shadow(color: .black, radius: 2)
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
            self.newGame()
        })
        }
    }
    
    func buttonTapped(_ number: Int) {
        if(number == cpuChoice) {
            scoreTitle = "You Tie!"
            scoreMessage = "\(allChoices[userChoice]) ties \(allChoices[cpuChoice])!"
        } else if(number - 1 == cpuChoice || number + 2 == cpuChoice) {
            scoreTitle = "You Win!"
            scoreMessage = "\(allChoices[userChoice]) beats \(allChoices[cpuChoice])!"
            userScore += 1
        } else {
            scoreTitle = "You Lose!"
            scoreMessage = "\(allChoices[userChoice]) loses to \(allChoices[cpuChoice])!"
        }
        
        showingScore = true
    }
    
    func newGame() {
        cpuChoice = Int.random(in: 0...2)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
