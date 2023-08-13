//
//  IntroCollectionViewCell.swift
//  BacSi_App
//
//  Created by devsenior on 18/07/2023.
//

import UIKit

class IntroCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlet
    @IBOutlet weak var introImageView: UIImageView!
    @IBOutlet weak var introTitleLabel: UILabel!
    @IBOutlet weak var introDescriptionLabel: UILabel!
    
    // MARK: - configure
    func configure(data: Intro) {
            introImageView.image = UIImage(named: data.image)
            
            let titleTextColor = UIColor(red: 0.141, green: 0.165, blue: 0.38, alpha: 1)
            let titleFont = UIFont(name: "NunitoSans-Bold", size: 24)
            let titleParagraphStyle = NSMutableParagraphStyle()
            titleParagraphStyle.lineHeightMultiple = 0.98
            titleParagraphStyle.alignment = .center
            
            let titleAttributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: titleTextColor,
                .font: titleFont,
                .paragraphStyle: titleParagraphStyle
            ]
            
            let attributedTitle = NSAttributedString(string: data.title, attributes: titleAttributes)
            introTitleLabel.attributedText = attributedTitle
            introTitleLabel.numberOfLines = 0
            introTitleLabel.lineBreakMode = .byWordWrapping
            
            let descriptionTextColor = UIColor(red: 0.212, green: 0.239, blue: 0.306, alpha: 1)
            let descriptionFont = UIFont(name: "NunitoSans-Regular", size: 14)
            let descriptionParagraphStyle = NSMutableParagraphStyle()
            descriptionParagraphStyle.lineHeightMultiple = 1.05
            descriptionParagraphStyle.alignment = .center
            
            let descriptionAttributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: descriptionTextColor,
                .font: descriptionFont,
                .paragraphStyle: descriptionParagraphStyle
            ]
            
            let attributedDescription = NSAttributedString(string: data.description, attributes: descriptionAttributes)
            introDescriptionLabel.attributedText = attributedDescription
            introDescriptionLabel.numberOfLines = 0
            introDescriptionLabel.lineBreakMode = .byWordWrapping
        }
    
    func calculateLabelHeight(label: UILabel) -> CGFloat {
            let width = label.frame.size.width
            let size = CGSize(width: width, height: .greatestFiniteMagnitude)
            let result = label.sizeThatFits(size)
            return result.height
    }
}

extension IntroCollectionViewCell {
    func calculateCellHeight() -> CGFloat {
        let titleHeight = calculateLabelHeight(label: introTitleLabel)
        let introHeight = calculateLabelHeight(label: introDescriptionLabel)
        let additionalHeight: CGFloat = 427
        let totalHeight = titleHeight + introHeight + additionalHeight
        return totalHeight
    }
}
