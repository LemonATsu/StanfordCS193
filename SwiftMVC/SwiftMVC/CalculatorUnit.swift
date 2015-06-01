//
//  CalculatorUnit.swift
//  SwiftMVC
//
//  Created by AtSu on 2015/5/31.
//  Copyright (c) 2015年 AtSu. All rights reserved.
//

import Foundation

class CalculatorUnit: NSObject {
    private enum Op {
        case Operand(Double)
        case Operation(String, (Double, Double)->Double)
    }
    
    private var opStack = [Op]()
    private var opsDictionary = [String:Op]()
    
    override init() {
        opsDictionary["+"] = Op.Operation("+") {return $0 + $1}
        opsDictionary["-"] = Op.Operation("-") {return $1 - $0}
        opsDictionary["*"] = Op.Operation("*") {return $0 * $1}
        opsDictionary["/"] = Op.Operation("/") {return $1 / $0}
    }
    
    func pushOperand(operand: Double) {
        opStack.append(Op.Operand(operand))
    }
    
    func performOperatin(operation: String) {

        if let op = opsDictionary[operation] {
            opStack.append(op)
        }
        
    }

    private func eval(ops: [Op]) -> (remainStack: [Op] , result: Double?) {

        if !ops.isEmpty {
            var remain = ops
            let op = remain.removeLast()
            
            switch op {
            case .Operand(let operand): return ( remain, operand)
            case .Operation(_, let operation):
                // get result recursively when encounter operaion
                
                // get first operand
                let Evaluation1 = eval(remain)
                
                if let operand1 = Evaluation1.result {
                    print("\(operand1) ")
                    // get the second operand
                    let Evaluation2 = eval(Evaluation1.remainStack)
                    
                    if let operand2 = Evaluation2.result {
                        print("\(operand1) \(operand2)")
                        // complete evaluation
                        return(Evaluation2.remainStack, operation(operand1, operand2))
                    }
                }
            }
        }
        
        return (ops, nil)
    }
    
    func eval() -> Double? {
        var result : Double? = nil
        let evalResult = eval(opStack)
        
        result = evalResult.result
        opStack = evalResult.remainStack
        
        return result
    }
}
