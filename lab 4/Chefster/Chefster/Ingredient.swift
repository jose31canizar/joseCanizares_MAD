//
//  Ingredient.swift
//  Chefster
//
//  Created by Jose Canizares on 10/12/17.
//  Copyright © 2017 Jose Canizares. All rights reserved.
//

import Foundation

class Ingredient {
    var ingredientText : String?
    var complete : Bool?
    var index : Int?
    init(ingredientText: String, complete:Bool, index: Int) {
        self.ingredientText = ingredientText
        self.complete = complete
        self.index = index
    }
}
