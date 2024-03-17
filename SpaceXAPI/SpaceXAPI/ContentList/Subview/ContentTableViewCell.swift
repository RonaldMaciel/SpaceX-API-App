//
//  ContentTableViewCell.swift
//  SpaceXAPI
//
//  Created by Ronald on 16/03/24.
//

import UIKit

class ContentTableViewCell: UITableViewCell {

    // MARK: - Constants
    public static let identifier: String = "LaunchTableViewCell"
    
    @IBOutlet weak var missionTitle: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var rocketNameType: UILabel!
    @IBOutlet weak var days: UILabel!
    @IBOutlet weak var rocketImage: UIImageView!
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        appearSmoothly()
    }
    
    // MARK: - Configuration
    func appearSmoothly() {
        contentView.alpha = 0
        
        UIView.animate(withDuration: 0.4) {
            self.contentView.alpha = 1
        }
    }
     
    func configure(with launches: Launch) {
        missionTitle.text = launches.missionName
        dateLabel.text = try? setUTCtoString(launches.launchDateUTC)
        rocketNameType.text = "\(launches.rocketModel.rocketName) / \(launches.rocketModel.rocketType)"
        days.text = " 1"
//        rocketImage
    }
    
    func setUTCtoString(_ UTCString: String) throws -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        formatter.calendar = Calendar(identifier: .iso8601)
        guard let localDate = formatter.date(from: UTCString) else {
            throw DateError.badDate
        }
        print(localDate)
        
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.amSymbol = "am"
        formatter.pmSymbol = "pm"
        formatter.dateFormat = "dd MMMM yyyy 'at' hh:mm"
        let date = formatter.string(from: localDate)
        
        return date
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

enum DateError: Error {
    case badDate
    case dateNotFound
}
