//
//  TaskEntity+CoreDataProperties.swift
//  MobileAppToDoList
//
//  Created by ADMIN on 15/06/23.
//
//

import Foundation
import CoreData


extension TaskEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskEntity> {
        return NSFetchRequest<TaskEntity>(entityName: "TaskEntity")
    }

    @NSManaged public var task: String?
    @NSManaged public var time: String?
    @NSManaged public var completed: Bool

}

extension TaskEntity : Identifiable {

}
