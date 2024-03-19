//
//  LaunchesViewModel.swift
//  SpaceXAPI
//
//  Created by Ronald on 16/03/24.
//

import Foundation

// MARK: - ProtocolDelegate
protocol LaunchesViewModelDelegate: AnyObject {
    func didLoadEvents()
    func showErrorAlert(title: String, message: String)
}

class LaunchesListViewModel {
    // MARK: - Attributes
    weak var delegate: LaunchesViewModelDelegate?
    var showldDisplaySearch: Bool = false
    var allLauches: [Launch] = []
    var allRocketImages: [String] = []
    var filter: String?
    let service = Service()
    
    // MARK: - Public Methods
    public func fetchLaunches() {
        service.fetchLaunches { apiData in
            if apiData.isEmpty {
                self.delegate?.showErrorAlert(title: "Erro", 
                                              message: "Não foi possível carregar os lançamentos espaciais.")
            } else {
                self.allLauches = apiData
                
                for launch in self.allLauches {
                    if let rocketImage = launch.links.flickr_images {
                        if !(rocketImage.isEmpty) {
                            self.allRocketImages.append(contentsOf: rocketImage)
                        }
                    }
                }
            }
            self.delegate?.didLoadEvents()
        }
    }
}
