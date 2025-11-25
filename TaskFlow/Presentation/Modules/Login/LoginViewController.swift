//
//  ViewController.swift
//  TaskFlow
//
//  Created by Ian Axel Perez de la Torre on 17/11/25.
//

import UIKit

class LoginViewController: UIViewController {
    
    var viewModel: LoginViewModel!
    var onLoginSuccess: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func LoginButtonAction(_ sender: Any) {
        onLoginSuccess?()
    }
}

