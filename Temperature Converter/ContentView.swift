//
//  ContentView.swift
//  Temperature Converter
//
//  Created by Sedat Çakır on 31.07.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var input = 100
    @State private var inputUnit = UnitTemperature.celsius
    @State private var outputUnit = UnitTemperature.fahrenheit
    @FocusState private var inputIsFocused : Bool
    
    let units : [UnitTemperature] = [.fahrenheit, .celsius, .kelvin]
    var formatter = MeasurementFormatter()
    
    var result : String{
        let inputTemperature = Measurement(value: Double(input), unit: inputUnit)
        let outputTemperature = inputTemperature.converted(to: outputUnit)
        return formatter.string(from: outputTemperature)
    }
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Temperature", value: $input, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($inputIsFocused)
                } header: {
                    Text("Amount to convert")
                }
                Section{
                    Picker("To",selection: $inputUnit){
                        ForEach(units, id: \.self){
                            Text(formatter.string(from: $0).capitalized)
                        }
                    }
                    Picker("From",selection: $outputUnit){
                        ForEach(units, id: \.self){
                            Text(formatter.string(from: $0).capitalized)
                        }
                    }
                }
                Section{
                    Text(result)
                } header: {
                    Text("Result")
                }
                
            } .navigationTitle("Temp Converter")
                .toolbar{
                    ToolbarItemGroup(placement: .keyboard){
                        Spacer()
                        Button("Done"){
                            inputIsFocused = false
                        }
                    }
                }
        }
    }
    init(){
        formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        formatter.unitStyle = .short
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
