//
//  NewsCollectionViewCell.swift
//  BacSiGanNha
//
//  Created by devsenior on 08/08/2023.
//

import UIKit
import Kingfisher

class NewsCollectionViewCell: UICollectionViewCell {
    var cells: [NewsCollectionViewCell] = []
    var maxHeight: CGFloat = 0
    var maxCell: NewsCollectionViewCell?
    
    static let indentifier = "NewsCollectionViewCell"
    
    static func nib() -> UINib {
       return UINib(nibName: "NewsCollectionViewCell", bundle: nil)
    }
    
    var cornerRadius: CGFloat = 8.0
   
    @IBOutlet private weak var newscContentView: UIView!
    @IBOutlet private weak var newsImageView: UIImageView!
    @IBOutlet private weak var newsTitleLabel: UILabel!
    @IBOutlet private weak var newsCreatedAtLabel: UILabel!
    @IBOutlet private weak var newshHotSale: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    func setupUI() {
        contentView.layer.cornerRadius = cornerRadius
        contentView.layer.masksToBounds = true
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
        layer.shadowRadius = 5.0
        layer.shadowOpacity = 1.0
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 5)
    }
    
    override func layoutSubviews() {
           super.layoutSubviews()
           layer.shadowPath = UIBezierPath(
               roundedRect: bounds,
               cornerRadius: cornerRadius
           ).cgPath
    }

    func configure(data: ArticleList) {
        newsTitleLabel.text = data.title
        if let imageUrl = URL(string: data.picture) {
            let placeholderImage = UIImage(named: "placeholder")
            newsImageView.kf.setImage(with: imageUrl, placeholder: placeholderImage)
        }
    }
    
 
}


  




