//
//  DetailTaskViewController.swift
//  TaskFlow
//
//  Created by Ian Axel Perez de la Torre on 05/01/26.
//

import UIKit
import Combine

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
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    var viewModel: HomeViewModel!
    var task: UserTask!
    
    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        fillDetailData()
        bind()
        
        // Do any additional setup after loading the view.
    }
    
    private func bind() {
        loadingIndicator.hidesWhenStopped = true
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
        
        viewModel.$errorMessage
            .receive(on: RunLoop.main)
            .sink { [weak self] error in
                if error != nil { self?.showToast(message: "\(error ?? "")", seconds: 3.0) }
            }
            .store(in: &cancellables)
        
        viewModel.$isLoading
            .receive(on: RunLoop.main)
            .sink { [weak self] loading in
                if loading { self?.loadingIndicator.startAnimating() }
                else { self?.loadingIndicator.stopAnimating() }
            }
            .store(in: &cancellables)
        
        
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
        updateTaskButton.isEnabled = false
        
        defer { updateTaskButton.isEnabled = true }
        
        Task { @MainActor in
            let update = await viewModel.updateTask(taskId: task.id, statusId: task.statusId + 1)
            if update {
                self.showToast(message: "Tarea actualizada correctamente. ", seconds: 3.0)
            }
        }
    }
    

}
