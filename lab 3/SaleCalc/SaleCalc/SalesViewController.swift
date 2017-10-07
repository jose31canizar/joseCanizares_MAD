//
//  SalesViewController.swift
//  SaleCalc
//
//  Created by Jose Canizares on 10/7/17.
//  Copyright © 2017 Jose Canizares. All rights reserved.
//

import UIKit

class SalesViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    var states = [
        ("Alabama", 8.91),
        ("Alaska", 1.76),
        ("Arizona", 8.17),
        ("Arkansas", 9.26),
        ("California", 8.44),
        ("Colorado", 7.44),
        ("Connecticut", 6.35),
        ("Delaware", 0.00),
        ("Florida", 6.65),
        ("Georgia", 6.96),
        ("Hawaii", 4.35),
        ("Idaho", 6.01),
        ("Illinois", 8.19),
        ("Indiana", 7.00),
        ("Iowa", 6.78),
        ("Kansas", 8.20),
        ("Kentucky", 6.00),
        ("Louisiana", 8.91),
        ("Maine", 5.50),
        ("Maryland", 6.00),
        ("Massachusetts", 6.25),
        ("Michigan", 6.00),
        ("Minnesota", 7.20),
        ("Mississippi", 6.00),
        ("Missouri", 7.81),
        ("Montana", 0.00),
        ("Nebraska", 6.80),
        ("Nevada", 7.94),
        ("New Hampshire", 0.00),
        ("New Jersey", 6.97),
        ("New Mexico", 7.35),
        ("New York", 8.48),
        ("North Carolina", 6.90),
        ("North Dakota", 6.56),
        ("Ohio", 7.10),
        ("Oklahoma", 8.77),
        ("Oregon", 0.00),
        ("Pennsylvania", 6.34),
        ("Rhode Island", 7.00),
        ("South Carolina", 7.13),
        ("South Dakota", 5.83),
        ("Tennessee", 9.45),
        ("Texas", 8.05),
        ("Utah", 6.68),
        ("Vermont", 6.14),
        ("Virginia", 5.63),
        ("Washington", 8.89),
        ("West Virginia", 6.07),
        ("Wisconsin", 5.43),
        ("Wyoming", 8.89)
    ]
    
    @IBOutlet weak var billField: UITextField!
    
    @IBOutlet weak var numberOfPeople: UITextField!
    
    @IBOutlet weak var statePicker: UIPickerView!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    var bill : Double?
    var numOfPeople : Int?
    var salesTax : Double = 8.91
    var result : Double?
    
    override func viewDidLoad() {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        billField.delegate = self
        numberOfPeople.delegate = self
        
        billField.tag = 0
        numberOfPeople.tag = 1
        billField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        numberOfPeople.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        // Do any additional setup after loading the view, typically from a nib.
        super.viewDidLoad()
    }
    
    func isStringAnInt(string: String) -> Bool {
        if string.isEmpty {
            return true
        }
        return Int(string) != nil
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return states.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(states[row].0)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        salesTax = states[row].1
        print("sales tax is \(salesTax)")
        updateResult()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 0:
            self.numberOfPeople.becomeFirstResponder()
        case 1:
            textField.resignFirstResponder()
            view.endEditing(true)
        default:
            textField.resignFirstResponder()
            view.endEditing(true)
        }
        return true
    }
    
    func hideKeyboard() {
        view.endEditing(true)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        updateResult(textField)
    }
    
    func textFieldDidChange(_ textField: UITextField) {
        if textField.text != nil {
            //if number of people isn't an integer
            if !isStringAnInt(string: textField.text!) && textField.tag == 1 || textField.text == "0" {
                let textFieldName = textField.tag == 0 ? "Bill" : "Number of People"
                let alert = UIAlertController(title: "warning", message: "\(textFieldName) must be valid", preferredStyle: UIAlertControllerStyle.alert)
                let cancelAction = UIAlertAction(title: "cancel", style: UIAlertActionStyle.cancel, handler: nil)
                let okAction = UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: { action in self.numberOfPeople.text = "1" })
                alert.addAction(cancelAction)
                alert.addAction(okAction)
                present(alert, animated: true, completion: nil)
            }
        } else if textField.text!.isEmpty {
            numOfPeople = 0
        } else {
            updateResult(textField)
        }
    }
    
    func updateResult() {
        if let b = bill, let n = numOfPeople {
            print("\(b) \(n) \(salesTax)")
            let res = b + b*(salesTax/100.0)
            result = res/(Double(n))
            resultLabel.text = String(format: "%.2f", result!)
        }
    }
    
    func updateResult(_ textField: UITextField) {
        if let text = textField.text, !text.isEmpty {
            switch textField.tag {
                case 0:
                    bill = Double(textField.text!)
                case 1:
                    numOfPeople = Int(textField.text!)
                default:
                    break
            }
        }
        if let b = bill, let n = numOfPeople  {
            print("\(b) \(n)")
            let res = b + b*(salesTax/100.0)
            result = res/(Double(n))
            resultLabel.text = String(format: "%.2f", result!)
        }
    }

}

