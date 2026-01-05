//
//  ViewController.swift
//  TaskFlow
//
//  Created by Ian Axel Perez de la Torre on 17/11/25.
//

import UIKit
import Combine

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    //LoginView
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var viewModel: LoginViewModel!
    var onLoginSuccess: (() -> Void)?
    var onSignupTapped: (() -> Void)?
    var onRecoveryTapped: (() -> Void)?
    
    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        usernameTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    private func bind() {
        loadingIndicator.hidesWhenStopped = true
        
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
                print("ViewController (errorMessage): \(error ?? "")")
                if error != nil { self?.errorMessageLabel?.text = error }
            }
            .store(in: &cancellables)
    }

    @IBAction func LoginButtonAction(_ sender: Any) {
        if usernameTextField.text == "" && passwordTextField.text == "" {
            errorMessageLabel.text = "Please set a password or username"
            return
        }
        Task { @MainActor in
            let login = await viewModel.login(username: usernameTextField.text ?? "", password: passwordTextField.text ?? "")
            print("ViewController (loginStatus): \(login)")
            if login {
                view.endEditing(true)
                self.showToast(message: "Login exitoso, felicidades!", seconds: 3.0)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.onLoginSuccess?()
                }
            }
        }
    }
    
    @IBAction func RecoveryPasswordButtonAction(_ sender: Any) {
        onRecoveryTapped?()
        
    }
    
    @IBAction func GoToSignupAction(_ sender: Any) {
        onSignupTapped?()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case usernameTextField:
            passwordTextField?.becomeFirstResponder()
        case passwordTextField:
            passwordTextField?.resignFirstResponder()
            LoginButtonAction(self)
        default:
            textField.resignFirstResponder()
        }
        return true
    }
        
}

