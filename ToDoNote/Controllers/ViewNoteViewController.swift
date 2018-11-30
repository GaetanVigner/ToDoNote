//
//  ViewNoteViewController.swift
//  ToDoNote
//
//  Created by gaetan on 27/11/2018.
//  Copyright © 2018 gaetan. All rights reserved.
//

import UIKit

class ViewNoteViewController: UIViewController {
    @IBOutlet weak var noteTitle: UILabel!
    @IBOutlet weak var noteText: UITextView!
    @IBOutlet weak var noteAlert: UITextField!
    @IBOutlet weak var noteTime: UITextField!
    
    var selectedtitle: String = "Title"
    var selectedNoteText: String = "Your note"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noteTitle.text = selectedtitle
        noteText.text = selectedNoteText
        // Do any additional setup after loading the view.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    @IBAction func editNote(sender: Any?){
    }
}
