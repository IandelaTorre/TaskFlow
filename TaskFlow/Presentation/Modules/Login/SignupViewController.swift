//
//  SignupViewController.swift
//  TaskFlow
//
//  Created by Ian Axel Perez de la Torre on 28/12/25.
//

import UIKit
import Combine

class SignupViewController: UIViewController {
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    //SignupView
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordLogupTextField: UITextField!
    
    var viewModel: LoginViewModel!
    private var cancellables = Set<AnyCancellable>()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    private func bind() {
            print("DEBUG viewModel (SignupVC) is nil? ->", viewModel == nil)
                print("DEBUG loadingIndicator (SignupVC) is nil? ->", loadingIndicator == nil)
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
        print("\(nameTextField.text ?? "falto name") \(lastNameTextField.text ?? "falto ap) \(emailTextField.text ?? "falto email") \(passwordLogupTextField.text ?? "falto pass")")")
        Task { @MainActor in
            let signup = await viewModel.signup(name: nameTextField.text ?? "", lastName: lastNameTextField?.text ?? "", email: emailTextField?.text ?? "", password: passwordLogupTextField?.text ?? "")
            print("SignupViewController (signupStatus): \(signup)")
            if signup { print("Usuario creado con éxito! ") }
        }
    }

}
