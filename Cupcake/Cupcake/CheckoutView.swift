//
//  CheckoutView.swift
//  Cupcake
//
//  Created by Alfonso Acosta on 2024-09-21.
//

import SwiftUI

struct CheckoutView: View {
    @Bindable var order: Order
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    //need to provide two extra pieces of data beyond our object. that is http method (post or get, usually) and content type of the request (determines the data being sent, which affects the way the server treats it
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }
        let url = URL(string: "https://reqres.in/api/cupcakes")! //force it to be non optimals
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        
        //url session.shared.upload allows us to upload our request with the encoded json
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
            showingConfirmation = true
        } catch {
            print("Checkout failed: \(error.localizedDescription)")
        }
    }
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                        image
                            .resizable()
                            .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)

                Text("Your total is \(order.cost, format: .currency(code: "USD"))")
                    .font(.title)

                
                //since we're executing an action rather than attaching modifiers .task modifer doesn't really work
                //instead sift lets us create new tasks out of thin air
                Button("Place Order") {
                    Task {
                        await placeOrder()
                    }
                }
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Thank you!", isPresented: $showingConfirmation) {
            Button("OK") { }
        } message: {
            Text(confirmationMessage)
        }
        //if theres something to actually scroll through it'll bounce, otherwise stay same
    }
}

#Preview {
    CheckoutView(order: Order())
}

