//
//  TaskExtension.swift
//  testTask
//
//  Created by Роман Белоусов on 01.07.17.
//  Copyright © 2017 Роман Белоусов. All rights reserved.
//

import Foundation
import CoreData

extension Task {
    
    class func getAllTasks(ByWorkshop workshop: Workshop, andFilter filter: MainTableViewController.Filter) -> [Task]? {
        
        let employees = workshop.employees?.allObjects as! [Employee]
        var tasks = [Task]()
        
        for employee: Employee in employees {
            tasks += employee.tasks?.allObjects as! [Task]
        }
        
        switch filter {
        case .Done:
            tasks = tasks.filter{$0.isDone == true}
        case .NotDone:
            tasks = tasks.filter{$0.isDone == false}
        default:
            break
        }
        
        if tasks.isEmpty {
            return nil
        }
        
        return tasks
    }
    
    class func removeTask(task: Task) {
        
        DatabaseManager.shared.getContext().delete(task)
        DatabaseManager.shared.saveContext()
    }
}
