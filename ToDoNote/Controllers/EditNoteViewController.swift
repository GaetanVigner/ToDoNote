//
//  EditNoteViewController.swift
//  ToDoNote
//
//  Created by gaetan on 27/11/2018.
//  Copyright © 2018 gaetan. All rights reserved.
//

import UIKit
import CoreData

class EditNoteViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let toolBar = UIToolbar().ToolbarPiker(mySelect: #selector(EditNoteViewController.dismissPicker))
        dateTextField.inputAccessoryView = toolBar
        if mo != nil && mo.value(forKey: "title") != nil {
            titleInput.text = mo.value(forKey: "title") as? String
        }
        if mo != nil && mo.value(forKey: "text") != nil {
            detailInput.text = mo.value(forKey: "text") as? String
        }
        if mo != nil && mo.value(forKey: "date") != nil {
            dateTextField.text = mo.value(forKey: "date") as? String
        }
        if mo != nil && mo.value(forKey: "location") != nil {
            locationInput.text = mo.value(forKey: "location") as? String
        }
    }

    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var titleInput: UITextField!
    @IBOutlet weak var detailInput: UITextField!
    @IBOutlet weak var locationInput: UITextField!
    @IBOutlet weak var colorTextField: UITextField!
    @IBOutlet weak var notificationTextField: UITextField!
    
    var mo : NSManagedObject!
    var index : Int!
   
    fileprivate func ErrorModal(title : String, message : String, button: String) {
        let alertController = UIAlertController(title: title, message : message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: button, style : .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func locationInputTouched(_ sender: Any) {
        locationInput.endEditing(true)
        performSegue(withIdentifier: "searchLocation", sender: Any?.self)
    }
    
    @objc func dismissPicker() {
        view.endEditing(true)
    }
    
    @IBAction func deleteNote(_ sender: Any) {
        if index != nil {
            let alertController = UIAlertController(title: NSLocalizedString("Confirm deletion ?", comment: ""), message: NSLocalizedString("Are you sure to delete this note ?", comment: ""), preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: NSLocalizedString("No", comment: ""), style: .default, handler: nil))
            alertController.addAction(UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: .default, handler: { (action: UIAlertAction! ) in
                let myData = MyData()
                myData.deleteData(index: self.index)
                NotificationCenter.default.post(name: NSNotification.Name("reload"), object: nil)
                self.performSegue(withIdentifier: "unwindToMenu", sender: self)
            }))
            present(alertController, animated: true, completion: nil)
        } else
        {
            ErrorModal(title: NSLocalizedString("Error", comment: ""), message:  NSLocalizedString("There is no note to delete", comment: ""), button: NSLocalizedString("Ok", comment: ""))
        }
    }
    
    @IBAction func saveNote(_ sender: Any) {
        if titleInput.text == nil || titleInput.text == "" ||
            detailInput.text == nil || detailInput.text == "" {
            let alertController = UIAlertController(title: NSLocalizedString("Error in input", comment: ""), message: NSLocalizedString("Please enter a correct title and description for your task", comment: ""), preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: NSLocalizedString("Confirm", comment: ""), style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
        } else {
            let myData = MyData()
            if self.index != nil {
                myData.editData(index: index, title: titleInput.text!, text: detailInput.text!, date: dateTextField?.text, location: locationInput?.text)
            } else {
                myData.saveData(title: titleInput.text!, text: detailInput.text!, date: dateTextField?.text, location: locationInput?.text)
            }
            NotificationCenter.default.post(name: NSNotification.Name("reload"), object: nil)
            performSegue(withIdentifier: "unwindToMenu", sender: self)
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
