//
//  ViewController.swift
//  ToDoNote
//
//  Created by gaetan on 25/11/2018.
//  Copyright © 2018 gaetan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    let items = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addTask(sender : UIButton)
    {
        view.backgroundColor = UIColor.green
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        cell.Title.text = items[indexPath.item]
        cell.Content.text = "azopeiapze azeoiuaze azeoiuazeo poiazpeoi oiazpeo iazepi azpeoi azpeo azeoiaz epaoze azpoeiaz epoiazep oazie apzoei apzoei azpoeia zpoei apzeqsldks lfkjsd skd fhpeor ipozfksdfj sklefjsdkfnslekfj zoeirjfzodfn jfozekfnoziehr "
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }
}

