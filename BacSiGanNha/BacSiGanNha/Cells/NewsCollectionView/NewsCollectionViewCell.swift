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
   
    @IBOutlet weak var newscContentView: UIView!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsCreatedAtLabel: UILabel!
    @IBOutlet weak var newshHotSale: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
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

    private func calculateLabelHeight(label: UILabel, width: CGFloat) -> CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.text = label.text
        label.font = label.font
        label.numberOfLines = label.numberOfLines
        label.lineBreakMode = label.lineBreakMode
        label.sizeToFit()
        return label.frame.height
    }
    /// calculateCellHeight
    /// - Parameter width: with of title label of cell
    /// - Returns: height of cell

    func configure(data: ArticleList) {
            newsTitleLabel.textColor = UIColor(red: 0.094, green: 0.098, blue: 0.122, alpha: 1)
            newsTitleLabel.font = UIFont(name: "NunitoSans-Bold", size: 15) ?? UIFont.boldSystemFont(ofSize: 15)
            newsTitleLabel.numberOfLines = 2
            newsTitleLabel.lineBreakMode = .byWordWrapping
            newsTitleLabel.text = data.title

          newshHotSale.text = "Ưu đãi hot"
          newshHotSale.textColor = UIColor(red: 0.173, green: 0.525, blue: 0.404, alpha: 1)
          newshHotSale.font = UIFont(name: "NunitoSans-Bold", size: 13) ?? UIFont.boldSystemFont(ofSize: 13)
          newshHotSale.numberOfLines = 1
        
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
    func calculateCellHeight(titleLabel: UILabel, hotSaleLabel: UILabel, width: CGFloat) ->  CGFloat {
        let titleHeight = calculateLabelHeight(label: titleLabel, width: width)
        let hotSaleHeight = calculateLabelHeight(label: hotSaleLabel, width: width)
        let totalHeight = titleHeight + hotSaleHeight + 163
        return totalHeight
    }
}
