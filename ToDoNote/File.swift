//
//  File.swift
//  ToDoNote
//
//  Created by Lauga-Cami Tom on 30/11/2018.
//  Copyright © 2018 gaetan. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class MyData {
    
    var myItems : [NSManagedObject] = []
    
    func getData(index: Int) ->NSManagedObject? {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchData = NSFetchRequest<NSManagedObject>(entityName: "Task")
        
        do {
            myItems = try context.fetch(fetchData)
            if myItems.count > index {
                let result : NSManagedObject? = myItems[index]
                return result
            }
            return nil
        } catch {
            return nil
        }
    }
    
    func saveData(title : String, text : String)
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Task", in: context)
        let newTask = NSManagedObject(entity: entity!, insertInto: context)
        newTask.setValue(title, forKey: "title")
        newTask.setValue(text, forKey: "text")
        
        do {
            try context.save()
            myItems.append(newTask)
        } catch {
            print("Save failed")
        }
    }
    
    func deleteData(index : Int)
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        context.delete(myItems[index])
        myItems.remove(at: index)
        
        do {
            try context.save()
        } catch {
            print("Fail to delete")
        }
    }
}
