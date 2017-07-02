//
//  MainTableViewController.swift
//  testTask
//
//  Created by Роман Белоусов on 01.07.17.
//  Copyright © 2017 Роман Белоусов. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    var workshops = [Workshop]()
    var tasks = [Task]()
    var filter = Filter.All
    
    enum Filter {
        case All
        case NotDone
        case Done
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Задачи"
        workshops = Workshop.findAll()!
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        DatabaseManager.shared.saveContext()
        super.viewDidDisappear(true)
    }
    
    // MARK: - Actions
    
    @IBAction func filterButtonTapAction(_ sender: Any) {
        
        let filterAlertSheet = UIAlertController(title: "Фильтр поручений", message: "Выберите фильтр", preferredStyle: .actionSheet)
        filterAlertSheet.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        filterAlertSheet.addAction(UIAlertAction(title: "Показать поручения в процессе", style: .default, handler: { (_) in
            self.filter = .NotDone
            self.tableView.reloadData()
        }))
        filterAlertSheet.addAction(UIAlertAction(title: "Показать выполненые поручения", style: .default, handler: { (_) in
           self.filter = .Done
            self.tableView.reloadData()
        }))
        filterAlertSheet.addAction(UIAlertAction(title: "Показать все поручения", style: .default, handler: { (_) in
           self.filter = .All
            self.tableView.reloadData()
        }))
        
        self.present(filterAlertSheet, animated: true, completion: nil)
    }
    
    @IBAction func createTaskButtonTapAction(_ sender: Any) {
        
        self.performSegue(withIdentifier: "createNewTaskSegueIdentifier", sender: self)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showTaskSegueIdentifier" {
            
            let destinationController = segue.destination as? ShowTaskViewController
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let tasks = Task.getAllTasks(ByWorkshop: self.workshops[indexPath.section], andFilter: filter)
                
                if tasks != nil {
                    destinationController?.task = tasks![indexPath.row]
                    destinationController?.taskNumber = indexPath.row + 1
                }
            }
        }
    }

}

extension MainTableViewController {
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return workshops.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return self.workshops[section].title
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let workshop = self.workshops[section]
        let tasks = Task.getAllTasks(ByWorkshop: workshop, andFilter: filter)
        if tasks != nil {
            return tasks!.count
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TaskTableViewCell
        let tasks = Task.getAllTasks(ByWorkshop: self.workshops[indexPath.section], andFilter: filter)
        if tasks != nil {
            let task = tasks![indexPath.row]
            cell.taskIdLabel.text = String(describing: indexPath.row + 1)
            cell.taskIdLabel.text = cell.taskIdLabel.text! + " | " + (task.isDone ? "(Выполнено)" : "(В процессе)")
            cell.taskDescriptionLabel.text = task.desc
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "showTaskSegueIdentifier", sender: nil)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let moreRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Еще", handler:{action, indexpath in
            let changeStatusAlertSheet = UIAlertController(title: "Изменить статус поручения", message: "Выберите статус поручения", preferredStyle: .actionSheet)
            changeStatusAlertSheet.addAction(UIAlertAction(title: "В процессе", style: .default, handler: { (_) in
                
                let tasks = Task.getAllTasks(ByWorkshop: self.workshops[indexPath.section], andFilter: self.filter)
                if tasks != nil {
                    let task = tasks![indexPath.row]
                    task.isDone = false
                    tableView.reloadData()
                }
            }))
            changeStatusAlertSheet.addAction(UIAlertAction(title: "Выполнено", style: .default, handler: { (_) in
                
                let tasks = Task.getAllTasks(ByWorkshop: self.workshops[indexPath.section], andFilter: self.filter)
                if tasks != nil {
                    let task = tasks![indexPath.row]
                    task.isDone = true
                    tableView.reloadData()
                }
            }))
            changeStatusAlertSheet.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
            self.present(changeStatusAlertSheet, animated: true, completion: nil)
        });
        moreRowAction.backgroundColor = UIColor(red: 255/255, green: 138/255, blue: 2/255, alpha: 1.0);
        
        let deleteRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Удалить", handler:{action, indexpath in
            let tasks = Task.getAllTasks(ByWorkshop: self.workshops[indexPath.section], andFilter: self.filter)
            if tasks != nil {
                let task = tasks![indexPath.row]
                Task.removeTask(task: task)
                tableView.reloadData()
            }
        });
        
        return [deleteRowAction, moreRowAction];
    }
    
}
