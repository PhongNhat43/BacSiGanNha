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
    
    static func calculateDoctorCellHeight(doctors: [DoctorList], nameFont: UIFont, titleFont: UIFont, rateFont: UIFont, nameWidth: CGFloat, titleWidth: CGFloat, rateWidth: CGFloat) -> CGFloat {
        var maxNameHeight: CGFloat = 0
        var maxTitleHeight: CGFloat = 0
        var maxRateHeight: CGFloat = 0
        for doctor in doctors {
            let nameHeight = UILabel.calculateHeight(text: "Dr. \(doctor.name)", font: nameFont, width: nameWidth)
            if nameHeight > maxNameHeight {
                maxNameHeight = nameHeight
            }

            let titleHeight = UILabel.calculateHeight(text: doctor.majorsName, font: titleFont, width: titleWidth)
            if titleHeight > maxTitleHeight {
                maxTitleHeight = titleHeight
            }
            
            let rateText = "\(doctor.ratioStar) (\(doctor.numberOfReviews))"
            let rateHeight = UILabel.calculateHeight(text: rateText, font: rateFont, width: rateWidth)
            if rateHeight > maxRateHeight {
                maxRateHeight = rateHeight
            }
        }
        let additionalHeight: CGFloat = 145
        let totalHeight = maxNameHeight + maxTitleHeight + maxRateHeight + additionalHeight
        return totalHeight
    }
    
    static func calculateIntroCellHeight(intros: [Intro], titleFont: UIFont, descriptionFont: UIFont, titleWidth: CGFloat, descriptionWidth: CGFloat) -> CGFloat {
        var maxTitleHeight: CGFloat = 0
        var maxDescriptionHeight: CGFloat = 0
        for intro in intros {
            let titleHeight = UILabel.calculateHeight(text: intro.title, font: titleFont, width: titleWidth)
            if titleHeight > maxTitleHeight {
                maxTitleHeight = titleHeight
            }
            let descriptionHeight = UILabel.calculateHeight(text: intro.description, font: descriptionFont, width: descriptionWidth)
            if descriptionHeight > maxDescriptionHeight {
                maxDescriptionHeight = descriptionHeight
            }
        }
        let screenWidth = UIScreen.main.bounds.width
        var additionalHeight: CGFloat = 0
        switch screenWidth {
        case ..<376:
            additionalHeight = 397
        case 376..<415:
            additionalHeight = 466
        case 415..<429:
            additionalHeight = 480
        default:
            additionalHeight = 490
        }
        let totalHeight = maxTitleHeight + maxDescriptionHeight + additionalHeight
        return totalHeight
    }


}






