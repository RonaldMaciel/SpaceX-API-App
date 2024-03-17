//
//  LaunchesViewModel.swift
//  SpaceXAPI
//
//  Created by Ronald on 16/03/24.
//

import UIKit

protocol LaunchesViewModelDelegate: class {
    func didLoadEvents()
}

class LaunchesViewModel {
    
    // MARK: - Attributes
    weak var delegate: LaunchesViewModelDelegate?
    
}
