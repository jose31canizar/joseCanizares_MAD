//
//  ViewController.swift
//  San_Diego
//
//  Created by Jose Canizares on 9/13/17.
//  Copyright © 2017 Jose Canizares. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var caption: UILabel!
    
    var listOfImages : [String] = []
    
    var captions : [String] = [
                                "Venture through beach city.",
                                "Visit La Jolla beach.",
                                "Enjoy an afternoon on Mission beach.",
                                "Find beautiful views.",
                                "Enjoy some good fun with friends.",
                                "Get lost in the deep blue sea.",
                                "Explore a city of palms.",
                                "Grab some Tacos el Gordo"
                              ]
    
    var currentImage : Int = 0
    
    
    @IBAction func nextButton(_ sender: UIButton) {
        let newImage = (currentImage + 1) % 7
        imageView.image = UIImage(named: listOfImages[newImage])
        currentImage = newImage
        caption.text = captions[newImage]
    }
    
    
    @IBAction func previousButton(_ sender: UIButton) {
        if currentImage <= 0 {
            imageView.image = UIImage(named: listOfImages[7])
            currentImage = 7
            caption.text = captions[7]
            
        } else {
            imageView.image = UIImage(named: listOfImages[currentImage - 1])
             currentImage -= 1
            caption.text = captions[currentImage]
        }
       
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 0...7 {
            listOfImages.append(String(i))
        }
        caption.text = captions[0]
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

