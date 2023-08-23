//
//  Date+Extensions.swift
//  BSGN
//
//  Created by Hoang Dinh Huy on 05/10/2021.
//

import Foundation

extension Date {
    func toString(format: String = "dd/MM/YYYY") -> String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = format
        
        return dateFormater.string(from: self)
    }
}
