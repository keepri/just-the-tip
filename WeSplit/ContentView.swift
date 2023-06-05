import SwiftUI

struct ContentView: View {
    let percentageList: Array<Int> = [5, 10, 15, 20, 25, 30, 35]
    let localeCurrency = Locale.current.currency?.identifier ?? "RON";
    
    @State private var checkAmount: Double = 0.0
    @State private var numberOfPeople: Int = 0
    @State private var tipPercentage: Int = 20
    
    @FocusState private var checkAmountIsFocused: Bool
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        
        return grandTotal / peopleCount
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Per person") {
                    Text(totalPerPerson, format: .currency(code: localeCurrency))
                }
                
                Section("Tip") {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(percentageList, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Input") {
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) { Text("\($0)") }
                    }
                    
                    TextField("Amount", value: $checkAmount, format: .currency(code: localeCurrency))
                        .keyboardType(.decimalPad)
                        .focused($checkAmountIsFocused)
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        checkAmountIsFocused = false
                    }
                    .dynamicTypeSize(.small)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
