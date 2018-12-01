//
//  ViewNoteViewController.swift
//  ToDoNote
//
//  Created by gaetan on 27/11/2018.
//  Copyright © 2018 gaetan. All rights reserved.
//

import UIKit
import CoreData

class ViewNoteViewController: UIViewController {
    @IBOutlet weak var noteTitle: UILabel!
    @IBOutlet weak var noteText: UITextView!
    @IBOutlet weak var noteAlert: UITextField!
    @IBOutlet weak var noteTime: UITextField!
    
    var mo : NSManagedObject!
    var index : Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if mo.value(forKey: "title") != nil {
            noteTitle.text = mo.value(forKey: "title") as? String
        }
        if mo.value(forKey: "text") != nil {
            noteText.text = mo.value(forKey: "text") as? String
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    @IBAction func editNote(sender: Any?){
        let editNoteViewController = storyboard?.instantiateViewController(withIdentifier: "editNoteView") as? EditNoteViewController
        editNoteViewController?.mo = mo!
        editNoteViewController?.index = index!
        self.navigationController?.pushViewController(editNoteViewController!, animated: true)
    }
}
