//
//  WorkshopExtension.swift
//  testTask
//
//  Created by Роман Белоусов on 01.07.17.
//  Copyright © 2017 Роман Белоусов. All rights reserved.
//

import Foundation
import CoreData

extension Workshop {
    
    class func findAll() -> [Workshop]? {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Workshop.self))
        do {
            let results = try DatabaseManager.shared.getContext().fetch(fetchRequest) as! [Workshop]
            
            return results
        } catch {
            print(error)
        }
        
        return nil
    }
    
}
