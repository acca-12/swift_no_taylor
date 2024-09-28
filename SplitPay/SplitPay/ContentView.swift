import SwiftUI

struct ContentView: View {
    
    @State private var billAmount = 0.0
    @State private var numPeople = 2
    @State private var tipPercent = 15
    
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    var totalPerPerson: Double {
        let pplCount = Double(numPeople + 2)
        let tipChosen = Double(tipPercent)
        
        let tipVal = billAmount / 100 * tipChosen
        let grandTotal = billAmount + tipVal
        let amountPerPerson = grandTotal / pplCount
        return amountPerPerson
    }
    
    var totalCheck: Double {
        let tipChosen = Double(tipPercent)
        let tipVal = billAmount / 100 * tipChosen
        return billAmount + tipVal
    }
    //this means that totalPerPerson is a COMPUTER variable you do not modify any STORED data, simply computing and reading and since when a state changes itll reload the UI, it also reloads totalPerPerson
    
    var body: some View {
        //we need to format whatever the user passes into decimal values
        //when state changes it reloads UI
        NavigationStack {
            Form{
                Section{
                    TextField("Amount: ", value: $billAmount, format: . currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused) //like state but for input focus in UI
                    //we can also have different keyboards on pop up
                    Picker("Number of People", selection: $numPeople) {
                        ForEach(2..<100){
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                
                Section("Tip %") { //sections can have headers and footers
                    Picker("Tip Percentage", selection: $tipPercent) {
                        ForEach(0..<101){
                            Text("\($0) %")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
        
                Section("Amount Per Person"){
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USA"))
                }
                
                Section("Total Check Before Split"){
                    Text(totalCheck, format: .currency(code: Locale.current.currency?.identifier ?? "USA"))
                }
            }
            .toolbar{ //this lets us specify toolbar items for a view
                if amountIsFocused{ //only show button when true
                    Button("Done"){
                        amountIsFocused = false //set to false after clicking, so keyboard dismissed
                    }
                }
            }
            .navigationTitle("SplitPay")
            //this attaches to whatever is in the stack
            
        }
    }
   
}

#Preview {
    ContentView()
}

