//
//  LaunchesViewModel.swift
//  SpaceXAPI
//
//  Created by Ronald on 16/03/24.
//

import Foundation

protocol LaunchesViewModelDelegate: AnyObject {
    func didLoadEvents()
    func showErrorAlert(title: String, message: String)
    
}

class LaunchesListViewModel {
    // MARK: - Attributes
    weak var delegate: LaunchesViewModelDelegate?
    var showldDisplaySearch: Bool = false
    var allLauches: [Launch] = []
    var filter: String?
    let service = Service()
    
    // MARK: - Public Methods
    public func fetchLaunches() {
        service.fetchLaunches { apiData in
            if apiData.isEmpty {
                self.delegate?.showErrorAlert(title: "Erro", message: "Não foi possível carregar os lançamentos espaciais.")
            } else {
                self.allLauches = apiData
                print(apiData)
                self.delegate?.didLoadEvents()
            }
        }
    }
}

