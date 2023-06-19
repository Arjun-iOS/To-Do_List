//
//  ViewController.swift
//  MobileAppToDoList
//
//  Created by ADMIN on 19/06/23.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var vwTopView: UIView!
    @IBOutlet weak var lblNoData: UILabel!
    var i = 0


    var arrTaskList  = [TaskEntity]()

    override func viewDidLoad() {
        self.lblNoData.isHidden = true
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.register(UINib(nibName: "TaskListCell", bundle: nil), forCellReuseIdentifier: "TaskListCell")
        tableView.rowHeight = 60 // Set a fixed row height for the cells
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.arrTaskList = DataBaseManager.sharedInstance.getTaskData()
        print(arrTaskList.count)
        self.updateTableViewHeight()
        self.tableView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
          super.viewDidLayoutSubviews()
          updateTableViewHeight()
      }

    @IBAction func btnGoToAddTask(_ sender: Any) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "AddTaskVCViewController") as! AddTaskVCViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}


extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrTaskList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskListCell", for: indexPath) as! TaskListCell
        let obj = arrTaskList[indexPath.row]
        
        
        let timeString = obj.time

        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"

        if let time = formatter.date(from: timeString!) {
            let currentTime = Date()
            
            let calendar = Calendar.current
            let timeComponents = calendar.dateComponents([.hour, .minute], from: time)
            let currentComponents = calendar.dateComponents([.hour, .minute], from: currentTime)
            
            if let timeHour = timeComponents.hour, let timeMinute = timeComponents.minute,
               let currentHour = currentComponents.hour, let currentMinute = currentComponents.minute {
                
                if timeHour > currentHour || (timeHour == currentHour && timeMinute > currentMinute) {
                    // Time is later than current time
                    cell.lblTaskTitle.textColor = UIColor.black
                    cell.lblTastStatus.isHidden = true
                    
                } else {
                    // Time is equal to or earlier than current time
                    cell.lblTaskTitle.textColor = UIColor.red
                    cell.lblTastStatus.isHidden = false

                }
            }
        }
        
        if  obj.completed == "1"{
            cell.lblTaskTitle.text = obj.task

            cell.lblTaskTitle.textColor = UIColor.black
            cell.imgCheckbox.image = UIImage(named: "checkedcheckboxChcked")
            cell.lblTastStatus.isHidden = true

        }else{
            cell.lblTaskTitle.text = obj.task
            cell.imgCheckbox.image = UIImage(named: "VectorcheckBox")
        }
            
            
        cell.lblTaskTime.text = obj.time
       // cell.lblTastStatus.text = "Pending"
        cell.btnDeleteTask.tag = indexPath.row
        cell.btnDeleteTask.addTarget(self, action: #selector(buttonSelected), for:.touchUpInside)
        
        cell.btnMarkCompleted.tag = indexPath.row
        cell.btnMarkCompleted.addTarget(self, action: #selector(btnMarkCompleted), for:.touchUpInside)
        
       
        return cell
    }
    
    @objc func btnMarkCompleted(sender: UIButton){
        print(sender.tag)
        i = sender.tag
        let obj = arrTaskList[sender.tag]
        let dict = ["task":obj.task ?? "","time":obj.time ?? "" ,"completed":"1"]
        DataBaseManager.sharedInstance.editTaskData(dict: dict, i: i)
        self.arrTaskList = DataBaseManager.sharedInstance.getTaskData()
        print(arrTaskList.count)
        self.updateTableViewHeight()
        self.tableView.reloadData()
    }
    
    @objc func buttonSelected(sender: UIButton){
        print(sender.tag)
        let obj = arrTaskList[sender.tag]
        
        // Display an alert to confirm deletion
        let alertController = UIAlertController(title: "Warning", message: "Do you want to delete “\(obj.task ?? "")”, this action can’t be undone.", preferredStyle: .alert)
                   
                   // Create the delete action
                   let deleteAction = UIAlertAction(title: "OK", style: .destructive) { (action) in
                       // Perform the deletion
                       self.arrTaskList = DataBaseManager.sharedInstance.deleteTask(index: sender.tag)
                       self.updateTableViewHeight()
                       self.tableView.reloadData()
                   }
                   
                   // Create the cancel action
                   let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                   
                   // Add the actions to the alert controller
                   alertController.addAction(deleteAction)
                   alertController.addAction(cancelAction)
                   
                   // Present the alert controller
                   self.present(alertController, animated: true, completion: nil)
     
    }
    // MARK: - Helper Methods
        func updateTableViewHeight() {
            
            if arrTaskList.count == 0 {
                self.lblNoData.isHidden = false
                self.vwTopView.isHidden = true
            }else{
                self.lblNoData.isHidden = true
                self.vwTopView.isHidden = false
            }
            tableViewHeightConstraint.constant = CGFloat(self.arrTaskList.count * 60)
            tableView.layoutIfNeeded()
        }
    
}
