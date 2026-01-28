//
//  AddTaskViewController.swift
//  TaskFlow
//
//  Created by Ian Axel Perez de la Torre on 05/01/26.
//

import UIKit
import Combine

class AddTaskViewController: UIViewController {
    
    @IBOutlet weak var assignToTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var createTaskButton: UIButton!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    var viewModel: HomeViewModel!
    
    private var cancellables: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        viewModel.loadUser()

    }
    
    private func bind() {
        loadingIndicator.hidesWhenStopped = true
        viewModel.$isLoading
            .receive(on: RunLoop.main)
            .sink { [weak self] loading in
                if loading { self?.loadingIndicator.startAnimating() }
                else { self?.loadingIndicator.stopAnimating() }
            }
            .store(in: &cancellables)
        
    }
    
    @IBAction func CreateTaskButtonAction(_ sender: Any) {
        createTaskButton.isEnabled = false
        
        
        defer {
            createTaskButton.isEnabled = true
        }
        
        Task { @MainActor in
            if let assignTo = assignToTextField.text, let title = titleTextField.text, let description = descriptionTextField.text, let assignedBy = viewModel.user?.userCode {
                let create = await self.viewModel.createTask(title: title, description: description, statusId: 1, assignedTo: assignTo, assignedBy: assignedBy)
                if create {
                    self.showToast(message: "Tarea actualizada correctamente. ", seconds: 3.0)
                }
            } else {
                self.showToast(message: "Alguno de los campos no esta cargando correctamente.", seconds: 3.0)
            }
        }
    }
    
    @IBAction func UsersListButtonAction(_ sender: Any) {
    }
    
    @IBAction func AssignToMeButtonAction(_ sender: Any) {
    }
    
}
