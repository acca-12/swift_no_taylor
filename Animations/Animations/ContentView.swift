//
//  ContentView.swift
//  Animations
//
//  Created by Alfonso Acosta on 2024-09-20.
//

import SwiftUI

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint

    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount), anchor: anchor)
            .clipped()
    }
}
    
extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
        active: CornerRotateModifier(amount: -90, anchor: .topLeading),
            identity: CornerRotateModifier(amount: 0, anchor: .topLeading)
        )
    }
}

struct ContentView: View {
    @State private var animationAmount = 0.0
    let letters = Array("Hello SwiftUI")
    @State private var enabled = false
    @State private var dragAmount = CGSize.zero
    @State private var isShowingRed = false
    

    var body: some View {
        ZStack {
                    Rectangle()
                        .fill(.blue)
                        .frame(width: 200, height: 200)

                    if isShowingRed {
                        Rectangle()
                            .fill(.red)
                            .frame(width: 200, height: 200)
                            .transition(.pivot)
                    }
                }
        .onTapGesture {
            withAnimation {
                isShowingRed.toggle()
            }
        }
        /*
        VStack {
            Button("Tap Me") {
                withAnimation {
                    isShowingRed.toggle()
                }
            }
            
            if isShowingRed {
                Rectangle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
                    .transition(.asymmetric(insertion: .scale, removal: .opacity))

            }
        }
        */
    }
        /*LinearGradient(colors: [.yellow, .red], startPoint: .topLeading, endPoint: .bottomTrailing)
         .frame(width: 300, height: 200)
         .clipShape(.rect(cornerRadius: 10))
         .offset(dragAmount)
         .gesture(
         DragGesture()
         .onChanged { dragAmount = $0.translation }
         .onEnded { _ in
         withAnimation(.bouncy) {
         dragAmount = .zero
         }
         }
         )
         */
        
    /*
        HStack(spacing: 0) {
            ForEach(0..<letters.count, id: \.self) { num in
                Text(String(letters[num]))
                    .padding(5)
                    .font(.title)
                    .background(enabled ? .blue : .red)
                    .offset(dragAmount)
                    .animation(.linear.delay(Double(num) / 20), value: dragAmount)
            }
        }
        .gesture(
            DragGesture()
                .onChanged { dragAmount = $0.translation }
                .onEnded { _ in
                    dragAmount = .zero
                    enabled.toggle()
                }
        )
    }
     */
        
        /*    Button("Tap Me") {
                withAnimation {
                    animationAmount += 360
                }
            }
            .padding(50)
            .background(.red)
            .foregroundStyle(.white)
            .clipShape(.circle)
            .rotation3DEffect(.degrees(animationAmount), axis: (x: 1, y: 0, z: 0))
        
        */
        //only changes before the animation() modifier will be animated
        //allows us to stack animations
        //can also add nil animations
        
        
        /*  return    VStack {
         Stepper("Scale amount", value: $animationAmount.animation(
         .easeInOut(duration: 1)
         .repeatCount(3, autoreverses: true)
         ), in: 1...10)
         //this means swiftUI automatically animates changes
         Spacer()
         
         Button("Tap Me"){
         animationAmount += 1
         }
         .padding(40)
         .background(.red)
         .foregroundStyle(.white)
         .clipShape(.circle)
         .scaleEffect(animationAmount)
         }
         */
        //implicit animations -> attached to view
        //explicit animations -> binding the
        
        
        /*
         Button("Tape Me"){
         //animationAmount += 1
         
         }
         .padding(50)
         .background(.red)
         .foregroundStyle(.white)
         .clipShape(.circle)
         .overlay(
         Circle()
         .stroke(.red)
         .scaleEffect(animationAmount)
         .opacity(2 - animationAmount)
         .animation(
         .easeInOut(duration: 1)
         .repeatForever(autoreverses: false),
         value: animationAmount
         )
         )
         .onAppear{
         animationAmount = 2
         }
         */
        //overlays make views at same size and pos //continuous animations use repeat forver
        /*.animation(
         .easeInOut(duration: 2)
         .delay(1)
         .repeatCount(3, autoreverses:  true), value: animationAmount)
         */
        //easeInOut creats an instance of an animation struct
        //asks swiftUI to apply a default animation whenever it value changes
        // implicit animations takes effect on all properties of the view that change
        
        //animation becomes a function of our state
        //lots of different animation types
}

#Preview {
    ContentView()
}
