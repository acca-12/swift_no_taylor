//
//  ContentView.swift
//  Flashzilla
//
//  Created by Alfonso Acosta on 2024-09-25.
//

import SwiftUI

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = Double(total - position)
        return self.offset(y: offset * 10)
    }
}
//by offsetting the view, it gives an attractive card stack effect

struct ContentView: View {
    @State private var timeRemaining = 100
    @State private var cards = Array<Card>(repeating: .example, count: 10)
    //pass in our trailing closure syntax
    @Environment(\.scenePhase) var scenePhase
    @State private var isActive = true //variable for keeping track of if it's in the backround or not
    //give users 100 sec to start with then fires once a second on the main thread
    
    func resetCards(){
        cards = Array<Card>(repeating: .example, count: 10)
        timeRemaining = 100
        isActive = true
    } //resets when we fly through the flash cards
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
    
    func removeCard(at index: Int){
        cards.remove(at: index)
        if cards.isEmpty {
            isActive = false //pauses timer
        }
    }
    var body: some View {
        ZStack {
            Image(decorative: "background")
                .resizable()
                .ignoresSafeArea()
            VStack {
                Text("Time: \(timeRemaining)")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(.black.opacity(0.75))
                    .clipShape(.capsule)
                ZStack {
                    //recall z stack is top bottom => back front
                    ForEach(0..<cards.count, id: \.self) { index in
                        CardView(card: cards[index]){
                            //cards automatically slide up
                            withAnimation {
                                removeCard(at: index)
                            }
                        }
                        .stacked(at: index, in: cards.count)
                        .allowsHitTesting(index == cards.count - 1) //ensures only top card can be dragged
                    }
                }
                .allowsHitTesting(timeRemaining > 0) //disables swiping when time hits 0
                
                //show button only if the user has flown through the current stack
                if cards.isEmpty {
                    Button("Start Again", action: resetCards)
                        .padding()
                        .background(.white)
                        .foregroundStyle(.black)
                        .clipShape(.capsule)
                }
            }
        }
        .onReceive(timer) { time in
            guard isActive else { return } //with this change the timer automatically pauses when app moves to the background
            if timeRemaining > 0 {
                timeRemaining -= 1
            }
        } //currently timer runs for a few seconds in the background, pauses then app comes back
        .onChange(of: scenePhase) {
            if scenePhase == .active {
                if cards.isEmpty == false{ //makes sure it stays false when returning from the background
                    isActive = true
                }
            } else {
                isActive = false
            }
        }
    }
}

#Preview {
    ContentView()
}
