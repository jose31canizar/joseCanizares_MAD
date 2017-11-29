//
//  EditListViewController.swift
//  Haystack
//
//  Created by Jose Canizares on 10/15/17.
//  Copyright © 2017 Jose Canizares. All rights reserved.
//

import UIKit

class AddNewListViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    var types = [
                "it's a list of tasks!",
                "it's a list of items!",
                "it's a routine!",
                "it's a collection of things!",
                ]
    
    var newList: Bool = false

    
    var selectedType = "it's a list of tasks!"
    
    var listTitle : String = ""
    
    var index = 0

    @IBOutlet weak var listTitleField: UITextField!
    
    @IBOutlet weak var listTypePicker: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listTitleField.text = listTitle
        
        listTitleField.delegate = self
        listTypePicker.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        listTitleField?.setBottomBorder()
        listTitleField?.font = UIFont(name: "Avenir-Heavy", size: 24)
        listTitleField?.textColor = UIColor(hue: 0.5, saturation: 0.88, brightness: 0.24, alpha: 1.0)
        // Do any additional setup after loading the view.
    }

    func hideKeyboard() {
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return types.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(types[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        selectedType = types[row]
        setListType()
    }
    
    func setListType() {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if newList == true {
            if let haystack = segue.destination as? HayStackViewController {
                haystack.listOfLists.append(((listTitleField?.text)!, selectedType, haystack.listOfLists.count, []))
                haystack.searchResults.append(((listTitleField?.text)!, selectedType, haystack.listOfLists.count, []))
            }
        } else {
            if let haystack = segue.destination as? HayStackViewController {
                if let text = listTitleField.text {
                    haystack.listOfLists[index].0 = text
                    haystack.listOfLists[index].1 = selectedType
                    haystack.searchResults[index].0 = text
                    haystack.searchResults[index].1 = selectedType
                }
            }
        }
    }
    
    

}

extension UITextField {
    func setBottomBorder() {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}
