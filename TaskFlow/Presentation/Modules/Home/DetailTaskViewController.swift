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
        print(task ?? "no se encontro task")
        taskTitleLabel.text = task.title
        taskDescriptionLabel.text = task.description
        if let status = task.status {
            statusTaskLabel.text = status.name
            taskBadgeLabel.text = status.name
        }
        if let assignedTo = task.assignedTo, let assignedBy = task.assignedBy {
            nameAssignedToLabel.text = ("\(assignedTo.name) \(assignedTo.lastName)")
            userCodeAssignedToLabel.text = ("ID: \(assignedTo.userCode)")
            nameAssignedByLabel.text = ("\(assignedBy.name) \(assignedBy.lastName)")
            userCodeAssignedByLabel.text = ("ID: \(assignedBy.userCode)")
        }
    }

}
