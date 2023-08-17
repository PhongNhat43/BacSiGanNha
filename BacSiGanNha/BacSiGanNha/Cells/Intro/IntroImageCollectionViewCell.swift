//
//  IntroImageCollectionViewCell.swift
//  BacSiGanNha
//
//  Created by devsenior on 17/08/2023.
//

import UIKit

class IntroImageCollectionViewCell: UICollectionViewCell {
    
    static let indentifier = "IntroImageCollectionViewCell"
    
    static func nib() -> UINib {
       return UINib(nibName: "IntroImageCollectionViewCell", bundle: nil)
    }

    // MARK: - Outlet
    @IBOutlet private weak var introImageView: UIImageView!
    @IBOutlet private weak var introTitleLabel: UILabel!
    @IBOutlet private weak var introDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupUI() {
        //Thiết lập introTitleLabel
        introTitleLabel.textColor = UIColor(red: 0.141, green: 0.165, blue: 0.38, alpha: 1)
        introTitleLabel.font = UIFont(name: "NunitoSans-Bold", size: 24)
        introTitleLabel.lineBreakMode = .byWordWrapping
        introTitleLabel.numberOfLines = 0
        introTitleLabel.textAlignment = .center
        
    }
    
    // MARK: - configure
    func configure(data: Intro) {
        introImageView.image = UIImage(named: data.image)
            
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

extension IntroImageCollectionViewCell {
    func calculateCellHeight() -> CGFloat {
        let titleHeight = calculateLabelHeight(label: introTitleLabel)
        let introHeight = calculateLabelHeight(label: introDescriptionLabel)
        let additionalHeight: CGFloat = 427
        let totalHeight = titleHeight + introHeight + additionalHeight
        return totalHeight
    }
}
