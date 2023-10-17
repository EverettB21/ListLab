//
//  AddViewController.swift
//  Lab - List
//
//  Created by Everett Brothers on 10/17/23.
//

import UIKit

protocol AddViewControllerDelegate {
    func recieve(_:AddViewController,newTask:ToDo)
}

class AddViewController: UIViewController {

    var delegate: AddViewControllerDelegate?
    var newTask: ToDo?
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var notes: UITextView!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        doneButton.isEnabled = false
        notes.text = "Notes:"
        notes.layer.borderWidth = 2
    }
    
    @IBAction func change(_ sender: Any) {
        updateButton()
    }
    
    func updateButton() {
        guard let text = titleField.text else { return }
        if !text.isEmpty {
            if text != "" {
                doneButton.isEnabled = true
                return
            }
        }
        doneButton.isEnabled = false
    }
    
    @IBAction func doneClicked(_ sender: Any) {
        done()
        performSegue(withIdentifier: "unwindToTable", sender: nil)
    }
    
    func done() {
        guard let titleText = titleField.text else { return }
        let dueDate = datePicker.date
        if let noteText = notes.text {
            newTask = ToDo(title: titleText, isComplete: false, dueDate: dueDate, notes: noteText)
        } else {
            newTask = ToDo(title: titleText, isComplete: false, dueDate: dueDate)
        }
        delegate?.recieve(self, newTask: newTask!)
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
