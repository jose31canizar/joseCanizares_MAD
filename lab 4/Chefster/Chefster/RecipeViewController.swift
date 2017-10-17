//
//  ViewController.swift
//  Chefster
//
//  Created by Jose Canizares on 10/10/17.
//  Copyright © 2017 Jose Canizares. All rights reserved.
//

import UIKit

class RecipeViewController: UITableViewController {
    
    
    let filename = "ingredients.plist"
    
    func docFilePath(_ filename: String) -> String?{
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true)
        let dir = path[0] as NSString
        print(dir.appendingPathComponent(filename))
        return dir.appendingPathComponent(filename)
    }
    
    @IBAction func addNewIngredient(_ sender: Any) {
        self.performSegue(withIdentifier: "add", sender: tableView)
    }
    
    var ingredientsList = [
                            Ingredient(ingredientText: "1/2 cup chopped yellow onion", complete: false, index: 0),
                            Ingredient(ingredientText: "2 tablespoons olive oil", complete: false, index: 1),
                            Ingredient(ingredientText: "3 tablespoons butter, divided", complete: false, index: 2),
                            Ingredient(ingredientText: "1 stalk celery, chopped", complete: false, index: 3),
                            
                          ]
    
    typealias ingredientTuple = (ingredientText: String, complete: Bool, index: Int)
    
    override func viewDidLoad() {
         let filePath = docFilePath(filename)
        
        if FileManager.default.fileExists(atPath: filePath!){
            let path = filePath
            
            let dataArray = NSArray(contentsOfFile: path!) as! [ingredientTuple]
            print(dataArray)
            print("view did load \(dataArray)")
            for i in 1...dataArray.count - 1 {
                ingredientsList.append(Ingredient(ingredientText: dataArray[i].ingredientText, complete: dataArray[i].complete, index: dataArray[i].index))
            }
            
            self.tableView.reloadData()
        }
        
        tableView.delegate = self
        
        let app = UIApplication.shared
    
        NotificationCenter.default.addObserver(self, selector: #selector(UIApplicationDelegate.applicationWillResignActive(_:)), name: NSNotification.Name(rawValue: "UIApplicationWillResignActiveNotification"), object: app)
        
        super.viewDidLoad()
        
    }
    

    func applicationWillResignActive(_ notification: Notification){
        let filePath = docFilePath(filename)
//        let data = NSMutableArray()
        
        var ingredientsListOfTuples = [ingredientTuple]()
        
        for i in 1...ingredientsList.count - 1 {
            print("asdf")
            ingredientsListOfTuples.append((ingredientText: ingredientsList[i].ingredientText!, complete: ingredientsList[i].complete!, index: ingredientsList[i].index!))
        }

        let data = NSMutableArray(array: ingredientsListOfTuples)
        //write the contents of the array to our plist file
        data.write(toFile: filePath!, atomically: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        DispatchQueue.main.async(){
        let row = indexPath.row
        self.performSegue(withIdentifier: "edit", sender: row)
        }
    }
    
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredientsList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> IngredientTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredient", for: indexPath) as! IngredientTableViewCell
        let row = indexPath.row
        cell.ingredientLabel.text = ingredientsList[row].ingredientText
        cell.backgroundColor = UIColor.white
        cell.ingredientLabel.textAlignment = NSTextAlignment.right
        cell.completedLabel.text = ingredientsList[row].complete! ? "✔︎" : ""
        cell.complete = ingredientsList[row].complete! ? true : false
        cell.index = ingredientsList[row].index
        return cell
    }
    
    @IBAction func saveIngredient(_ segue: UIStoryboardSegue) {
        if segue.identifier == "edit" {
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editIngredient" {
            let EditIngredientViewController = segue.destination as! EditIngredientViewController
            if let cell = sender as? IngredientTableViewCell
            {
                if let ingredientLabel = cell.ingredientLabel.text {
                    EditIngredientViewController.ingredientText = ingredientLabel
                }
                if let complete = cell.complete {
                    EditIngredientViewController.complete = complete
                }
                if let i = cell.index {
                    EditIngredientViewController.index = i
                }
            }
            EditIngredientViewController.adding = false
        } else if segue.identifier == "addNewIngredient" {
            let AddIngredientViewController = segue.destination as! EditIngredientViewController
            AddIngredientViewController.ingredientText = ""
            AddIngredientViewController.complete = false
            AddIngredientViewController.index = ingredientsList.count
            AddIngredientViewController.adding = true
        }
    }
    
    
}

