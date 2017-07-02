//
//  Employee+CoreDataProperties.swift
//  testTask
//
//  Created by Роман Белоусов on 01.07.17.
//  Copyright © 2017 Роман Белоусов. All rights reserved.
//
//

import Foundation
import CoreData


extension Employee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Employee> {
        return NSFetchRequest<Employee>(entityName: "Employee")
    }

    @NSManaged public var fio: String?
    @NSManaged public var workshop: Workshop?
    @NSManaged public var tasks: NSSet?

}

// MARK: Generated accessors for tasks
extension Employee {

    @objc(addTasksObject:)
    @NSManaged public func addToTasks(_ value: Task)

    @objc(removeTasksObject:)
    @NSManaged public func removeFromTasks(_ value: Task)

    @objc(addTasks:)
    @NSManaged public func addToTasks(_ values: NSSet)

    @objc(removeTasks:)
    @NSManaged public func removeFromTasks(_ values: NSSet)

}
