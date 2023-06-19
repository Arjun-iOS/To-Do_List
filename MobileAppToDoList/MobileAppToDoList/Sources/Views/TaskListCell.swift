//
//  TaskListCell.swift
//  MobileAppToDoList
//
//  Created by ADMIN on 19/06/23.
//

import UIKit

class TaskListCell: UITableViewCell {

    @IBOutlet weak var lblTaskTitle: UILabel!
    @IBOutlet weak var lblTastStatus: UILabel!
    @IBOutlet weak var lblTaskTime: UILabel!
    @IBOutlet weak var btnMarkCompleted: UIButton!
    @IBOutlet weak var imgCheckbox: UIImageView!

    @IBOutlet weak var btnDeleteTask: UIButton!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
