//
//  SpaceXApp.swift
//  SpaceXAPI
//
//  Created by Ronald on 16/03/24.
//

import UIKit

class SpaceXApp: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

extension SpaceXApp: LaunchesViewModelDelegate {
    func didLoadEvents() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
        // In case the list was updated by a pull-refresh
        refreshControl?.endRefreshing()
    }
    
    
}

extension SpaceXApp {
    
}
