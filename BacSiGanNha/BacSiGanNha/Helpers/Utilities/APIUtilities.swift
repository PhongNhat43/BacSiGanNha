//
//  APIUtilities.swift
//  BacSiGanNha
//
//  Created by devsenior on 21/08/2023.
//

import Foundation
import Alamofire

protocol JsonInitIbject: NSObject {
    init(json: [String: Any])
}

final class APIUtilities {
    static let domanin = "https://gist.githubusercontent.com"
    static let responseDataKey = "data"
    static let responseCodeKey = "code"
    static let responseMessageKey = "message"
    
    static func requestHomePatientFeed(completionHandler: (Data)) {
        
    }
}


extension APIUtilities {
    enum APIError: Error {
        case resposeFormatError
        case serverError(Int?, String?)
        case unowned(Error)
    }
}
