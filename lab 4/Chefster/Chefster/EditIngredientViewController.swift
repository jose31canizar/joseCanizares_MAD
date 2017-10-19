//
//  AddIngredientViewController.swift
//  Chefster
//
//  Created by Jose Canizares on 10/12/17.
//  Copyright © 2017 Jose Canizares. All rights reserved.
//

import UIKit

class EditIngredientViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var IngredientTextField: UITextField!
    
    var ingredientText : String?
    var complete : Bool?
    var index : Int?
    var adding: Bool = false
    
    
    @IBAction func completeButton(_ sender: UIButton) {
        if complete == nil {
            complete = false
        } else if complete == true {
            complete = false
        } else {
            complete = true
        }
    }
    

    @IBAction func saveButton(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        IngredientTextField.delegate = self
        
        IngredientTextField.text = ingredientText

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    func hideKeyboard() {
        view.endEditing(true)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        updateIngredient(textField)
    }
    
    func updateIngredient(_ textField: UITextField) {
        if let text = textField.text, !text.isEmpty {
            ingredientText = text
        }
    }
    
    //when you click on save
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "edit" && !adding {
            let RecipeViewController = segue.destination as! RecipeViewController
            if let t = ingredientText {
                RecipeViewController.ingredientsList[index!].ingredientText = t
            }
            RecipeViewController.ingredientsList[index!].complete = self.complete
        } else {
            let RecipeViewController = segue.destination as! RecipeViewController
            if let text = ingredientText, let c = complete, let i = index {
                let t = Ingredient(ingredientText: text, complete: c, index: i)
                RecipeViewController.ingredientsList.append(t)
                print("added")
            }
        }
    }
}
