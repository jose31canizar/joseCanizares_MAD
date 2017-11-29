//
//  ViewController.swift
//  Cycle
//
//  Created by Jose Canizares on 9/20/17.
//  Copyright © 2017 Jose Canizares. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var bikeImage: UIImageView!
    
    var font = "Helvetica Neue"
    
    @IBAction func bikeControl(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex
        {
        case 0:
            bikeImage.image = UIImage(named:"bike_1.png")
            bikeText.text = "Tall"
        case 1:
            bikeImage.image = UIImage(named:"bike_2.png")
            bikeText.text = "Medium"
        case 2:
            bikeImage.image = UIImage(named:"bike_3.png")
            bikeText.text = "Simple"
        default:
            break;
        }
    }
    
    
    @IBAction func fontSwitch(_ sender: UISwitch) {
        if (sender.isOn) {
            bikeText.font = UIFont (name: "Helvetica Neue", size: 30)
            font = "Helvetica Neue"
            bikeText.text = bikeText.text?.uppercased()
        } else {
            bikeText.font = UIFont (name: "Avenir", size: 30)
            font = "Avenir"
            bikeText.text = bikeText.text?.lowercased()
        }
    }
    
    
    @IBAction func fontSize(_ sender: UISlider) {
        let fontSize = sender.value
        bikeText.font = UIFont(name: font, size: CGFloat(fontSize))
    }
    
    
    
    
    @IBOutlet weak var bikeText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

