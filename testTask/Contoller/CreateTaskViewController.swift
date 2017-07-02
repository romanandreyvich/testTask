//
//  CreateTaskViewController.swift
//  testTask
//
//  Created by Роман Белоусов on 01.07.17.
//  Copyright © 2017 Роман Белоусов. All rights reserved.
//

import UIKit
import CoreData

class CreateTaskViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var taskDescriptionTextView: UITextView!
    @IBOutlet weak var employeePickerView: UIPickerView!
    @IBOutlet weak var deleteTaskButton: UIButton!
    
    var employees: [Employee]!
    
    var isEditMode = false
    var taskForEditing: Task!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.employeePickerView.delegate = self
        
        if let arrayOfEmployees = Employee.findAllEmployees() {
            self.employees = arrayOfEmployees
        }
        
        let toolbar = UIToolbar()
        toolbar.setItems([UIBarButtonItem.init(barButtonSystemItem: .done, target: self, action: #selector(self.cancelBarButtonTapAction))], animated: false)
        toolbar.sizeToFit()
        self.taskDescriptionTextView.inputAccessoryView = toolbar
        
        if isEditMode {
            self.taskDescriptionTextView.text = taskForEditing.desc
            self.employeePickerView.selectRow(self.employees.index(of: self.taskForEditing.employee!)!, inComponent: 0, animated: true)
            self.deleteTaskButton.isHidden = false
        }
    }
    
    // MARK: UIPickerView
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return self.employees.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return self.employees[row].fio
    }
    
    // MARK: - Actions
    
    @IBAction func deleteButtonTapAction(_ sender: Any) {
        
        Task.removeTask(task: self.taskForEditing)
        
        if self.presentingViewController != nil {
            (self.presentingViewController as! UINavigationController).popToRootViewController(animated: false)
        }
            
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func cancelBarButtonTapAction() {
        
        self.taskDescriptionTextView.resignFirstResponder()
    }
    
    @IBAction func cancelButtonTapAction(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonTapAction(_ sender: Any) {
        
        if taskDescriptionTextView.text == "" {
            
            let errorAlert = UIAlertController(title: "Ошибка", message: "Введите описание поручения", preferredStyle: .alert)
            errorAlert.addAction(UIAlertAction(title: "ОК", style: .cancel, handler: nil))
            self.present(errorAlert, animated: true, completion: nil)
            
            return
        }
        
        if isEditMode {
            
            self.taskForEditing.desc = self.taskDescriptionTextView.text
            self.taskForEditing.employee = self.employees[self.employeePickerView.selectedRow(inComponent: 0)]
        } else {
            let task: Task? = NSEntityDescription.insertNewObject(forEntityName: String(describing: Task.self),
                                                                   into: DatabaseManager.shared.getContext()) as? Task
            task?.desc = self.taskDescriptionTextView.text
            task?.employee = self.employees[self.employeePickerView.selectedRow(inComponent: 0)]
        }
        
        DatabaseManager.shared.saveContext()
        self.dismiss(animated: true, completion: nil)
    }
}
