//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Maxiromanoff on 02/11/2022.
//

import SwiftUI

struct ImageCard: View {
    var name: String
    var body: some View {
        Image(name)
            .resizable()
            .scaledToFit()
            .aspectRatio(contentMode: .fit)
    }
}

struct TextColor: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.primary)
    }
}

extension View {
    func Print(_ vars: Any...) -> some View {
        for v in vars { print(v) }
        return EmptyView()
    }
    
    func coloredText() -> some View {
        self.modifier(TextColor())
    }
}

struct ContentView: View {
    let gameChoices = ["🖐", "✌️", "✊"]
    @State private var userScore = 0;
    @State private var countTurns = 0;
    @State private var playerAnswer = 0;
    @State private var titleResult = ""
    @State private var showingScore = false
    @State private var relation = Bool.random() ? "WIN" : "LOSE"
    @State private var machineChoiceIndex = Int.random(in: 0...2);
    @State private var images = ["paper", "scissors", "rock"]
    private var correctAnswer: Int {
        return (relation == "WIN") ? (machineChoiceIndex + 1) % 3 : (machineChoiceIndex + 2) % 3
    }
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(
                    colors: [
                        Color(red: 248/255, green: 237/255, blue: 227/255),
                        Color(red: 223/255, green: 211/255, blue: 195/255),
                        Color(red: 208/255, green: 184/255, blue: 168/255),
                        Color(red: 125/255, green: 110/255, blue: 131/255),
                    ]
                ),startPoint: .top, endPoint: .bottom
            ).ignoresSafeArea()
            
            VStack(spacing: 20) {
                Spacer()
                Text("RockPaperScissors")
                    .font(.largeTitle.bold())
                    .modifier(TextColor())
                    .padding(.bottom, 35)
                
                Text("Machine plays: \(self.gameChoices[machineChoiceIndex])")
                    .font(.system(size: 30))
                    .modifier(TextColor())
                
                Spacer()
                Text("To \(relation)")
                    .font(.system(size: 35).weight(.semibold))
                    .modifier(TextColor())
                
                Spacer()
                Section {
                    Text("You should play:")
                        .font(.system(size: 30))
                        .foregroundColor(.primary)
                        .padding(.bottom, 15)
                    HStack {
                        ForEach(0...2, id: \.self ) { index in
                            Button(action: {self.checkAnswer(playerAnswer: index)}) {
                                ImageCard(name: images[index])
                            }
                        }
                    }.padding(.horizontal, 15)
                }
                Spacer()
                Spacer()
            }
        }
        .alert(titleResult, isPresented: $showingScore) {
            if(countTurns >= 10) {
                Button("Cancel", role: .cancel){}
                Button("Start New Round") {startNewGame()}
            } else {
                Button("Continue") {continueGame()}
                Button("Cancel", role: .cancel){}
            }
        } message: {
            countTurns >= 10 ? Text("The player score is \(userScore)") : nil
        }
    }
    
    func checkAnswer (playerAnswer: Int) {
        if(playerAnswer == self.correctAnswer) {
            userScore += 1
            titleResult = "Congratulation!"
        } else {
            if(userScore > 0) {
                userScore -= 1
            } else {
                userScore = 0
            }
            titleResult = "Opps.Loose!"
        }
        showingScore = true
        countTurns += 1
    }
    
    func continueGame() {
        machineChoiceIndex = Int.random(in: 0...2)
        relation =  Bool.random() ? "WIN" : "LOSE"
    }
    
    func startNewGame() {
        continueGame()
        userScore = 0
        countTurns = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
