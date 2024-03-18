//
//  ContentTableViewCell.swift
//  SpaceXAPI
//
//  Created by Ronald on 16/03/24.
//

import Foundation
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
        applyAccessibility()
    }
    
    private func applyAccessibility() {
        missionTitle.isAccessibilityElement = true
        missionTitle.accessibilityHint = "was the mission name"
        
        dateLabel.isAccessibilityElement = true
        dateLabel.accessibilityHint = "was date and time of the launch"

        rocketNameType.isAccessibilityElement = true
        rocketNameType.accessibilityHint = "was the name and type of the rocket"

        days.isAccessibilityElement = true
        days.accessibilityHint = "days since it was launched"
        
        rocketImage.isAccessibilityElement = true
    }
    
    // MARK: - Configuration
    func appearSmoothly() {
        contentView.alpha = 0
        
        UIView.animate(withDuration: 0.6) {
            self.contentView.alpha = 1
        }
    }
    
    func configure(with launches: Launch) {
        missionTitle.text = launches.missionName
        dateLabel.text = try? setUTCtoString(launches.launchDateUTC)
        rocketNameType.text = "\(launches.rocketModel.rocketName) / \(launches.rocketModel.rocketType)"

        let daysSince = calculateDaysBetweenToday(and: launches.launchDateUTC)
        days.text = "\(daysSince)"
    }
    
    // MARK: - Public Methods
    func setUTCtoString(_ UTCString: String) throws -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        formatter.calendar = Calendar(identifier: .iso8601)
        guard let localDate = formatter.date(from: UTCString) else {
            throw DateError.badDate
        }
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.amSymbol = "am"
        formatter.pmSymbol = "pm"
        formatter.dateFormat = "dd MMMM yyyy 'at' hh:mm"
        let date = formatter.string(from: localDate)
        
        return date
    }
    
    func calculateDaysBetweenToday(and startDate: String ) -> Int {
        let calendar = Calendar.current
        let currentDate = Date()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        formatter.calendar = Calendar(identifier: .iso8601)
        guard let localDate = formatter.date(from: startDate) else { return DateUtil.dateNotFound.rawValue }
        
        guard let daysSince = calendar.dateComponents([.day],
                                                      from: calendar.startOfDay(for: localDate),
                                                      to: calendar.startOfDay(for: currentDate)).day else {
            return DateUtil.dateNotFound.rawValue
        }
        return daysSince
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

// MARK: - Error Handler
enum DateError: Error {
    case badDate
}

enum DateUtil: Int, Error {
    case dateNotFound = 0
}
