//
//  ViewController.swift
//  Haystack
//
//  Created by Jose Canizares on 10/15/17.
//  Copyright © 2017 Jose Canizares. All rights reserved.
//

import UIKit

fileprivate var longPressGesture: UILongPressGestureRecognizer!

class HayStackViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate, UISearchResultsUpdating, UIGestureRecognizerDelegate {
    
    var layout = UICollectionViewFlowLayout()
    
    var collectionView : UICollectionView?
    
    var themeColor : UIColor?
    
    lazy var searchBar:UISearchBar = UISearchBar()
    
    @IBOutlet weak var sortButton: UIButton!
    
    var searchResults = [
                        ("sports", "a list of things!", 0, ["soccer", "football"]),
                        ("movies", "a list of things to do!", 1, ["Inglorious Basterds", "The Magnificent Seven", "Spotlight", "Her"]),
                        ("shopping", "a list of tasks!", 2, ["macbook pro", "clothes"]),
                        ]

    var listOfLists =  [
        ("sports", "a list of things!", 0, ["soccer", "football"]),
        ("movies", "a list of things to do!", 1, ["Inglorious Basterds", "The Magnificent Seven", "Spotlight", "Her"]),
        ("shopping", "a list of tasks!", 2, ["macbook pro", "clothes"]),
        ]
    
    convenience init() {
        self.init()
    }
    
    var shouldShowSearchResults = false
    
    var searchController : UISearchController?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func loadData() {
        for i in 1...5 {
//            listOfLists.append(("groceries", "a list of tasks", i, [""]))
//            searchResults.append(("groceries", "a list of tasks", i, [""]))
        }
    }
    
    @IBAction func addList(_ segue: UIStoryboardSegue) {
        self.collectionView?.reloadData()
    }
    
    @IBAction func addListItem(_ segue: UIStoryboardSegue) {
        print("adding list item")
        self.collectionView?.reloadData()
    }
    
    func filterContentForSearchText(searchText: String) {
        print(searchText)
        let tmp = listOfLists
        self.searchResults = tmp.filter({( aList: (String, String, Int, [String])) -> Bool in
            // to start, let's just search by name
            return aList.0.lowercased().range(of:searchText.lowercased()) != nil
        })
    }
    
    private func searchDisplayController(_ controller: UISearchController, shouldReloadTableForSearch searchString: String?) -> Bool {
        self.filterContentForSearchText(searchText: searchString!)
        return true
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        shouldShowSearchResults = true
        print("begin editing search bar")
        self.collectionView?.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("end editing search bar")
        self.collectionView?.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        shouldShowSearchResults = true
        searchResults = listOfLists
        print(searchResults)
        print("cancel clicked")
        self.collectionView?.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if !shouldShowSearchResults {
            shouldShowSearchResults = true
            print("search button clicked")
            self.collectionView?.reloadData()
        }
        
        searchController?.searchBar.resignFirstResponder()
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        //do whatever with searchController here.
        print("update search results for search controller")
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        print("update search results")
        if searchController.searchBar.text! != "" {
            filterContentForSearchText(searchText: searchController.searchBar.text!)
        }
        self.collectionView?.reloadData()
        
    }
    
    let filename = "haystack9.plist"
    
    func docFilePath(_ filename: String) -> String?{
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true)
        let dir = path[0] as NSString
        print(dir.appendingPathComponent(filename))
        return dir.appendingPathComponent(filename)
    }

    override func viewDidLoad() {
        
        
        searchController =  UISearchController(searchResultsController: nil)
        searchController?.searchResultsUpdater = self
        searchController?.searchBar.placeholder = "Search your lists"
        searchController?.searchBar.isTranslucent = false
        searchController?.searchBar.searchBarStyle = UISearchBarStyle.prominent
        searchController?.searchBar.delegate = self
        searchController?.searchBar.sizeToFit()
        searchController?.dimsBackgroundDuringPresentation = false
        self.searchController?.hidesNavigationBarDuringPresentation = false;
        self.definesPresentationContext = false;
        
        navigationItem.titleView = searchController?.searchBar
        
        loadData()
        
        sortButton?.imageView?.contentMode = .scaleAspectFit
        
        themeColor = UIColor(hue: 0.5, saturation: 0.88, brightness: 0.24, alpha: 1.0)
        
        longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongGesture(gesture:)))
        
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)

        collectionView?.register(HayStackCollectionViewCell.self, forCellWithReuseIdentifier: "collectionCell")
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.backgroundColor = UIColor.white
        
        collectionView?.alwaysBounceVertical = true
        
        collectionView?.addGestureRecognizer(longPressGesture)

        self.view.addSubview(collectionView!)
        
        let myFirstButton = UIButton()
        myFirstButton.setTitle("Test buttonx", for: .normal)
        self.collectionView?.addSubview(myFirstButton)
        
        self.collectionView?.layer.zPosition = -1
        
        
        let filePath = docFilePath(filename)
        
        if FileManager.default.fileExists(atPath: filePath!){
            let path = filePath
            
            let dataArray = NSArray(contentsOfFile: path!) as! [String]
            listOfLists.removeAll()
            searchResults.removeAll()
            for i in 0...dataArray.count - 1{
                let stringsVSarray = dataArray[i].components(separatedBy: "|")
                print(stringsVSarray)
                let strings = stringsVSarray[0]
                let array = stringsVSarray[1]
                let arrayOfInfo = strings.components(separatedBy: ",")
                let arrayOfItems = array.components(separatedBy: ",")
                let title = arrayOfInfo[0]
                let subtitle = arrayOfInfo[1]
                let ind = arrayOfInfo[2]
                var arr : [String] = [String]()
                if arrayOfItems.count != 0 {
                    for j in 0...arrayOfItems.count - 1 {
                        if arrayOfItems[j] != "" {
                            arr.append(arrayOfItems[j])
                        }
                    }
                    if arrayOfItems[0] != "" {
                        listOfLists.append((title, subtitle, Int(ind)!, arr))
                        searchResults.append((title, subtitle, Int(ind)!, arr))
                    } else {
                        listOfLists.append((title, subtitle, Int(ind)!, []))
                        searchResults.append((title, subtitle, Int(ind)!, []))
                    }
                    
                } else {
                    listOfLists.append((title, subtitle, Int(ind)!, []))
                    searchResults.append((title, subtitle, Int(ind)!, []))
                }
                
            }
            
            self.collectionView?.reloadData()
        }
        
        let app = UIApplication.shared
        
        NotificationCenter.default.addObserver(self, selector: #selector(UIApplicationDelegate.applicationWillResignActive(_:)), name: NSNotification.Name(rawValue: "UIApplicationWillResignActiveNotification"), object: app)
        
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.edgesForExtendedLayout = []
        
        super.viewDidLoad()
    }
    
    func applicationWillResignActive(_ notification: Notification){
        print("writing to file")
        let filePath = docFilePath(filename)
        var arrayData : [String] = [String]()
        for i in 0...listOfLists.count - 1 {
            var string = ""
            string.append(listOfLists[i].0)
            string.append(",")
            string.append(listOfLists[i].1)
            string.append(",")
            string.append(String(listOfLists[i].2))
            string.append("|")
            if listOfLists[i].3.count != 0 {
                for j in 0...listOfLists[i].3.count - 1 {
                    string.append(listOfLists[i].3[j])
                    string.append(",")
                }
            }
            print("string is \(string)")
            arrayData.append(string)
        }
        let data = NSMutableArray(array: arrayData)
        data.write(toFile: filePath!, atomically: true)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.setNeedsDisplay()
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
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        
    super.viewDidLayoutSubviews()
    self.view.setNeedsDisplay()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets(top: view.frame.height/10, left: 2, bottom: 2, right: 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: view.frame.width - view.frame.width/10, height: 65)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath as IndexPath) as! HayStackCollectionViewCell
        
        cell.text = searchResults[indexPath.row].0
        cell.labelTag = indexPath.row
        cell.subText = searchResults[indexPath.row].1
        cell.subLabelTag = indexPath.row
        
        let editTap = UITapGestureRecognizer(target: self, action: #selector(self.editList(sender:)))
        editTap.delegate = self
        cell.label?.addGestureRecognizer(editTap)
        cell.label?.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.addNewList(sender:)))
        tap.delegate = self
        cell.editLabel?.addGestureRecognizer(tap)
        cell.editLabel?.isUserInteractionEnabled = true
        
        cell.label?.layer.zPosition = 1
        cell.contentView.bringSubview(toFront: cell.label!)
        
        return cell
    }
    
    func addNewList(sender: UITapGestureRecognizer) {
        print("going to add new list")
        performSegue(withIdentifier: "addNewList", sender: sender)
    }
    
    func editList(sender: UITapGestureRecognizer) {
        print("going to edit a list")
        performSegue(withIdentifier: "editList", sender: sender)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return searchResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        print("start index: \(sourceIndexPath.item)")
        print("end index: \(destinationIndexPath.item)")
        var tmp = searchResults
        tmp[sourceIndexPath.item] = searchResults[destinationIndexPath.item]
        tmp[destinationIndexPath.item] = searchResults[sourceIndexPath.item]
        searchResults = tmp
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath as IndexPath) as! HayStackCollectionViewCell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addNewList" {
            if let s = sender as? UITapGestureRecognizer {
                print("s is \(s)")
                if let a = segue.destination as? AddNewListViewController {
                    if let label = s.view as? UILabel {
                        print("label is \(label)")
                        if let i = label.tag as? Int {
                            print("tag is \(i)")
                            print(searchResults)
                            a.listTitle = listOfLists[i].0
                            a.index = i
                            print("list title is \(a.listTitle)")
                        }
                    }
                }
            } else if let s = sender as? UIBarButtonItem {
                if let a = segue.destination as? AddNewListViewController {
                    a.newList = true
                }
            }
        } else if segue.identifier == "editList" {
            print(sender)
            if let s = sender as? UITapGestureRecognizer {
                print("s is \(s)")
                if let l = segue.destination as? ListViewController {
                    if let label = s.view as? UILabel {
                        print("label is \(label)")
                        if let i = label.tag as? Int {
                            print("tag is \(i)")
                            print(searchResults)
                            l.listOfItems = listOfLists[i].3
                            l.index = i
                            print("list of items is \(l.listOfItems)")
                        }
                    }
                }
            }
        }
        
    }
    
    
    
    


}

