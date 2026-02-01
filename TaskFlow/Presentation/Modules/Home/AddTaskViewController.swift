//
//  AddTaskViewController.swift
//  TaskFlow
//
//  Created by Ian Axel Perez de la Torre on 05/01/26.
//

import UIKit
import Combine

class AddTaskViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet weak var assignToTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var createTaskButton: UIButton!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var textViewHeightConstraint: NSLayoutConstraint!
    
    var viewModel: HomeViewModel!
    
    private var cancellables: Set<AnyCancellable> = []
    let maxLines: CGFloat = 4
    let minHeight: CGFloat = 40
    var onSuccess: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        viewModel.loadUser()
        setupTextView()
        assignToTextField.delegate = self
        titleTextField.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)

    }
    
    private func setupTextView() {
        messageTextView.delegate = self
        /*messageTextView.layer.cornerRadius = 18
        messageTextView.layer.borderWidth = 1
        messageTextView.layer.borderColor = UIColor.systemGray4.cgColor
        messageTextView.font = UIFont.systemFont(ofSize: 16)
        
        // Importante: padding interno para que el texto no toque los bordes
        messageTextView.textContainerInset = UIEdgeInsets(top: 8, left: 10, bottom: 8, right: 10)*/
        
        // Inicialmente deshabilitamos scroll para que AutoLayout calcule altura
        messageTextView.isScrollEnabled = false
    }

    func textViewDidChange(_ textView: UITextView) {
        adjustTextViewHeight()
    }
    
    private func adjustTextViewHeight() {
        let size = messageTextView.sizeThatFits(CGSize(width: messageTextView.frame.width, height: .infinity))
        
        let lineHeight = messageTextView.font?.lineHeight ?? 20
        
        let maxHeight = (messageTextView.textContainerInset.top + messageTextView.textContainerInset.bottom) + (maxLines * lineHeight)
        
        if size.height >= maxHeight {
            if textViewHeightConstraint.constant != maxHeight {
                textViewHeightConstraint.constant = maxHeight
                messageTextView.isScrollEnabled = true
                UIView.animate(withDuration: 0.2) { self.view.layoutIfNeeded() }
            }
        } else {
            let newHeight = max(minHeight, size.height)
            if textViewHeightConstraint.constant != newHeight {
                textViewHeightConstraint.constant = newHeight
                messageTextView.isScrollEnabled = false
                UIView.animate(withDuration: 0.2) { self.view.layoutIfNeeded() }
            }
        }
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
        viewModel.$errorMessage
            .receive(on: RunLoop.main)
            .sink { [weak self] error in
                if let message = error { self?.showToast(message: message, seconds: 3.0)}
            }
            .store(in: &cancellables)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func CreateTaskButtonAction(_ sender: Any) {
        createTaskButton.isEnabled = false

        defer {
            createTaskButton.isEnabled = true
        }
        
        Task { @MainActor in
            if let assignTo = assignToTextField.text, let title = titleTextField.text, let description = messageTextView.text, let assignedBy = viewModel.user?.userCode {
                let create = await self.viewModel.createTask(title: title, description: description, statusId: 1, assignedTo: assignTo, assignedBy: assignedBy)
                if create {
                    self.showToast(message: "Tarea actualizada correctamente. ", seconds: 3.0)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.onSuccess?()
                    }
                }
            }
        }
    }
    
    @IBAction func UsersListButtonAction(_ sender: Any) {
    }
    
    @IBAction func AssignToMeButtonAction(_ sender: Any) {
        viewModel.loadUser()
        if let currentUser = viewModel.user?.userCode {
            assignToTextField.text = currentUser
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField{
        case assignToTextField:
            titleTextField.becomeFirstResponder()
        case titleTextField:
            titleTextField.resignFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
}
