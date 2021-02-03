//
//  ContentView.swift
//  Shared
//
//  Created by David Fekke on 1/31/21.
//

import SwiftUI

struct ContentView: View {
    @State var startNumStr: String = ""
    @State var endNumStr: String = ""
    @State var randArray: [Int] = []
    @State var winner: Int = 0
    @State var warning: String = ""
    
    var startNumber: NSNumber {
        let formatter = NumberFormatter()
        guard let number = formatter.number(from: startNumStr) else {
            print("not valid to be converted")
            return 0
        }
        return number
    }
    
    var endNumber: NSNumber {
        let formatter = NumberFormatter()
        guard let number = formatter.number(from: endNumStr) else {
            print("not valid to be converted")
            return 0
        }
        return number
    }
    
    
    var body: some View {
        
        VStack {
            Text("Calculate Winner")
                .font(.largeTitle)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            
            TextField("Start Number", text: $startNumStr)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.decimalPad)
                //.colorScheme(.light)
                .onTapGesture {
                    if Float(truncating: self.startNumber) == 0 {
                        self.startNumStr = ""
                    }
                }
            
            TextField("End Number", text: $endNumStr)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.decimalPad)
                //.colorScheme(.light)
                .onTapGesture {
                    if Float(truncating: self.endNumber) == 0 {
                        self.endNumStr = ""
                    }
                }
            
            Button(action: calculateRandomNumber, label: {
                Spacer()
                Text("Calculate Button")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                Spacer()
            }).background(Color.green)
                .cornerRadius(8.0)
            
            Divider()
            
            if randArray.count > 0 {
                Text("\(winner)")
                    .font(.largeTitle)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.blue)
            }
            
            if !warning.isEmpty {
                Text("\(warning)")
                    .font(.largeTitle)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.red)
            }
            
            Spacer()
            
        }.padding()
        .background(Image("lottoBackground").resizable().scaledToFill())
        .onTapGesture {
            self.endEditing()
        }
        
    }
    
    private func calculateRandomNumber() {
        let start = Int(truncating: startNumber)
        let end = Int(truncating: endNumber)
        
        if end <= start {
            warning = "The Start number must be lower than the End number"
            return
        } else {
            warning = ""
        }
        
        if randArray.count == 0 {
            randArray = Array(start...end).shuffled()
        }
        if let result = randArray.popLast() {
            winner = result
        } else {
            winner = -1
        }
        
        endEditing()
    }
    
    private func endEditing() {
        UIApplication.shared.endEditing()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
