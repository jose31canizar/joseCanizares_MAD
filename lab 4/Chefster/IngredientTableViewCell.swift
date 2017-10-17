//
//  StepTableViewCell.swift
//  Chefster
//
//  Created by Jose Canizares on 10/10/17.
//  Copyright © 2017 Jose Canizares. All rights reserved.
//

import UIKit

class IngredientTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ingredientLabel: UILabel!
    
    
    @IBOutlet weak var completedLabel: UILabel!
    
    var complete : Bool?
    
    var index: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ingredientLabel.font = .boldSystemFont(ofSize: 19)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
