//
//  Service.swift
//  SpaceXAPI
//
//  Created by Ronald on 16/03/24.
//

import Alamofire
import Foundation

class Service {
    // MARK: - Singleton
    static let shared = Service()

    func fetchLaunches(completion: @escaping (_ apiData: [Launch]) -> Void) {
        let url = "https://api.spacexdata.com/v3/launches"
        AF.request(url, method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: nil,
                   interceptor: nil)
        .response { response in
            switch response.result {
            case .success(let data):
                do {
                    let jsonData = try JSONDecoder().decode([Launch].self, from: data!)
                    completion(jsonData)
                } catch {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }}
    }
}
