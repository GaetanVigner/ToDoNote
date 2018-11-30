//
//  EditNoteViewController.swift
//  ToDoNote
//
//  Created by gaetan on 27/11/2018.
//  Copyright © 2018 gaetan. All rights reserved.
//

import UIKit

class EditNoteViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let toolBar = UIToolbar().ToolbarPiker(mySelect: #selector(EditNoteViewController.dismissPicker))
        dateTextField.inputAccessoryView = toolBar
        // Do any additional setup after loading the view.
    }

    
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var titleInput: UITextField!
    @IBOutlet weak var detailInput: UITextField!
    
    
    @objc func dismissPicker() {
        view.endEditing(true)
    }
    
    
    @IBAction func deleteNote(_ sender: Any) {
    }
    
    @IBAction func saveNote(_ sender: Any) {
        if titleInput.text == nil || titleInput.text == "" ||
            detailInput.text == nil || detailInput.text == "" {
            let alertController = UIAlertController(title: "Error in input", message: "Please enter a correct title and description for your task", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
        } else {
            let myData = MyData()
            myData.saveData(title: titleInput.text!, text: detailInput.text!)
        }
    }
    
    @IBAction func textFieldEditing(_ sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePicker.Mode.date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(EditNoteViewController.datePickerValueChanged), for: UIControl.Event.valueChanged)
    }
    
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none
        dateTextField.text = dateFormatter.string(from: sender.date)
    }
    
   /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
