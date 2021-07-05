//
//  ViewController.swift
//  Calculator
//
//  Created by Shagirov Maksat on 31.01.2021.
//

import UIKit

extension UIButton
{
    func round()
    {
        layer.cornerRadius = bounds.height / 2
    }
}

class ViewController: UIViewController
{
    @IBOutlet weak var myDisplay: UILabel!
    
    @IBOutlet weak var buttonAC: UIButton!
    @IBOutlet weak var buttonSubtraction: UIButton!
    @IBOutlet weak var buttonAddition: UIButton!
    @IBOutlet weak var buttonMultiplication: UIButton!
    @IBOutlet weak var buttonDivision: UIButton!
    @IBOutlet weak var buttonPercent: UIButton!
    @IBOutlet weak var buttonReverse: UIButton!
    @IBOutlet weak var buttonEqual: UIButton!
    @IBOutlet weak var button0: UIButton!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var button9: UIButton!
    @IBOutlet weak var buttonDot: UIButton!
    
    var dec: Bool = false
    var typing: Bool = false
    
    override func viewDidAppear(_ just: Bool)
    {
        buttonAC.round()
        buttonAddition.round()
        buttonSubtraction.round()
        buttonMultiplication.round()
        buttonDivision.round()
        buttonPercent.round()
        buttonEqual.round()
        buttonReverse.round()
        button0.round()
        button1.round()
        button2.round()
        button3.round()
        button4.round()
        button5.round()
        button6.round()
        button7.round()
        button8.round()
        button9.round()
        buttonDot.round()
    }
    
    @IBAction func digitPressed(_ sender: UIButton)
    {
        calculatorModel.lastWasOperation = false
        calculatorModel.currentOperation = temp
        buttonAC.setTitle("C", for: .normal)
        let current_digit = sender.currentTitle!
        if typing
        {
            let current_display = myDisplay.text!
            if current_display != "0"
            {
                if current_digit == "."
                {
                    if !dec
                    {
                        myDisplay.text = current_display + current_digit
                        dec = true
                    }
                }
                else
                {
                    myDisplay.text = current_display + current_digit
                }
            }
            else
            {
                if current_digit != "."
                {
                    myDisplay.text = current_digit
                }
                else
                {
                    myDisplay.text = "0" + current_digit
                    dec = true
                }
            }
        }
        else
        {
            if current_digit != "."
            {
                myDisplay.text = current_digit
            }
            else
            {
                myDisplay.text = "0" + current_digit
                dec = true
            }
            typing = true
        }
    }
    
    var displayValue: Double
    {
        get
        {
            return Double(myDisplay.text!)!
        }
        set
        {
            myDisplay.text = String(newValue)
        }
    }
    
    private var calculatorModel = CalculatorModel()
    
    @IBAction func operationPressed(_ sender: UIButton)
    {
        if sender.currentTitle == "%"
        {
            calculatorModel.lastDigit0()
        }
        if sender.currentTitle != "="
        {
            calculatorModel.lastDigit0()
        }
        dec = false
        if sender.currentTitle! == "C"
        {
            buttonAC.setTitle("AC", for: .normal)
            calculatorModel.allclear()
        }
        
        if displayValue == Double(0)
        {
            if sender.currentTitle! != "±"
            {
                calculatorModel.setOperand(displayValue)
                calculatorModel.performOperand(sender.currentTitle!)
                if calculatorModel.result != nil
                {
                    displayValue = calculatorModel.result!
                }
            }
        }
        else
        {
            calculatorModel.setOperand(displayValue)
            calculatorModel.performOperand(sender.currentTitle!)
            if calculatorModel.result != nil
            {
                displayValue = calculatorModel.result!
            }
        }
        typing = false
        calculatorModel.lastWasOperation = true
    }
}
