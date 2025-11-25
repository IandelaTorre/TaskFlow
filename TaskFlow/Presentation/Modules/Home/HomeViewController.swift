//
//  HomeViewController.swift
//  TaskFlow
//
//  Created by Ian Axel Perez de la Torre on 18/11/25.
//

import UIKit

class HomeViewController: UIViewController {
    
    var viewModel: HomeViewModel!
    var onLogout: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func LogoutButtonAction(_ sender: Any) {
        onLogout?()
    }
}
