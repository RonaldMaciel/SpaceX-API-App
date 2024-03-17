// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let spaceX = try? JSONDecoder().decode(SpaceX.self, from: jsonData)

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseSpaceXElement { response in
//     if let spaceXElement = response.result.value {
//       ...
//     }
//   }

import Foundation
import Alamofire

// MARK: - Launches

struct Launch: Codable {
    let missionName: String
    let launchYear: String
    let launchDateUTC: String
    let rocketModel: RocketModel
    let links: Links
    
    struct Links : Codable {
        let mission_patch : String?
        let flickr_images : [String]?
    }

    enum CodingKeys: String, CodingKey {
        case missionName = "mission_name"
        case launchYear = "launch_year"
        case launchDateUTC = "launch_date_utc"
        case rocketModel = "rocket"
        case links = "links"
    }
}

struct RocketModel: Codable {
    let rocketID: String
    let rocketName: String
    let rocketType: String
    
    enum CodingKeys: String, CodingKey {
        case rocketID = "rocket_id"
        case rocketName = "rocket_name"
        case rocketType = "rocket_type"
    }
}

