//
//  CalculatorDataModel.swift
//  Calculator
//
//  Created by Suhit on 18/02/17.
//  Copyright © 2017 Suhit. All rights reserved.
//

import UIKit

struct CalculatorViewModel {

    private var accumulator: Double?
    
    var result: Double? {
        get {
            return accumulator
        }
    }
    
    private enum Operation {
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case arithmaticOperation((Double, Double) -> Double)
        case Equals
    }
    
    private var operations: Dictionary<String, Operation> = [
        "×": Operation.arithmaticOperation({$0 * $1}),
        "÷": Operation.arithmaticOperation({$0 / $1}),
        "+": Operation.arithmaticOperation({$0 + $1}),
        "−": Operation.arithmaticOperation({$0 - $1}),
        "%": Operation.arithmaticOperation({$0.truncatingRemainder(dividingBy: $1)}),
        "=": Operation.Equals
    ]
    

    
    mutating func performOperation(_ symbol: String) {
        
        if let operation = operations[symbol] {
            switch operation {
            case .constant(let constant):
                accumulator = constant
            case .arithmaticOperation(let function):
                executePendingBinaryOperation()
                if accumulator != nil {
                    pending = PendingArithmaticOperationInfo(binaryFunction: function, firstOperand: accumulator!)
                }
            case .Equals:
                executePendingBinaryOperation()
            default:
                break
            }
        }
    }
    
    private mutating func executePendingBinaryOperation()
    {
        if pending != nil && accumulator != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator!)
            pending = nil
        }
    }
    
    private var pending: PendingArithmaticOperationInfo?
    
    private struct PendingArithmaticOperationInfo {
        var binaryFunction: (Double, Double) -> Double
        var firstOperand: Double
    }
    
    
    mutating func setOperand(_ operand: Double) {
        accumulator = operand
    }
}
