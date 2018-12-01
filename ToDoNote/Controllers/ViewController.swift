//
//  ViewController.swift
//  ToDoNote
//
//  Created by gaetan on 25/11/2018.
//  Copyright © 2018 gaetan. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    var mydata = MyData()

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(loadList(notification:)), name: NSNotification.Name(rawValue: "reload"), object: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let items : [NSManagedObject]? = mydata.getDatas()
        if items == nil {
            return 0
        }
        return items!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        let items : [NSManagedObject]? = mydata.getDatas()
        cell.Title.text = items![indexPath.item].value(forKey: "title") as? String
        cell.Content.text = items![indexPath.item].value(forKey: "text") as? String
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewNoteViewController = storyboard?.instantiateViewController(withIdentifier: "ViewNote") as? ViewNoteViewController
        let items : [NSManagedObject]? = mydata.getDatas()
        viewNoteViewController?.mo = items?[indexPath.row]
        viewNoteViewController?.index = indexPath.row
        self.navigationController?.pushViewController(viewNoteViewController!, animated: true)
    }
    
    @objc func loadList(notification: NSNotification) {
        self.collectionView.reloadData()
    }
    
    @IBAction func unwindToMenu(_ sender: UIStoryboardSegue){
        
    }
}
