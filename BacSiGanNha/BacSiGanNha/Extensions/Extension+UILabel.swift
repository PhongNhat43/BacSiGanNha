//
//  ExtensionLoading.swift
//  BacSiGanNha
//
//  Created by devsenior on 10/08/2023.
//

import Foundation
import UIKit

extension UILabel {
    static func calculateHeight(text: String, font: UIFont, width: CGFloat) -> CGFloat {
        let label = UILabel()
        label.text = text
        label.font = font
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.frame.size.width = width
        label.sizeToFit()
        return label.frame.size.height
    }
    
    static func calculateNewsCellHeight(articles: [ArticleList], titleFont: UIFont, hotSaleText: String, hotSaleFont: UIFont, titleWidth: CGFloat, hotSaleWidth: CGFloat) -> CGFloat {
        var maxHeight: CGFloat = 0
        for data in articles {
            let height = UILabel.calculateHeight(text: data.title, font: titleFont, width: titleWidth)
            if height > maxHeight {
                maxHeight = height
            }
        }
        let hotSaleHeight = UILabel.calculateHeight(text: hotSaleText, font: hotSaleFont, width: hotSaleWidth)

        let additionalHeight: CGFloat = 173
        let totalHeight = maxHeight + hotSaleHeight + additionalHeight
        return totalHeight
    }
    
    static func calculatePromotionCellHeight(promotion: [PromotionList], titleFont: UIFont, hotSaleText: String, hotSaleFont: UIFont, titleWidth: CGFloat, hotSaleWidth: CGFloat) -> CGFloat {
        var maxHeight: CGFloat = 0
        for data in promotion {
            let height = UILabel.calculateHeight(text: data.name, font: titleFont, width: titleWidth)
            if height > maxHeight {
                maxHeight = height
            }
        }
        let hotSaleHeight = UILabel.calculateHeight(text: hotSaleText, font: hotSaleFont, width: hotSaleWidth)

        let additionalHeight: CGFloat = 173
        let totalHeight = maxHeight + hotSaleHeight + additionalHeight
        return totalHeight
    }
    
//    static func calculateDoctorCellHeight(doctor: [DoctorList], nameFont: UIFont, titleFont: UIFont, nameWidth: CGFloat, titleWidth: CGFloat) -> CGFloat {
//        var maxNameHeight: CGFloat = 0
//        var maxMajorHeight: CGFloat = 0
//        var maxRateHeight: CGFloat = 0
//        for data in doctor {
//            let nameHeight = UILabel.calculateHeight(text: data.name, font: nameFont, width: nameWidth)
//            if nameHeight > maxNameHeight {
//                maxNameHeight = nameHeight
//            }
//            
//            let majorHeight = UILabel.calculateHeight(text: data.majorsName, font: titleFont, width: titleWidth)
//            if majorHeight > maxMajorHeight {
//                maxMajorHeight = majorHeight
//            }
//            
//            let rateHeight = UILabel.calculateHeight(text: \(data.numberOfReviews), font: titleFont, width: titleWidth)
//            if rateHeight > maxRateHeight {
//                maxRateHeight = rateHeight
//            }
//            
//        }
//
//        let additionalHeight: CGFloat = 145
//        let totalHeight = maxNameHeight + maxMajorHeight + maxRateHeight + additionalHeight
//        return totalHeight
//    }

    
    
  
    
    
    
}






