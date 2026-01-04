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
    @IBOutlet weak var changePasswordButton: UIButton!
    
    var viewModel: LoginViewModel!
    private var cancellables = Set<AnyCancellable>()
    
    var onSuccess: (() -> Void)?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    
    private func bind() {
        loadingIndicator?.hidesWhenStopped = true
        // ---------------------------------------------------------
        // 1. INPUTS (De la Vista al ViewModel)
        // ---------------------------------------------------------
        
        // Conectamos lo que escribes en passwordTextField -> viewModel.password
        passwordTextField.textPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.password, on: viewModel)
            .store(in: &cancellables)
        
        // Conectamos lo que escribes en reEnterTextField -> viewModel.reEnterPassword
        reEnterPasswordTextField.textPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.reEnterPassword, on: viewModel)
            .store(in: &cancellables)

        // ---------------------------------------------------------
        // 2. OUTPUTS (Del ViewModel a la Vista)
        // ---------------------------------------------------------
        
        // a) Controlar el Loading
        viewModel.$isLoading
            .receive(on: RunLoop.main)
            .sink { [weak self] loading in
                if loading { self?.loadingIndicator?.startAnimating() }
                else { self?.loadingIndicator?.stopAnimating() }
                // Opcional: Bloquear inputs mientras carga
                self?.changePasswordButton.isEnabled = !loading
            }
            .store(in: &cancellables)
        
        // b) Mostrar errores
        viewModel.$errorMessage
            .receive(on: RunLoop.main)
            .sink { [weak self] error in
                if let error = error, !error.isEmpty {
                    self?.errorMessageLabel?.text = error
                    self?.errorMessageLabel?.isHidden = false
                } else {
                    self?.errorMessageLabel?.isHidden = true
                }
            }
            .store(in: &cancellables)

        // c) Habilitar/Deshabilitar el botón según la validación
        viewModel.$enabledRecoveryPassButton
            .receive(on: RunLoop.main)
            .sink { [weak self] isEnabled in
                // Si es nil o false, deshabilitamos. Si es true, habilitamos.
                let valid = isEnabled ?? false
                self?.changePasswordButton.isEnabled = valid
                
                // Opcional: Cambiar la opacidad para dar feedback visual
                self?.changePasswordButton.alpha = valid ? 1.0 : 0.5
            }
            .store(in: &cancellables)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func ChangePasswordButtonAction(_ sender: Any) {
        Task { @MainActor in
            let recovery = await viewModel.recoveryPassword(email: emailTextField.text ?? "", recoveryCode: recoveryCodeTextField.text ?? "", newPassword: passwordTextField.text ?? "")
            if recovery {
                self.showToast(message: "¡Contraseña recuperada! Por favor inicia sesión", seconds: 3.0)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.onSuccess?()
                }
            }
        }
    }
    
}

extension UITextField {
    var textPublisher: AnyPublisher<String?, Never> {
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: self)
            .map { ($0.object as? UITextField)?.text }
            .eraseToAnyPublisher()
    }
}
