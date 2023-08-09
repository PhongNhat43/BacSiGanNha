//
//  APIHandler.swift
//  BacSi_App
//
//  Created by devsenior on 20/07/2023.
//

import Foundation
import Alamofire

class APICaller {
    static let sharedInstance = APICaller()
    func fetchingAPIData(handler: @escaping (_ articleData: [ArticleList], _ promotionData: [PromotionList], _ doctorData: [DoctorList]) -> Void) {
        let url = "https://gist.githubusercontent.com/hdhuy179/f967ffb777610529b678f0d5c823352a/raw"
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { response in
            switch response.result {
            case .success(let data):
                do {
                    let jsondata = try JSONDecoder().decode(Response.self, from: data!)
                    handler(jsondata.data.articleList, jsondata.data.promotionList, jsondata.data.doctorList)
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        
        }
    }
}


