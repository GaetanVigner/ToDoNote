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
    
    func getDatas() ->[NSManagedObject]?
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchData = NSFetchRequest<NSManagedObject>(entityName: "Task")
        
        do {
            myItems = try context.fetch(fetchData)
            return myItems
        } catch {
            return nil
        }
    }
    
    func getData(index: Int) ->NSManagedObject?
    {
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
        myItems = getDatas() ?? []
        if myItems.count > index {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            context.delete(myItems[index])
            myItems.remove(at: index)
            
            do {
                try context.save()
            } catch {
                print("Fail to delete")
            }
        } else {
            print("Fail to delete")
        }
    }
    
    func editData(index : Int, title : String, text : String)
    {
        saveData(title: title, text: text)
        deleteData(index: index)
    }
}
