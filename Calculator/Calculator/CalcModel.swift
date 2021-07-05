//
//  CalcModel.swift
//  Calculator
//
//  Created by Shagirov Maksat on 01.02.2021.
//

import Foundation

enum Operation
{
    case constant(Double)
    case unaryOperatoin((Double)->Double)
    case binaryOperatoin((Double, Double)->Double)
    case equals
}

func addition(op1: Double, op2: Double)-> Double
{
    return op1+op2
}

func subtraction(op1: Double, op2: Double)-> Double
{
    return op1-op2
}

func division(op1: Double, op2: Double)-> Double
{
    if op2 == Double(0)
    {
        return Double(0)
    }
    else
    {
        return op1/op2
    }
}

func multiplication(op1: Double, op2: Double)-> Double
{
    return op1*op2
}
 


func temp(op1: Double, op2: Double)-> Double
{
    return 0
}

func reverse(op1: Double)-> Double
{
    return -op1
}

func percent(op1: Double)-> Double
{
    let firstNum = saving?.firstOperand
    
    if firstNum != nil
    {
        return firstNum! * (op1/100)
    }
    else
    {
        return op1/100
    }
}

func identical(op1: (Double, Double)-> Double, op2: (Double, Double)-> Double)-> Bool
{
    return op1(6, 3) == op2(6, 3)
}

func doublemult(op1: Double)-> Double
{
    return 2*op1
}

var a: Int = 0

struct CalculatorModel{
    
    var next: Bool = false
    var currentOperation: (Double, Double)-> Double = temp
    var lastWasOperation: Bool = false
    var lastDigit: Double = 0
//    var lastAddition: Bool = false
//    var lastDivision: Bool = false
//    var lastMultiplication: Bool = false
//    var lastSubtraction: Bool = false
    
    var my_operation: Dictionary<String, Operation> =
    [
        "AC": Operation.constant(Double(0)),
        "C": Operation.constant(Double(0)),
        "π": Operation.constant(Double.pi),
        "e": Operation.constant(M_E),
        "√": Operation.unaryOperatoin(sqrt),
        "%": Operation.unaryOperatoin(percent),
        "+": Operation.binaryOperatoin(addition),
        "-": Operation.binaryOperatoin(subtraction),
        "÷": Operation.binaryOperatoin(division),
        "×": Operation.binaryOperatoin(multiplication),
        "±": Operation.unaryOperatoin(reverse),
        "=": Operation.equals
    ]
    
    private var global_value: Double?
    
    mutating func setOperand(_ operand: Double)
    {
        global_value = operand
    }

    mutating func performOperand(_ operation: String)
    {
        let symbol = my_operation[operation]!
        switch symbol
        {
            case .constant(let value):
                global_value = value

            case .unaryOperatoin(let function):
                global_value = function(global_value!)
                
            case .binaryOperatoin(let function):
                
                if !identical(op1: currentOperation, op2: function)
                {
                    if lastWasOperation
                    {
                        saving = SaveFirstOperandAndOperation(firstOperand: global_value!, operation: function)
                    }
                    else
                    {
                        if next
                        {
                            if global_value != nil
                            {
                                global_value = saving?.performOperationWith(secondOperand: global_value!)
                            }
                        }
                    }
                }
                saving = SaveFirstOperandAndOperation(firstOperand: global_value!, operation: function)
                currentOperation = function
                next = true
                
            case .equals:
                if lastDigit == 0
                {
                    if global_value != nil
                    {
                        lastDigit = global_value!
                        global_value = saving?.performOperationWith(secondOperand: global_value!)
                    }
                }
                else
                {
                    if global_value != nil
                    {
                        global_value = saving?.performOperationWith(secondOperand: lastDigit)
                    }
                }
                
                if global_value != nil
                {
                    saving = SaveFirstOperandAndOperation(firstOperand: global_value!, operation: saving!.operation)
                }
                next = false
        }
    }
    
    var result: Double?
    {
        get
        {
            return global_value
        }
    }
    
    mutating func allclear()
    {
        saving = SaveFirstOperandAndOperation(firstOperand: 0, operation: temp)
        next = false
        lastWasOperation = false
        currentOperation = temp
        lastDigit = 0
    }
    
    mutating func lastDigit0()
    {
        lastDigit = 0
    }
}

private var saving: SaveFirstOperandAndOperation?

struct SaveFirstOperandAndOperation
{
    var firstOperand: Double
    var operation: (Double, Double)-> Double
    
    func performOperationWith(secondOperand op2: Double)-> Double
    {
        return operation(firstOperand, op2)
    }
}
