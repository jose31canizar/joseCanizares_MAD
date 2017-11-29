//
//  HayStackCollectionViewCell.swift
//  Haystack
//
//  Created by Jose Canizares on 10/15/17.
//  Copyright © 2017 Jose Canizares. All rights reserved.
//

import UIKit

class HayStackCollectionViewCell: UICollectionViewCell {
    var title : String?
    var subtitle : String?
    
    var label : UILabel?
    
    var subLabel : UILabel?
    
    var editLabel : UILabel?
    
    var text : String = "" {
        didSet {
            updateText(newValue: text)
        }
    }
    
    var labelTag : Int = 0 {
        didSet {
            updateTag(newValue: labelTag)
        }
    }
    
    var subText : String = "" {
        didSet {
            updateSubText(newValue: subText)
        }
    }
    
    var subLabelTag : Int = 0 {
        didSet {
            updateSubTag(newValue: subLabelTag)
        }
    }
    
    func updateText(newValue: String) {
        print("updating text")
        label?.text = newValue
        label?.sizeToFit()
    }
    
    func updateTag(newValue: Int) {
        label?.tag = newValue
        label?.sizeToFit()
    }
    
    func updateSubText(newValue: String) {
        print("updating text")
        subLabel?.text = newValue
        subLabel?.sizeToFit()
    }
    
    func updateSubTag(newValue: Int) {
        subLabel?.tag = newValue
        editLabel?.tag = newValue
        subLabel?.sizeToFit()
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
        
        subLabel = UILabel(frame: CGRect(x: 10, y: self.frame.height/2, width: 10, height: self.frame.height/2))
        subLabel?.textAlignment = .left
        subLabel?.font = UIFont(name: "Avenir", size: 14)
        subLabel?.textColor = UIColor(hue: 0.5, saturation: 0.88, brightness: 0.24, alpha: 1.0)
        subLabel?.sizeToFit()
        self.contentView.addSubview(subLabel!)
        
        editLabel = UILabel(frame: CGRect(x: self.frame.width/2 + 80, y: self.frame.height/2, width: 10, height: self.frame.height/2))
        editLabel?.textAlignment = .right
        editLabel?.font = UIFont(name: "Avenir", size: 14)
        editLabel?.textColor = UIColor(hue: 0.5, saturation: 0.88, brightness: 0.24, alpha: 1.0)
        editLabel?.text = "edit"
        editLabel?.sizeToFit()
        self.contentView.addSubview(editLabel!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
