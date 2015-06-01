//
//  ViewController.swift
//  SwiftMVC
//
//  Created by AtSu on 2015/5/31.
//  Copyright (c) 2015年 AtSu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBOutlet var displayLabel: UILabel!
    var isTyping : Bool = false
    var currentDisplay : String = "0"
    let cal = CalculatorUnit()
    
    var displayValue : Double {
        get {
            return NSNumberFormatter().numberFromString(displayLabel.text!)!.doubleValue
        } set {
            displayLabel.text = "\(newValue)"
            isTyping = false
        }
    }
    
    
    @IBAction func pressEnter(sender: UIButton) {
        isTyping = false
        cal.pushOperand(displayValue)
    }

    @IBAction func pressOperation(sender: UIButton) {
        isTyping = false
        cal.performOperatin(sender.currentTitle!)
        if let res = cal.eval() {
            displayLabel.text = "\(res)"
        } else {
            displayLabel.text = "Invalid"
        }
    }

    @IBAction func pressNumber(sender: UIButton) {
        let number = sender.currentTitle!
        
        if isTyping {
            currentDisplay = currentDisplay + number
        } else {
            isTyping = true
            currentDisplay = number
        }
        
        displayLabel.text = currentDisplay
    }
}

