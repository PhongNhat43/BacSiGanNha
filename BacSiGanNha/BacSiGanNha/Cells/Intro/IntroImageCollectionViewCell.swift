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
    @IBOutlet private weak var introTitleLabelTopConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
 
    }
    
    // MARK: - configure
    func configure(data: Intro) {
        introImageView.image = UIImage(named: data.image)
        introTitleLabel.text = data.title
        introDescriptionLabel.text = data.description
        let screenWidth = UIScreen.main.bounds.width
        if screenWidth <= 375 {
            introTitleLabelTopConstraint.constant = 10
            return
        }
        if screenWidth == 414 || screenWidth == 428 {
            introTitleLabelTopConstraint.constant = 40
            return
        }
    }

}


