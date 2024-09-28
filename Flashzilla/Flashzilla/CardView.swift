//
//  CardView.swift
//  Flashzilla
//
//  Created by Alfonso Acosta on 2024-09-25.
//

import SwiftUI

struct CardView: View {
    let card: Card
    //We need to remove the cardview from the parent view. We don't want cardview to call up contentview and maniuplate the data there -- this is bad code. instead, we store this closure so that we have the flexibility of getting a callback without tying the two views tgt.
    var remove: (() -> Void)? = nil
    @State private var isShowingAnswer = false
    @State private var offset = CGSize.zero
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 25)
                .fill(
                    .white
                        .opacity(1 - Double(abs(offset.width / 50)))
                ) //blending in colours
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .fill(offset.width > 0 ? .green : .red)
                )//background of same rounded rectangle except in green or red depending on movement
                .shadow(radius: 10)
            
            VStack{
                Text(card.prompt)
                    .font(.largeTitle)
                    .foregroundStyle(.black)
                
                if isShowingAnswer{
                    Text(card.answer)
                        .font(.title)
                        .foregroundStyle(.secondary)
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250)
        .onTapGesture {
            isShowingAnswer.toggle()
        }
        .animation(.bouncy, value: offset)
        .rotationEffect(.degrees(offset.width / 5.0)) //recall that modifier order matters
        .offset(x: offset.width * 5)
        .opacity(2 - Double(abs(offset.width / 50)))
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                }
                .onEnded { _ in
                    if abs(offset.width) > 100 {
                        remove?() //question mark means the closure will only be called if it has been set
                    } else {
                        offset = .zero
                    }
                }
        )
        //smallest i phone devices have width 480
    }
}

#Preview {
    CardView(card: .example)
}
