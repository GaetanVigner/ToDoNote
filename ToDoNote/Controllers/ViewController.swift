//
//  ViewController.swift
//  ToDoNote
//
//  Created by gaetan on 25/11/2018.
//  Copyright © 2018 gaetan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    var items = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
    var texts = ["00000", "111111", "222222", "33333", "4444", "5555555", "666666", "77777", "88888"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        cell.Title.text = items[indexPath.item]
        cell.Content.text = texts[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewNoteViewController = storyboard?.instantiateViewController(withIdentifier: "ViewNote") as? ViewNoteViewController
        viewNoteViewController?.selectedNoteText = self.texts[indexPath.row]
        viewNoteViewController?.selectedtitle = self.items[indexPath.row]
        self.navigationController?.pushViewController(viewNoteViewController!, animated: true)
    }
    
    @IBAction func unwindToMenu(_ sender: UIStoryboardSegue){
        
    }
}
