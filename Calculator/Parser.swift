//
//  Parser.swift
//  Calculator
//
//  Created by Suhit on 22/02/17.
//  Copyright © 2017 Suhit. All rights reserved.
//

import UIKit

extension String {
    
    var isOperator: Bool {
        get {
            return ("+-*/%^" as NSString).contains(self)
        }
    }
    
    var isNumber : Bool {
        get {
            return !self.isEmpty && ("0123456789." as NSString).contains(self)
        }
    }
    
    var precedence: Int {
        get {
            switch self {
            case "+":
                return 2
            case "-":
                return 2
            case "*":
                return 1
            case "/":
                return 1
            case "%":
                return 1
            case "^":
                return 0
            default:
                return -1
            }
        }
    }
    
}

/*struct Stack<String> {
    
    private var array: [String] = []
    
    mutating func push(_ element: String) {
        array.append(element)
    }
    
    mutating func peek() -> String {
        if !array.isEmpty {
            return array[array.count-1]
        } else {
            return "" as! String
        }
    }
    
    var isEmpty: Bool {
        return array.isEmpty
    }
    
    var count: Int {
        return array.count
    }
    
    mutating func pop() -> String {
        var temp: String = "" as! String
        if !array.isEmpty {
            temp = array[array.count - 1]
            array.remove(at: array.count - 1)
        }
        return temp
    }
}*/



struct Stack<String> {
    
    private var array: [String] = []
    
    mutating func push(_ element: String) {
        array.append(element)
    }
    
    mutating func pop() -> String? {
        return array.popLast()
    }
    
    func peek() -> String? {
        return array.last
    }
    
    var isEmpty: Bool {
        return array.isEmpty
    }
    
    var count: Int {
        return array.count
    }
}



struct Parser {
    
    var operatorStack = Stack<String>()
    var operandStack = Stack<String>()
    
    mutating func evaluate(_ expression: String) -> String? {
        
        for (_, char) in expression.characters.enumerated() {
            
            let token = String(char)
            
            if token.isNumber {
                print(token)
                operandStack.push(token)
            }
            
            
            if token.isOperator {
                
                if let operation = operatorStack.peek() {
                    
                    while operation.precedence <= token.precedence {
                        
                        if !operatorStack.isEmpty {
                            
                            var result: Double = 0
                            
                            if let first = operandStack.pop(), let second = operandStack.pop() {
                                result = perform(operation, on: first, and: second)
                            }
                            
                            let r = operatorStack.pop()
                            print(r ?? "")
                            operandStack.push(String(result))
                        }
                        
                        if operatorStack.isEmpty {
                            break
                        }
                    }
                }
                print(token)
                operatorStack.push(token)
            }
        }
        
        while !operatorStack.isEmpty {
            var result: Double = 0
            if let operation = operatorStack.peek() {
                print(operation)
                if let first = operandStack.pop(), let second = operandStack.pop() {
                    result = perform(operation, on: first, and: second)
                }
            }
            
            let r = operatorStack.pop()
            print(r ?? "")
            operandStack.push(String(result))
            
            if operatorStack.isEmpty {
                break
            }
        }
        
        return operandStack.pop()
    }
    
    mutating func perform(_ operation: String, on first: String, and second: String) -> Double {
        
        var result: Double = 0
        let num1 = Double(first)!
        let num2 = Double(second)!
        
        switch operation {
        case "+":
            result = num1 + num2
            
        case "-":
            result = num2 - num1
            let r = operatorStack.pop()
            print(r ?? "")

            
        case "*":
            result = num2 * num1

            
        case "/":
            result = num2 / num1
            let r = operatorStack.pop()
            print(r ?? "")
            
        case "%":
            result = num1.truncatingRemainder(dividingBy: num2)
            
        case "^":
            result = pow(num2, num1)
            
        default:
            result = 0
        }
        return result
    }
}

