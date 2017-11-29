//
//  AddListItemViewController.swift
//  Haystack
//
//  Created by Jose Canizares on 10/17/17.
//  Copyright © 2017 Jose Canizares. All rights reserved.
//

import UIKit

class AddListItemViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var addListItemTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)

        addListItemTextField?.delegate = self
        addListItemTextField?.setBottomBorder()
        addListItemTextField?.font = UIFont(name: "Avenir-Heavy", size: 24)
        addListItemTextField?.textColor = UIColor(hue: 0.5, saturation: 0.88, brightness: 0.24, alpha: 1.0)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func hideKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("list view controller 1")
        if let listViewController = segue.destination as? ListViewController {
            print("list view controller 2")
            if let text = addListItemTextField.text {
                listViewController.listOfItems.append(text)
                print(listViewController.listOfItems)
            }
        }
    }
}
