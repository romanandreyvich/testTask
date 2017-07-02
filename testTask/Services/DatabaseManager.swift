//
//  DatabaseManager.swift
//  testTask
//
//  Created by Роман Белоусов on 01.07.17.
//  Copyright © 2017 Роман Белоусов. All rights reserved.
//

import UIKit
import CoreData
import INSPersistentContainer

typealias NSPersistentContainer         = INSPersistentContainer
typealias NSPersistentStoreDescription  = INSPersistentStoreDescription

class DatabaseManager: NSObject {
    
    static let shared = DatabaseManager()
    
    private override init() {
        
    }
    
    // MARK: - Core Data stack
    
    func isDatabaseEmpty() -> Bool {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Workshop.self))
        do {
            let results = try persistentContainer.viewContext.fetch(fetchRequest) as! [Workshop]
            if results.count > 0 {
                return false
            } else {
                return true
            }
        } catch {
            print(error)
        }
        
        return true
    }
    
    func createTestData() {
        
        if !isDatabaseEmpty() {
            return
        }
        
        let workshop1: Workshop? = NSEntityDescription.insertNewObject(forEntityName: String(describing: Workshop.self),
                                                                 into: persistentContainer.viewContext) as? Workshop
        workshop1?.title = "Первый цех"
        
        let workshop2: Workshop? = NSEntityDescription.insertNewObject(forEntityName: String(describing: Workshop.self),
                                                                       into: persistentContainer.viewContext) as? Workshop
        workshop2?.title = "Второй цех"
        
        let workshop3: Workshop? = NSEntityDescription.insertNewObject(forEntityName: String(describing: Workshop.self),
                                                                       into: persistentContainer.viewContext) as? Workshop
        workshop3?.title = "Третий цех"
        
        let workshop4: Workshop? = NSEntityDescription.insertNewObject(forEntityName: String(describing: Workshop.self),
                                                                       into: persistentContainer.viewContext) as? Workshop
        workshop4?.title = "Четвертый цех"
        
        // MARK: create Employees
        
        let employee1: Employee? = NSEntityDescription.insertNewObject(forEntityName: String(describing: Employee.self),
                                                                       into: persistentContainer.viewContext) as? Employee
        employee1?.fio = "Петров Иван Сидорович"
        
        let employee2: Employee? = NSEntityDescription.insertNewObject(forEntityName: String(describing: Employee.self),
                                                                       into: persistentContainer.viewContext) as? Employee
        employee2?.fio = "Жуков Андрей Петрович"
        
        let employee3: Employee? = NSEntityDescription.insertNewObject(forEntityName: String(describing: Employee.self),
                                                                       into: persistentContainer.viewContext) as? Employee
        employee3?.fio = "Сидоров Виталий Андреевич"
        
        let employee4: Employee? = NSEntityDescription.insertNewObject(forEntityName: String(describing: Employee.self),
                                                                       into: persistentContainer.viewContext) as? Employee
        employee4?.fio = "Белоусов Роман Андреевич"
        
        workshop1?.addToEmployees(employee1!)
        workshop2?.addToEmployees(employee2!)
        workshop3?.addToEmployees(employee3!)
        workshop4?.addToEmployees(employee4!)
        
        // MARK: create Tasks
        
        let task1: Task? = NSEntityDescription.insertNewObject(forEntityName: String(describing: Task.self),
                                                                       into: persistentContainer.viewContext) as? Task
        task1?.desc = "Описание задачи"
        
        let task2: Task? = NSEntityDescription.insertNewObject(forEntityName: String(describing: Task.self),
                                                               into: persistentContainer.viewContext) as? Task
        task2?.desc = "Описание задачи"
        
        let task3: Task? = NSEntityDescription.insertNewObject(forEntityName: String(describing: Task.self),
                                                               into: persistentContainer.viewContext) as? Task
        task3?.desc = "Описание задачи"
        
        let task4: Task? = NSEntityDescription.insertNewObject(forEntityName: String(describing: Task.self),
                                                               into: persistentContainer.viewContext) as? Task
        task4?.desc = "Описание задачи"
        
        let task5: Task? = NSEntityDescription.insertNewObject(forEntityName: String(describing: Task.self),
                                                               into: persistentContainer.viewContext) as? Task
        task5?.desc = "Описание задачи"
        
        let task6: Task? = NSEntityDescription.insertNewObject(forEntityName: String(describing: Task.self),
                                                               into: persistentContainer.viewContext) as? Task
        task6?.desc = "Описание задачи"
        
        let task7: Task? = NSEntityDescription.insertNewObject(forEntityName: String(describing: Task.self),
                                                               into: persistentContainer.viewContext) as? Task
        task7?.desc = "Описание задачи"
        
        let task8: Task? = NSEntityDescription.insertNewObject(forEntityName: String(describing: Task.self),
                                                               into: persistentContainer.viewContext) as? Task
        task8?.desc = "Описание задачи"
        
        let task9: Task? = NSEntityDescription.insertNewObject(forEntityName: String(describing: Task.self),
                                                               into: persistentContainer.viewContext) as? Task
        task9?.desc = "Описание задачи"
        
        let task10: Task? = NSEntityDescription.insertNewObject(forEntityName: String(describing: Task.self),
                                                               into: persistentContainer.viewContext) as? Task
        task10?.desc = "Описание задачи"
        
        employee1?.addToTasks(task1!)
        employee1?.addToTasks(task2!)
        employee1?.addToTasks(task3!)
        
        employee2?.addToTasks(task4!)
        employee2?.addToTasks(task5!)
        
        employee3?.addToTasks(task6!)
        employee3?.addToTasks(task7!)
        
        employee4?.addToTasks(task8!)
        employee4?.addToTasks(task9!)
        employee4?.addToTasks(task10!)
        
        saveContext()
    }
    
    func getContext() -> NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "testTask")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}
