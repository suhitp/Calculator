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
    var previous: String?
    
    var displayValue: String {
        get {
            if let value = display.text {
                return value
            } else {
                return "0"
            }
        }
        
        set {
            display.text = newValue
        }
    }
    
    private var isTyping = false
    
    @IBAction private func digitPressed(_ sender: UIButton) {
        
        guard let digit = sender.currentTitle else {
            return
        }
        
        if previous != nil {
            displayValue = previous!
            displayValue.append(digit)
            previous = nil
            isTyping = true
            return
        }
        
        if isTyping {
            display.text?.append(digit)
        } else {
            if digit == "." {
                display.text = displayValue.appending(digit)
            } else {
                display.text = digit
            }
        }
        
        isTyping = true
    }
    
    var calculatorModel = CalculatorViewModel()
    
    @IBAction private func performOperation(_ sender: UIButton) {
        
        if isTyping {
            if let result = parser.evaluate(expression: displayValue) {
                displayValue = result.replacingOccurrences(of: ".0", with: "")
                previous = displayValue
                isTyping = false
            }
        }
    }
    
    @IBAction private func clearText(sender: UIButton) {
        
        if let char = display.text {
            if char.characters.count > 1 {
                let text = char
                let truncated = text.substring(to: text.index(before: text.endIndex))
                displayValue = truncated
                previous = truncated
            } else {
                 displayValue = "0"
            }
        } else {
            displayValue = "0"
        }
        isTyping = false
    }
    
    @IBAction private func reset(sender: UIButton) {
        displayValue = "0"
        previous = nil
        isTyping = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        display.text = "0"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
}

