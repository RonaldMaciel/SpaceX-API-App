//
//  MockLaunchesService.swift
//  SpaceXAPI
//
//  Created by Ronald on 16/03/24.
//

import Foundation

enum NetworkError: Error {
    case noData
    case decodingError
    case wrongEndpoint
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .noData:
            return NSLocalizedString(
                "No data was found in the request.",
                comment: ""
            )
            
        case .decodingError:
            return NSLocalizedString(
                "Data was not retrieved from request due an decoding error.",
                comment: ""
            )
            
        case .wrongEndpoint:
            return NSLocalizedString(
                "URL does not exist.",
                comment: ""
            )
        }
    }
}

protocol NetworkingServiceDelegate {
    func fetchLaunches(url: String, completion: @escaping (Result<[Launch], NetworkError>) -> Void)
}

class MockLaunchesService: NetworkingServiceDelegate {
    func fetchLaunches(url: String, completion: @escaping (Result<[Launch], NetworkError>) -> Void) {
        let requestURL = URL(string: url)!
        let endpoint = requestURL.path
        
        switch endpoint {
        case "/launches":
            guard let jsonData = launches() else {
                completion(.failure(.noData))
                return
            }
            do {
                completion(.success(jsonData))
            } catch {
                completion(.failure(.decodingError))
            }
        default:
            completion(.failure(.wrongEndpoint))
        }
    }

    func launches() -> [Launch]? {
        do {
            guard let fileURL = Bundle.main.url(forResource: "MockJSON", withExtension: "json") else { return nil }
            let data = try Data(contentsOf: fileURL)
            let launch = try JSONDecoder().decode([Launch].self, from: data)
            return launch
        } catch let err {
            print(err.localizedDescription)
            return nil
        }
    }
}


class MockLaunchesListViewModel {
    private let service: NetworkingServiceDelegate
    
    init(service: NetworkingServiceDelegate = MockLaunchesService() ) {
        self.service = service
    }
    
    var allLaunches = [Launch]()
    
    func fetchLaunches() {
        service.fetchLaunches(url: "") { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let launches):
                    self.allLaunches = launches
                 
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
