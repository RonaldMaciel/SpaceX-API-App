//
//  String+Extension.swift
//  SpaceXAPI
//
//  Created by Ronald on 16/03/24.
//

import Foundation

extension String {
    
    static let empty = ""
    
    func containsIgnoringCase(_ substring: String) -> Bool {
        return self.lowercased().contains(substring.lowercased())
    }
}
