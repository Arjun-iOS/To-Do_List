//
//  AddTaskVCViewController.swift
//  MobileAppToDoList
//
//  Created by ADMIN on 19/06/23.
//

import UIKit

class AddTaskVCViewController: UIViewController {

    @IBOutlet weak var vwDatePicker: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var txtDatePicker: UITextField!
    @IBOutlet weak var txtTaskTitle: UITextField!
    @IBOutlet weak var lblAmPm: UILabel!

    var context = (UIApplication.shared.delegate  as! AppDelegate).persistentContainer.viewContext
    var selectedTaskTime = ""
    var person : TaskEntity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vwDatePicker.isHidden = true
        // Do any additional setup after loading the view.
    }

    @IBAction func showTimePicker(_ sender: UIButton) {
        // Code to show the time picker
        self.showDatePicker()
    }
    @IBAction func cancelTimePicker(_ sender: UIButton) {
        // Code to show the time picker
        self.cancelDatePicker()
    }
    @IBAction func doneTimePicker(_ sender: UIButton) {
        // Code to show the time picker
        self.donedatePicker()
    }
    
    @IBAction func btnSelectAmPm(_ sender: UIButton) {
        // Code to show the time picker
        self.showDatePicker()
    }
    
    
    @IBAction func btnCancelAddTask(_ sender: Any) {
        self.txtTaskTitle.text = ""
        self.txtDatePicker.text = ""
        self.selectedTaskTime = ""
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnAddTask(_ sender: Any) {
        if txtTaskTitle.text == ""{
            let alert = UIAlertController(title: "Alert",
                                          message: "Please enter task title ",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            present(alert, animated: true)
            return
        }else if txtDatePicker.text == ""{
            let alert = UIAlertController(title: "Alert",
                                          message: "Please select task time",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            present(alert, animated: true)
            return
        }else{
            self.addTaskInfo()
        }
        
    }
    
    func addTaskInfo(){
        let dict = ["task":txtTaskTitle.text ?? "","time":selectedTaskTime,"completed":"0"] as [String : String]
        print(dict)
      
        DataBaseManager.sharedInstance.saveUserTask(object: dict)
        self.txtTaskTitle.text = ""
        self.txtDatePicker.text = ""
        self.selectedTaskTime = ""
        self.navigationController?.popViewController(animated: true)

    }
    
    func showDatePicker(){
        //Formate Date
        self.vwDatePicker.isHidden = false
        datePicker.datePickerMode = .time
        datePicker.preferredDatePickerStyle = .wheels
        txtDatePicker.inputView = datePicker
    }
    
    func donedatePicker(){
        self.vwDatePicker.isHidden = true
        print(datePicker.date)

        let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "hh:mm"
        let time = timeFormatter.string(from: datePicker.date)
            
        let amPmFormatter = DateFormatter()
            amPmFormatter.dateFormat = "a"
        let amPm = amPmFormatter.string(from: datePicker.date)
        
        self.selectedTaskTime =  "\(time) \(amPm)"
       
        self.txtDatePicker.text  = time
        self.lblAmPm.text = amPm
        self.view.endEditing(true)
    }
    
    func cancelDatePicker(){
        self.vwDatePicker.isHidden = true
        self.view.endEditing(true)
    }
}
