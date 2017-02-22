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
    var parser = Parser()
    
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
        
        /*if isTyping {
            calculatorModel.setOperand(displayValue)
            isTyping = false
        }
        
        if let operation = sender.currentTitle {
           calculatorModel.performOperation(operation)
        }
        
        if let result = calculatorModel.result {
            displayValue = result
        }*/
    }
    
    @IBAction private func clearText(sender: UIButton) {
    }
    
    @IBAction private func reset(sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let res = parser.evaluate("-5+4+2*3^3")
        print("result = \(res)")
    }
    
}

