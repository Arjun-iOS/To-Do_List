//
//  DataBaseManager.swift
//  MobileAppToDoList
//
//  Created by ADMIN on 19/06/23.
//

import Foundation
import Foundation
import CoreData
import UIKit


class DataBaseManager {
    
    static var sharedInstance = DataBaseManager()
    
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    
    func saveUserTask(object : [String:String]){
        
        //TODO: Create a person object

        let TaskEntity = NSEntityDescription.insertNewObject(forEntityName: "TaskEntity", into: context!) as! TaskEntity
        TaskEntity.task = object["task"]
        TaskEntity.time = object["time"] 
        TaskEntity.completed = object["completed"]
        
        //save the data
        do {
            try context?.save()
        }catch{
            print("data is not save")
        }
        
    }
    
    func editTaskData(dict:[String:String],i:Int){
        var tasts = getTaskData()
        tasts[i].task = dict["task"]
        tasts[i].time = dict["time"]
        tasts[i].completed = dict["completed"]
        
        do{
            try context?.save()
        }catch{
           print("data is not valid")
        }
    }
    

    
    func getTaskData() -> [TaskEntity]{
        
        var TaskEntity = [TaskEntity]()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "TaskEntity")
        
        do {
            TaskEntity = try context?.fetch(fetchRequest) as! [TaskEntity]
        }catch{
            print("Not Found")
        }
        return TaskEntity
        
    }
    
    func deleteTask(index:Int)-> [TaskEntity]{
        var taskEntity = getTaskData()
        
        context?.delete(taskEntity[index])
        taskEntity.remove(at: index)
        
        do {
            try context?.save()
        }catch{
            print("Can not delete data")
        }
        
        return taskEntity
    }
   
    
}
