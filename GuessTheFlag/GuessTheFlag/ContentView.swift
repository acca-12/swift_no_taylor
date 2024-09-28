//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Alfonso Acosta on 2024-09-19.
//

import SwiftUI

struct ContentView: View {
    
    //stacks are a way of placing items in bunches, they can take on parameters as well, such as spacing and alignment
    //vertical and horizontal stacks automatically fit their content, and prefer to align themselves to the center of the avaliable space. you can change this by using Spacer views to push the contents.
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var showScore = false
    @State private var scoreTitle = ""
    @State var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    @State private var numAnswered = 0
    @State private var restart = false
    func flagTapped(_ number: Int, _ chosen: String = ""){
        if number == correctAnswer{
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong, that's the flag of \(chosen)"
        }
        numAnswered += 1
        if(numAnswered == 8){
            restart = true
        } else {
            showScore = true
        }
    }
    
    func askQ(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func reset(){
        numAnswered = 0
        score = 0
    }
    var body: some View {
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
            .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                VStack(spacing: 15){
                    VStack{
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .foregroundStyle(.white)
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3){ number in
                        Button{
                            flagTapped(number, countries[number])
                        } label: {
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                .padding()
            }
        }
        .alert(scoreTitle, isPresented: $showScore){
            Button("Continue", action: askQ)
        } message: {
            Spacer() //for different device purposes
            Spacer()
            Text("Your Score is \(score)")
                .foregroundStyle(.white)
                .font(.title.bold())
            Spacer()
        }
        .alert("Game Over", isPresented: $restart){
            Button("Restart") {
                reset()
            }
        } message: {
            Spacer() //for different device purposes
            Spacer()
            Text("Your final score is \(score) / 8")
                .foregroundStyle(.white)
                .font(.title.bold())
            Spacer()
        }
    }
}



#Preview {
    ContentView()
}
