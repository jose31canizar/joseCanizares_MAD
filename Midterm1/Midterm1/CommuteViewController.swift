//
//  CommuteViewController.swift
//  Midterm1
//
//  Created by Jose Canizares on 10/19/17.
//  Copyright © 2017 Jose Canizares. All rights reserved.
//

import UIKit

class CommuteViewController: UIViewController, UITextFieldDelegate {
    
    var miles : Float = 0
    var gallons: Float = 0
    var selectedTransportation = "car"
    var gasToPurchase : Float = 0
    var days : Float = 1

    @IBOutlet weak var transportationImage: UIImageView!
    @IBOutlet weak var commuteMilesField: UITextField!
    
    @IBAction func showMonthlyCommute(_ sender: UISwitch) {
        if(sender.isOn) {
            days = 28
        } else {
            days = 1
        }
        updateCommute(miles)
    }
    
    @IBAction func gasInTankSlider(_ sender: UISlider) {
        gasInTankDisplay?.text = String(format: "%.2f", sender.value)
        gallons = Float(sender.value)
    }

    
    @IBAction func gasInTankSliderEndEditing(_ sender: UISlider) {
        if gallons < gasToPurchase {
            let alert = UIAlertController(title: "Danger!", message: "You don't have enough gas for your commute! You need at least \(gasToPurchase) gallons", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func modeOfTransportation(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex
        {
        case 0:
            transportationImage.image = UIImage(named:"car_icon.png")
            selectedTransportation = "car"
        case 1:
            transportationImage.image = UIImage(named:"bus_icon.png")
            selectedTransportation = "bus"
        case 2:
            transportationImage.image = UIImage(named:"bike_icon.png")
            selectedTransportation = "bike"
        default:
            break
        }
        updateCommute(miles)
    }
    
    @IBOutlet weak var gasInTankDisplay: UILabel!
    
    
    @IBAction func commuteButton(_ sender: UIButton) {
        if gallons < gasToPurchase {
            let alert = UIAlertController(title: "Danger!", message: "You don't have enough gas for your commute! You need at least \(gasToPurchase) gallons", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
        updateCommute(miles)
    }
    
    @IBOutlet weak var totalCommuteTimeDisplay: UILabel!
    
    @IBOutlet weak var gasToPurchaseDisplay: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commuteMilesField.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CommuteViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let miles = Float((commuteMilesField?.text)!) {
            self.miles = miles
            updateCommute(miles)
        }
    }
    
    func updateCommute(_ miles: Float) {
        var wait : Float = 0.0
        var speed : Float = 20.0
        let mileage : Float = 24.0
        switch selectedTransportation
        {
        case "car":
            speed = 20.0
        case "bus":
            speed = 12.0
            wait = 10.0
        case "bike":
            speed = 10.0
        default:
            break
        }
        let commuteTime = ((miles/speed)*60 + wait) * days
        totalCommuteTimeDisplay?.text = String(commuteTime)
        if selectedTransportation == "car" {
            let gas = (miles/mileage) * days
            gasToPurchaseDisplay?.text = String(format: "%.2f", gas)
            gasToPurchase = gas
        } else {
            gasToPurchaseDisplay?.text = "0.0"
            gasToPurchase = 0.0
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

