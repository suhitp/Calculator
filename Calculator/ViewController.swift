//
//  ViewController.swift
//  Calculator
//
//  Created by Suhit on 18/02/17.
//  Copyright © 2017 Suhit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var displayValue: Double {
        get {
            if let value = display.text, let num =  Double(value) {
                return num
            } else {
                return 0
            }
        }
        
        set {
            display.text = String(newValue)
        }
    }
    
    private var isTyping = false
    
    @IBAction private func digitPressed(_ sender: UIButton) {
        
        guard let digit = sender.currentTitle else {
            return
        }
        
        if isTyping {
            display.text?.append(digit)
        } else {
            display.text = digit
        }
        
        isTyping = true
    }
    
    var calculatorModel = CalculatorViewModel()
    
    @IBAction private func performOperation(_ sender: UIButton) {
        
        if isTyping {
            calculatorModel.setOperand(displayValue)
            isTyping = false
        }
        
        if let operation = sender.currentTitle {
           calculatorModel.performOperation(operation)
        }
        
        if let result = calculatorModel.result {
            displayValue = result
        }
    }
    
}

