//
//  EmployeeExtension.swift
//  testTask
//
//  Created by Роман Белоусов on 01.07.17.
//  Copyright © 2017 Роман Белоусов. All rights reserved.
//

import Foundation
import CoreData

extension Employee {
    
    class func findAllEmployees() -> [Employee]? {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Employee.self))
        do {
            let results = try DatabaseManager.shared.getContext().fetch(fetchRequest) as! [Employee]
            
            return results
        } catch {
            print(error)
        }
        
        return nil
    }
    
}
