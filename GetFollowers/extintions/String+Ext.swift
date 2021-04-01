//
//  String+Ext.swift
//  GetFollowers
//
//  Created by Mohamed Ghazy on 3/28/21.
//  Copyright © 2021 Mohamed Ghazy. All rights reserved.
//

import Foundation

extension String {
    func stringToDate() -> Date? {
        let dateFormatter        = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale     = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone   = .current
        
        return dateFormatter.date(from: self)
    }
    
    func convertToDisplayFormat() -> String {
        guard let date = self.stringToDate() else {return "N/A"}
        return date.convertToYearMonthFormat()
    }
}
