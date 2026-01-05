//
//  SignupViewController.swift
//  TaskFlow
//
//  Created by Ian Axel Perez de la Torre on 28/12/25.
//

import UIKit
import Combine

class SignupViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    //SignupView
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordLogupTextField: UITextField!
    
    var onSuccess: (() -> Void)?
    
    var viewModel: LoginViewModel!
    private var cancellables = Set<AnyCancellable>()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        nameTextField.delegate = self
        lastNameTextField.delegate = self
        emailTextField.delegate = self
        passwordLogupTextField.delegate = self
    }
    
    private func bind() {
        loadingIndicator?.hidesWhenStopped = true
        
        viewModel.$isLoading
            .receive(on: RunLoop.main)
            .sink { [weak self] loading in
                guard let indicator = self?.loadingIndicator else { return }
                if loading { indicator.startAnimating() }
                else { indicator.stopAnimating() }
            }
            .store(in: &cancellables)
        
        viewModel.$errorMessage
            .receive(on: RunLoop.main)
            .sink { [weak self] error in
                print("SignupViewController (errorMessage): \(error ?? "")")
                if error != nil { self?.errorMessageLabel?.text = error }
            }
            .store(in: &cancellables)
    }

    @IBAction func SignupButtonAction(_ sender: Any) {
        if nameTextField?.text == "" || lastNameTextField?.text == "" || emailTextField?.text == "" || passwordLogupTextField?.text == "" {
            errorMessageLabel?.text = "All fields are required. "
            return
        }
        print("\(nameTextField.text ?? "falto name") \(lastNameTextField.text ?? "falto ap") \(emailTextField.text ?? "falto email") \(passwordLogupTextField.text ?? "falto pass")")
        Task { @MainActor in
            let signup = await viewModel.signup(name: nameTextField.text ?? "", lastName: lastNameTextField?.text ?? "", email: emailTextField?.text ?? "", password: passwordLogupTextField?.text ?? "")
            print("SignupViewController (signupStatus): \(signup)")
            if signup {
                self.showToast(message: "¡Cuenta creada! Por favor inicia sesión", seconds: 3.0)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.onSuccess?()
                }
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameTextField:
            lastNameTextField.becomeFirstResponder()
        case lastNameTextField:
            emailTextField.becomeFirstResponder()
        case emailTextField:
            passwordLogupTextField.becomeFirstResponder()
        case passwordLogupTextField:
            passwordLogupTextField.resignFirstResponder()
            SignupButtonAction(self)
        default:
            textField.resignFirstResponder()
        }
        return true
    }

}
