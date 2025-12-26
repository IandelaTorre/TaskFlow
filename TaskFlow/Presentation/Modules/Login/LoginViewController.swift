//
//  ViewController.swift
//  TaskFlow
//
//  Created by Ian Axel Perez de la Torre on 17/11/25.
//

import UIKit
import Combine

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var viewModel: LoginViewModel!
    var onLoginSuccess: (() -> Void)?
    
    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
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
                print("ViewController (errorMessage): \(error ?? "")")
                if error != nil { self?.errorMessageLabel.text = error }
            }
            .store(in: &cancellables)
    }


    @IBAction func LoginButtonAction(_ sender: Any) {
        if usernameTextField.text == "" && passwordTextField.text == "" {
            errorMessageLabel.text = "Please set a password or username"
            return
        }
        Task { @MainActor in
            let login = await viewModel.login(username: usernameTextField.text!, password: passwordTextField.text!)
            print("ViewController (loginStatus): \(login)")
            if login { onLoginSuccess?() }
        }
    }
}

