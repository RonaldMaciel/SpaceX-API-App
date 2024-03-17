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
    }

    // MARK: - Setup & Configuration
    private func setUpTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundView = UIImageView(image: UIImage(named: "background"))
    }
    
    private func setupViewModel() {
        viewModel.delegate = self
        viewModel.fetchLaunches()
    }

}
// MARK: - UITableViewDelegate
extension LaunchListTableViewController: LaunchesViewModelDelegate {
    func didLoadEvents() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
        // In case the list was updated by pull-refresh
        refreshControl?.endRefreshing()
    }
    
    // MARK: - Error Alert
    func showErrorAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Recarregar", style: UIAlertAction.Style.default) {
            (alert: UIAlertAction!) in
            self.viewModel.fetchLaunches()
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
        
        let launch = viewModel.allLauches[indexPath.row]
        let image_num = Int.random(in: 0..<viewModel.allRocketImages.count)
        let rocketImage = viewModel.allRocketImages[image_num]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContentTableViewCell.identifier) as? ContentTableViewCell else { return UITableViewCell() }

        cell.selectionStyle = .none
        
        if let url = URL(string: rocketImage) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            cell.rocketImage.image = image
                        }
                    }
                }
            }
        }
        
        cell.configure(with: launch)
        return cell
        
    }
}
