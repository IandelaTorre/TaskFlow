//
//  RecoveryPasswordViewController.swift
//  TaskFlow
//
//  Created by Ian Axel Perez de la Torre on 31/12/25.
//

import UIKit
import Combine

class RecoveryPasswordViewController: UIViewController {
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var recoveryCodeTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var reEnterPasswordTextField: UITextField!
    
    var viewModel: LoginViewModel!
    private var cancellables = Set<AnyCancellable>()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        // Do any additional setup after loading the view.
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
    
    
    @IBAction func ChangePasswordButtonAction(_ sender: Any) {
        Task { @MainActor in
            let recovery = await viewModel.recoveryPassword(email: emailTextField.text ?? "", recoveryCode: recoveryCodeTextField.text ?? "", newPassword: passwordTextField.text ?? "")
            if recovery { print("Se recupero correctamente. 😄")}
        }
    }
    
}
