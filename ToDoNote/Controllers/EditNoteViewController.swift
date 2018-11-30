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
    }

    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var titleInput: UITextField!
    @IBOutlet weak var detailInput: UITextField!
    @IBOutlet weak var locationInput: UITextField!
    
   
    @IBAction func locationInputTouched(_ sender: Any) {
        locationInput.endEditing(true)
        performSegue(withIdentifier: "searchLocation", sender: Any?.self)
    }
    
    @objc func dismissPicker() {
        view.endEditing(true)
    }
    
    @IBAction func deleteNote(_ sender: Any) {
    }
    
    @IBAction func saveNote(_ sender: Any) {
        if titleInput.text == nil || titleInput.text == "" ||
            detailInput.text == nil || detailInput.text == "" {
            let alertController = UIAlertController(title: "Error in input", message: "Please enter a correct title and description for your task", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Confirm", style: .default, handler: nil))
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
    
    @IBAction func unwindToEdit(_ sender: UIStoryboardSegue){
        if sender.source is LocationSearchViewController{
            if let senderVC = sender.source as? LocationSearchViewController {
                self.locationInput.text = senderVC.newLocation
            }
        }
    }
}
