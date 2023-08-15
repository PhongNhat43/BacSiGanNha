//
//  NewsCollectionViewCell.swift
//  BacSiGanNha
//
//  Created by devsenior on 08/08/2023.
//

import UIKit
import Kingfisher

class NewsCollectionViewCell: UICollectionViewCell {
    
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
  
        newsTitleLabel.textColor = UIColor(red: 0.094, green: 0.098, blue: 0.122, alpha: 1)
        newsTitleLabel.font = UIFont(name: "NunitoSans-Bold", size: 15) ?? UIFont.boldSystemFont(ofSize: 15)
        newsTitleLabel.numberOfLines = 3
        newsTitleLabel.lineBreakMode = .byWordWrapping
        
        newshHotSale.numberOfLines = 1
        newshHotSale.text = "Ưu đãi hot"
        newshHotSale.textColor = UIColor(red: 0.173, green: 0.525, blue: 0.404, alpha: 1)
        newshHotSale.font = UIFont(name: "NunitoSans-Bold", size: 13) ?? UIFont.boldSystemFont(ofSize: 13)
    }
    
    override func layoutSubviews() {
           super.layoutSubviews()
           layer.shadowPath = UIBezierPath(
               roundedRect: bounds,
               cornerRadius: cornerRadius
           ).cgPath
    }

    func calculateLabelHeight(label: UILabel) -> CGFloat {
        let width = label.frame.size.width
        let size = CGSize(width: width, height: .greatestFiniteMagnitude)
        let result = label.sizeThatFits(size)
        return result.height
    }


    func configure(data: ArticleList) {
        newsTitleLabel.text = data.title
        if let imageUrl = URL(string: data.picture) {
            newsImageView.kf.setImage(with: imageUrl, placeholder: nil, options: nil, completionHandler: { result in
                switch result {
                case .success(let value):
                    print("Image downloaded: \(value.source.url?.absoluteString ?? "")")
                case .failure(let error):
                    print("Image download failed: \(error.localizedDescription)")
                    self.newsImageView.image = UIImage(named: "placeholder")
                }
            })
        }
    }
}
extension NewsCollectionViewCell {
    func calculateCellHeight() -> CGFloat {
        let titleHeight = calculateLabelHeight(label: newsTitleLabel)
        let hotSaleHeight = calculateLabelHeight(label: newshHotSale)
        let additionalHeight: CGFloat = 173
        let totalHeight = titleHeight + hotSaleHeight + additionalHeight
        return totalHeight
    }
}


