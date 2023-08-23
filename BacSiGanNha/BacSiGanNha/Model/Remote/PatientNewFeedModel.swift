//
//  PatientNewFeedModel.swift
//  BacSiGanNha
//
//  Created by devsenior on 21/08/2023.
//

import Foundation
import Alamofire


//class PatientNewFeedModel: NSObject, JsonInitIbject {
//    required init(json: [String : Any]) {
//        <#code#>
//    }
//    
//    
//    var articleList     : [ArticleList]?
//    var doctorList     : [DoctorList]?
//    var promotionList     : [PromotionList]?
//    
//    convenience init(articleList: [ArticleList]?,
//                     doctorList: [DoctorList]?,
//                     promotionList: [PromotionList]?) {
//        
//        self.init()
//        self.articleList = articleList
//        self.doctorList = doctorList
//        self.promotionList = promotionList
//    }
    
    
//    required convenience init(json: [String: Any]) {
//        self.init()
//
//        if let wrapValue = json["articleList"] as? [[String: Any]]{
//            let jsonValue = wrapValue.map({ ArticleList(json: $0)})
//            self.articleList = jsonValue
//        }
//        if let wrapValue = json["doctorList"] as? [[String: Any]]{
//            let jsonValue = wrapValue.map({ PatientDoctorListModel(json: $0)})
//            self.doctorList = jsonValue
//        }
//        if let wrapValue = json["promotionList"] as? [[String: Any]]{
//            let jsonValue = wrapValue.map({ PatientPromotionListModel(json: $0)})
//            self.promotionList = jsonValue
//        }
//    }

