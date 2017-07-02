//
//  Workshop+CoreDataProperties.swift
//  testTask
//
//  Created by Роман Белоусов on 01.07.17.
//  Copyright © 2017 Роман Белоусов. All rights reserved.
//
//

import Foundation
import CoreData


extension Workshop {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Workshop> {
        return NSFetchRequest<Workshop>(entityName: "Workshop")
    }

    @NSManaged public var title: String?
    @NSManaged public var employees: NSSet?

}

// MARK: Generated accessors for employees
extension Workshop {

    @objc(addEmployeesObject:)
    @NSManaged public func addToEmployees(_ value: Employee)

    @objc(removeEmployeesObject:)
    @NSManaged public func removeFromEmployees(_ value: Employee)

    @objc(addEmployees:)
    @NSManaged public func addToEmployees(_ values: NSSet)

    @objc(removeEmployees:)
    @NSManaged public func removeFromEmployees(_ values: NSSet)

}
