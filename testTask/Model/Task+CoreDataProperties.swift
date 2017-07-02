//
//  Task+CoreDataProperties.swift
//  
//
//  Created by Роман Белоусов on 01.07.17.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var desc: String?
    @NSManaged public var isDone: Bool
    @NSManaged public var employee: Employee?

}
