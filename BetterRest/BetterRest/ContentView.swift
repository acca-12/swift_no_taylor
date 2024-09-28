//
//  ContentView.swift
//  BetterRest
//
//  Created by Alfonso Acosta on 2024-09-20.
//


import CoreML
import SwiftUI



struct ContentView: View {
    //swift doesn't know which order the properties will be created in. this by adding static we say that it BELONGS to the contentview struct itself rather than a single instance.
   static var defaultWakeTime: Date{
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    
    
    
    @State private var sleepAmount = 8.0
    @State private var wakeUp = defaultWakeTime
    @State private var coffeeAmount = 1
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    let components = Calendar.current.dateComponents([.hour, .minute], from: Date.now)
    func calculateBedTime() {
        do{
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep //apple api allows you to subtract secodns from Date and get back a Date
            
            alertTitle = "Your ideal bedtime is..."
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            alertTitle = "Error"
            alertMessage = "There was an error calculting your sleep time, try again"
        }
        showingAlert = true
    }
    var body: some View {
       /* Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
        DatePicker("Please Enter a Date", selection: $wakeUp, in: Date.now...)
            .labelsHidden() */
       // Text("\(components.hour ?? 0)")
       // Text(Date.now, format: .dateTime.hour().minute())
        
        NavigationStack{
            Form{
                VStack(alignment: .leading, spacing: 0){
                    Text("When do you want to wake up?")
                        .font(.headline)
                    
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                
                VStack(alignment: .leading, spacing: 0){
                    Text("Desired amount of sleep")
                        .font(.headline)
                    
                    Stepper("\(sleepAmount.formatted())", value: $sleepAmount, in: 4...12, step: 0.25)
                }
                
                VStack(alignment: .leading, spacing: 0){
                    Text("Daily coffee intake")
                        .font(.headline)
                    Stepper("^[\(coffeeAmount) cup](inflect: true)", value: $coffeeAmount, in: 1...20) //pluralization
                }
            }
            .navigationTitle("BetterRest")
            .toolbar{
                Button("Calculate", action: calculateBedTime)
            }
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("OK") { }
            } message: {
                Text(alertMessage)
            }
        }
        
    }
}

#Preview {
    ContentView()
}
