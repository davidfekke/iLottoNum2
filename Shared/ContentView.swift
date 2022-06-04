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
            
            #if os(iOS) || os(watchOS) || os(tvOS)
                TextField("Start Number", text: $startNumStr)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                    .colorScheme(.light)
                    .onTapGesture {
                        if Float(truncating: self.startNumber) == 0 {
                            self.startNumStr = ""
                        }
                    }
                
                TextField("End Number", text: $endNumStr)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                    .colorScheme(.light)
                    .onTapGesture {
                        if Float(truncating: self.endNumber) == 0 {
                            self.endNumStr = ""
                        }
                    }
            #elseif os(macOS)
                TextField("Start Number", text: $startNumStr)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    //.keyboardType(.decimalPad)
                    //.colorScheme(.light)
                    .onTapGesture {
                        if Float(truncating: self.startNumber) == 0 {
                            self.startNumStr = ""
                        }
                    }
                
                TextField("End Number", text: $endNumStr)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    //.keyboardType(.decimalPad)
                    //.colorScheme(.light)
                    .onTapGesture {
                        if Float(truncating: self.endNumber) == 0 {
                            self.endNumStr = ""
                        }
                    }
            #else
                print("OMG, it's that mythical new Apple product!!!")
            #endif
            
            
            
            Button(action: calculateRandomNumber, label: {
                Spacer()
                Text("Generate Number")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .padding()
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
            #if os(iOS) || os(watchOS) || os(tvOS)
            self.endEditing()
            #endif
        }
        
    }
    
    private func calculateRandomNumber() {
        
        let isStartNumANum = CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: startNumStr))
        let isEndNumANum = CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: endNumStr))
        
        if startNumStr == "" || endNumStr == "" || !isStartNumANum || !isEndNumANum  {
            warning = "Please make sure to assign a number value to both the Start number and End number"
        } else {
            
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
        }
        
        #if os(iOS) || os(watchOS) || os(tvOS)
            endEditing()
        #endif
    }
    
    #if os(iOS) || os(watchOS) || os(tvOS)
    private func endEditing() {
        UIApplication.shared.endEditing()
    }
    #endif
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

#if os(iOS) || os(watchOS) || os(tvOS)
extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

