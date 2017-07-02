//
//  ShowTaskViewController.swift
//  testTask
//
//  Created by Роман Белоусов on 02.07.17.
//  Copyright © 2017 Роман Белоусов. All rights reserved.
//

import UIKit

class ShowTaskViewController: UIViewController {
    
    var task: Task!
    var taskNumber: Int!
    
    @IBOutlet weak var taskNumberLabel: UILabel!
    @IBOutlet weak var taskDescriptionTextView: UITextView!
    @IBOutlet weak var employeeNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Поручение № \(self.taskNumber!)"
        self.taskNumberLabel.text = String(self.taskNumber)  + " " + (task.isDone ? "(Выполнено)" : "(В процессе)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.taskDescriptionTextView.text = self.task.desc
        self.employeeNameLabel.text = self.task.employee?.fio
    }
    
    @IBAction func editTaskTapAction(_ sender: Any) {
        
        performSegue(withIdentifier: "editTaskSegueIdentifier", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "editTaskSegueIdentifier" {
            
            let destinationController = segue.destination as? CreateTaskViewController
            destinationController?.isEditMode = true
            destinationController?.taskForEditing = task
        }
    }
    
}
