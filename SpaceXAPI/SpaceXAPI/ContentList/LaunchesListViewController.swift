//
//  LaunchListTableViewController.swift
//  SpaceXAPI
//
//  Created by Ronald on 16/03/24.
//

import UIKit
import Alamofire

class LaunchListTableViewController: UITableViewController {

    // MARK: - Attributes
    private let viewModel = LaunchesListViewModel()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
        setupViewModel()
        setUpRefreshControl()
    }

    // MARK: - Configuration
    private func setUpTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupViewModel() {
        viewModel.delegate = self
        viewModel.fetchLaunches()
        viewModel.fetchRockets()
    }
        
    private func setUpRefreshControl() {
        self.refreshControl?.addTarget(self, action: #selector(handleRefresh), for: UIControl.Event.valueChanged)
        
    }
    
    // MARK: - Private Methods
    @objc private func handleRefresh() {
        viewModel.fetchLaunches()
        viewModel.fetchRockets()
    }

}
// MARK: - UITableViewDelegate
extension LaunchListTableViewController: LaunchesViewModelDelegate {
    func didLoadEvents() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
        // In case the list was updated by pull-refresh
        // refreshControl?.endRefreshing()
    }
    
    // TO-DO
    func showErrorAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Recarregar", style: UIAlertAction.Style.default) {
            (alert: UIAlertAction!) in
            
            self.viewModel.fetchLaunches()
            self.viewModel.fetchRockets()
        })
        self.present(alert, animated: true, completion: nil)
    }
    
}

// MARK: - UITableViewDataSource
extension LaunchListTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.allLauches.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let launches = viewModel.allLauches[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContentTableViewCell.identifier) as? ContentTableViewCell else { return UITableViewCell() }
        

        cell.selectionStyle = .none
        cell.configure(with: launches)
        
        return cell
        
    }
}
