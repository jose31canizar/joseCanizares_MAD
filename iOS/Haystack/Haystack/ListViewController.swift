//
//  ViewController.swift
//  Haystack
//
//  Created by Jose Canizares on 10/15/17.
//  Copyright © 2017 Jose Canizares. All rights reserved.
//

import UIKit

fileprivate var longPressGesture: UILongPressGestureRecognizer!

class ListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    @IBAction func goBack(_ sender: UIBarButtonItem) {
        print("pressed!")
    }
    var layout = UICollectionViewFlowLayout()
    
    var collectionView : UICollectionView?
    
    var listOfItems = [""]
    
    var index = 0
    
    @IBAction func addListItemToThisList(_ segue: UIStoryboardSegue) {
        self.collectionView?.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.setNeedsDisplay()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        
        longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongGesture(gesture:)))
        
        collectionView?.register(ListItemCollectionViewCell.self, forCellWithReuseIdentifier: "listItemCell")
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.backgroundColor = UIColor.white
        
        collectionView?.alwaysBounceVertical = true
        collectionView?.addGestureRecognizer(longPressGesture)
        
        self.navigationItem.leftBarButtonItem = nil;
        
        self.edgesForExtendedLayout = []
        
        let barButton = UIBarButtonItem(title: "Add Item", style: .plain, target: self, action: #selector(self.addItem))
        self.navigationItem.rightBarButtonItems = [barButton]
    
        self.view.addSubview(collectionView!)
        self.collectionView?.layer.zPosition = -1
//        barButton?.customView?.layer.zPosition = 1
        self.collectionView?.isUserInteractionEnabled = false
        
        self.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem?.isEnabled = true
        
        
        
    }
    
    func addItem() {
        performSegue(withIdentifier: "addListItem", sender: nil)
    }
    
    func goBack() {
    }
    
    @objc func handleLongGesture(gesture: UILongPressGestureRecognizer) {
        print("dragging")
        switch(gesture.state) {
        case .began:
            guard let selectedIndexPath = collectionView?.indexPathForItem(at: gesture.location(in: collectionView)) else {
                break
            }
            collectionView?.beginInteractiveMovementForItem(at: selectedIndexPath)
        case .changed:
            collectionView?.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
        case .ended:
            collectionView?.endInteractiveMovement()
        default:
            collectionView?.cancelInteractiveMovement()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets(top: 100, left: 2, bottom: 10, right: 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: view.frame.width - view.frame.width/10, height: view.frame.height/9)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "listItemCell", for: indexPath as IndexPath) as! ListItemCollectionViewCell
        
        cell.text = listOfItems[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return listOfItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        var tmp = listOfItems
        tmp[sourceIndexPath.item] = listOfItems[destinationIndexPath.item]
        tmp[destinationIndexPath.item] = listOfItems[sourceIndexPath.item]
        listOfItems = tmp
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "listItemCell", for: indexPath as IndexPath) as! ListItemCollectionViewCell
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("preparing")
        if let h = segue.destination as? HayStackViewController {
            print(h)
            h.listOfLists[index].3 = listOfItems
            h.searchResults[index].3 = listOfItems
        }
    }
    
}

