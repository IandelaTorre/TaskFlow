//
//  HomeViewController.swift
//  TaskFlow
//
//  Created by Ian Axel Perez de la Torre on 18/11/25.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    
    @IBOutlet weak var homeNameLabel: UILabel!
    @IBOutlet weak var homeCodeLabel: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tasksCollectionView: UICollectionView!
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    
    
    var viewModel: HomeViewModel!
    var onLogout: (() -> Void)?
    var onTapAddTask: (() -> Void)?
    var onTapDetailTask: ((UserTask) -> Void)?
    
    private var cancellables = Set<AnyCancellable>()
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupRefreshControl()
        bind()
        viewModel.loadUser()
        
    }
    
    private func setupCollectionView() {
        tasksCollectionView.delegate = self
        tasksCollectionView.dataSource = self
        
        
        var config = UICollectionLayoutListConfiguration(appearance: .plain)
        config.showsSeparators = true
        config.backgroundColor = .systemBackground
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        tasksCollectionView.collectionViewLayout = layout
        
        
    }
    
    private func setupRefreshControl() {
        refreshControl.tintColor = .systemBlue
        refreshControl.addTarget(self , action: #selector(didPullToRefresh), for: .valueChanged)
        tasksCollectionView.refreshControl = refreshControl
    }
    
    @objc private func didPullToRefresh() {
        viewModel.refreshData()
    }
    
    private func bind() {
        loadingIndicator.hidesWhenStopped = true
        viewModel.$user
            .receive(on: RunLoop.main)
            .sink { [weak self] user in
                if user != nil {
                    self?.fillData(user: user)
                    self?.viewModel.fetchMyTasks(userUuid: user?.userUuid ?? UUID())
                }
                
            }
            .store(in: &cancellables)
        
        viewModel.$tasks
            .receive(on: RunLoop.main)
            .sink { [weak self] tasks in
                self?.tasksCollectionView.reloadData()
            }
            .store(in: &cancellables)
        
        viewModel.$isLoading
            .receive(on: RunLoop.main)
            .sink { [weak self] loading in
                guard let self = self else { return }
                print("HomeViewController: \(loading)")
                if loading {
                    if !self.refreshControl.isRefreshing {
                        self.loadingIndicator.startAnimating()
                    }
                } else {
                    self.loadingIndicator.stopAnimating()
                    if self.refreshControl.isRefreshing {
                        self.refreshControl.endRefreshing()
                    }
                }
            }
            .store(in: &cancellables)
        
        viewModel.$errorMessage
            .receive(on: RunLoop.main)
            .sink { [weak self] error in
                if error != nil { self?.errorMessageLabel?.text = error }
            }
            .store(in: &cancellables)
        
    }
    
    private func fillData(user: User?) {
        homeNameLabel.text = "\(user?.name ?? "No name") \(user?.lastName ?? "")"
        homeCodeLabel.text = "Tu código: \(user?.userCode ?? "ABC-123")"
    }
    
    @IBAction func LogoutButtonAction(_ sender: Any) {
        onLogout?()
    }
    
    @IBAction func AddTaskButtonAction(_ sender: Any) {
        onTapAddTask?()
    }
    
}



extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.tasks?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TaskCell.identifier, for: indexPath) as? TaskCell, let task = viewModel.tasks?[indexPath.item] else { return UICollectionViewCell() }
        cell.configure(with: task)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        guard let selectedTask = viewModel.tasks?[indexPath.item] else { return }
        onTapDetailTask?(selectedTask)
    }
}
