//
//  List.swift
//  Haystack
//
//  Created by Jose Canizares on 10/5/17.
//  Copyright © 2017 Jose Canizares. All rights reserved.
//

import Foundation

enum Cycle {
    case Daily
    case Weekly
    case NoCycle
}

class List {
    var Title: String
    var listItems: [ListItem]
    var cycle : Cycle
    
    init(Title: String) {
        self.Title = Title
    }
    
    init(Title: String, cycle: Cycle) {
        self.Title = Title
        self.cycle = cycle
    }
}
