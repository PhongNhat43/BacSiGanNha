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
 
    }
    
 
    // MARK: - configure
    func configure(data: Intro) {
        introImageView.image = UIImage(named: data.image)
        introTitleLabel.text = data.title
        introDescriptionLabel.text = data.description
    }
        
    
     func heightOfLabel(text: String, font: UIFont, maxWidth: CGFloat, lines: Int = 0) -> CGFloat {
            let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: maxWidth, height: CGFloat.greatestFiniteMagnitude))
            label.numberOfLines = lines
            label.lineBreakMode = NSLineBreakMode.byWordWrapping
            label.text = text
            label.font = font
            label.sizeToFit()
            return label.frame.height
        }

}

extension IntroImageCollectionViewCell {
    func calculateCellHeight() -> CGFloat {
        let titleHeight = heightOfLabel(text: introTitleLabel.text!, font: introTitleLabel.font, maxWidth: 339, lines: 2)
        let introHeight = heightOfLabel(text: introDescriptionLabel.text!, font: introDescriptionLabel.font, maxWidth: 339, lines: 2)
        let additionalHeight: CGFloat = 466
        let totalHeight = titleHeight + introHeight + additionalHeight
        return totalHeight
    }
}
