//
//  DetailTaskViewController.swift
//  TaskFlow
//
//  Created by Ian Axel Perez de la Torre on 05/01/26.
//

import UIKit

class DetailTaskViewController: UIViewController {
    
    @IBOutlet weak var taskTitleLabel: UILabel!
    @IBOutlet weak var statusTaskLabel: UILabel!
    @IBOutlet weak var taskbadgeContainerView: UIView!
    @IBOutlet weak var taskBadgeLabel: UILabel!
    @IBOutlet weak var nameAssignedToLabel: UILabel!
    @IBOutlet weak var userCodeAssignedToLabel: UILabel!
    @IBOutlet weak var nameAssignedByLabel: UILabel!
    @IBOutlet weak var userCodeAssignedByLabel: UILabel!
    @IBOutlet weak var taskDescriptionLabel: UILabel!
    
    var viewModel: HomeViewModel!
    var task: UserTask!

    override func viewDidLoad() {
        super.viewDidLoad()
        fillDetailData()
        // Do any additional setup after loading the view.
    }
    
    private func fillDetailData() {
        taskTitleLabel.text = task.title
        statusTaskLabel.text = task.status.name
        taskBadgeLabel.text = task.status.name
        nameAssignedToLabel.text = ("\(task.assignedTo.name) \(task.assignedTo.lastName)")
        userCodeAssignedToLabel.text = ("ID: \(task.assignedTo.userCode)")
        nameAssignedByLabel.text = ("\(task.assignedBy.name) \(task.assignedBy.lastName)")
        userCodeAssignedByLabel.text = ("ID: \(task.assignedBy.userCode)")
        taskDescriptionLabel.text = task.description
        
    }

}
