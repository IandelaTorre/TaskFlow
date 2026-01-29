//
//  DetailTaskViewController.swift
//  TaskFlow
//
//  Created by Ian Axel Perez de la Torre on 05/01/26.
//

import UIKit

class DetailTaskViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var taskTitleLabel: UILabel!
    @IBOutlet weak var taskbadgeContainerView: UIView!
    @IBOutlet weak var taskBadgeLabel: UILabel!
    @IBOutlet weak var nameAssignedToLabel: UILabel!
    @IBOutlet weak var userCodeAssignedToLabel: UILabel!
    @IBOutlet weak var nameAssignedByLabel: UILabel!
    @IBOutlet weak var userCodeAssignedByLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var updateTaskButton: UIButton!
    @IBOutlet weak var textViewHeightConstraint: NSLayoutConstraint!
    
    var viewModel: HomeViewModel!
    var task: UserTask!

    override func viewDidLoad() {
        super.viewDidLoad()
        fillDetailData()
        bind()
        
        // Do any additional setup after loading the view.
    }
    
    private func bind() {
        switch task.statusId {
        case 1:
            updateTaskButton.titleLabel?.text = "Iniciar tarea "
        case 2:
            updateTaskButton.titleLabel?.text = "Marcar como completada "
        case 3:
            updateTaskButton.titleLabel?.text = "Marcar como completada "
            updateTaskButton.isEnabled = false
        default:
            updateTaskButton.titleLabel?.text = "Actualizar estado de tarea "
            updateTaskButton.isEnabled = false
        }
        
        
    }
    
    private func fillDetailData() {
        print(task ?? "no se encontro task")
        taskTitleLabel.text = task.title
        descriptionTextView.text = task.description
        if let status = task.status {
            taskBadgeLabel.text = status.name
        }
        if let assignedTo = task.assignedTo, let assignedBy = task.assignedBy {
            nameAssignedToLabel.text = ("\(assignedTo.name) \(assignedTo.lastName)")
            userCodeAssignedToLabel.text = ("ID: \(assignedTo.userCode)")
            nameAssignedByLabel.text = ("\(assignedBy.name) \(assignedBy.lastName)")
            userCodeAssignedByLabel.text = ("ID: \(assignedBy.userCode)")
        }
    }
    
    @IBAction func UpdateTaskButtonAction(_ sender: Any) {
        Task { @MainActor in
            let update = await viewModel.updateTask(taskId: task.id, statusId: task.statusId + 1)
            if update {
                self.showToast(message: "Tarea actualizada correctamente. ", seconds: 3.0)
            }
        }
    }
    

}
