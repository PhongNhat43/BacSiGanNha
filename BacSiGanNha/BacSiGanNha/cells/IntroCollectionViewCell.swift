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
        introTitleLabel.text = data.title
        introDescriptionLabel.text = data.description
    }
}
