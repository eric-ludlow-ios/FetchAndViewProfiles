//
//  Calendar+FVP.swift
//  FetchAndViewProfiles
//
//  Created by Eric Ludlow on 4/6/18.
//  Copyright © 2018 EricLudlow. All rights reserved.
//

import UIKit

extension Calendar {
    static func age(from dateString: String) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = dateFormatter.date(from: dateString) else { return 0 }
        
        let calendar = Calendar(identifier: .gregorian)
        let components: Set<Calendar.Component> = [.year, .month]
        let birthdayComponents = calendar.dateComponents(components, from: date)
        let todayComponents = calendar.dateComponents(components, from: Date())
        
        guard let thisYear = todayComponents.year, let birthYear = birthdayComponents.year, let thisMonth = todayComponents.month, let birthMonth = birthdayComponents.month else { return 0 }
        
        var years = thisYear - birthYear
        if thisMonth < birthMonth {
            years -= 1
        }
        return years
    }
}
