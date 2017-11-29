//
//  ListItemCollectionViewCell.swift
//  Haystack
//
//  Created by Jose Canizares on 10/16/17.
//  Copyright © 2017 Jose Canizares. All rights reserved.
//

import UIKit

class ListItemCollectionViewCell: UICollectionViewCell {
    var label : UILabel?
    
    var text : String = "" {
        didSet {
            updateText(newValue: text)
        }
    }
    
    func updateText(newValue: String) {
        print("updating text")
        label?.text = newValue
        label?.sizeToFit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.borderColor = UIColor(hue: 0.5, saturation: 0.88, brightness: 0.24, alpha: 1.0).cgColor
        self.layer.borderWidth = 4
        self.layer.cornerRadius = 8 // optional
        //        label.center = CGPoint(x: 0, y: 0)
        label = UILabel(frame: CGRect(x: 10, y: 10, width: 10, height: self.frame.height/2))
        label?.textAlignment = .left
        label?.font = UIFont(name: "Avenir-Heavy", size: 18)
        label?.textColor = UIColor(hue: 0.5, saturation: 0.88, brightness: 0.24, alpha: 1.0)
        label?.sizeToFit()
        
        self.contentView.addSubview(label!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
