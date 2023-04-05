//
//  ContentView.swift
//  calcSwiftui
//
//  Created by Dostonbek on 4/5/23.
//


import SwiftUI

struct ContentView: View {
    
    // Define variables to store input and result
    @State private var input1 = ""
    @State private var input2 = ""
    @State private var result = ""
    
    // Define enum for possible errors
    enum CalculatorError: Error {
        case divisionByZero
        case invalidInput
    }
    
    var body: some View {
        VStack {
            // Text fields to enter input values
            TextField("Enter a number", text: $input1)
                .keyboardType(.decimalPad)
            TextField("Enter another number", text: $input2)
                .keyboardType(.decimalPad)
            
            // Buttons to perform operations
            HStack {
                Button(action: {
                    // Addition operation
                    do {
                        let sum = try calculateResult(operatorSymbol: "+")
                        result = String(format: "%.2f", sum)
                    } catch CalculatorError.invalidInput {
                        result = "Invalid input"
                    } catch {
                        result = "An error occurred"
                    }
                }) {
                    Text("+")
                }
                
                Button(action: {
                    // Subtraction operation
                    do {
                        let difference = try calculateResult(operatorSymbol: "-")
                        result = String(format: "%.2f", difference)
                    } catch CalculatorError.invalidInput {
                        result = "Invalid input"
                    } catch {
                        result = "An error occurred"
                    }
                }) {
                    Text("-")
                }
                
                Button(action: {
                    // Multiplication operation
                    do {
                        let product = try calculateResult(operatorSymbol: "x")
                        result = String(format: "%.2f", product)
                    } catch CalculatorError.invalidInput {
                        result = "Invalid input"
                    } catch {
                        result = "An error occurred"
                    }
                }) {
                    Text("x")
                }
                
                Button(action: {
                    // Division operation
                    do {
                        let quotient = try calculateResult(operatorSymbol: "/")
                        result = String(format: "%.2f", quotient)
                    } catch CalculatorError.divisionByZero {
                        result = "Cannot divide by zero"
                    } catch CalculatorError.invalidInput {
                        result = "Invalid input"
                    } catch {
                        result = "An error occurred"
                    }
                }) {
                    Text("/")
                }
            }
            
            // Display the result
            Text("Result: \(result)")
        }
        .padding()
    }
    
    // Function to calculate the result based on operator symbol
    func calculateResult(operatorSymbol: String) throws -> Double {
        guard let number1 = Double(input1), let number2 = Double(input2) else {
            throw CalculatorError.invalidInput
        }
        
        switch operatorSymbol {
        case "+":
            return number1 + number2
        case "-":
            return number1 - number2
        case "x":
            return number1 * number2
        case "/":
            guard number2 != 0 else {
                throw CalculatorError.divisionByZero
            }
            return number1 / number2
        default:
            throw CalculatorError.invalidInput
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
