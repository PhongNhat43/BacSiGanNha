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
  
        newsTitleLabel.textColor = UIColor(red: 0.094, green: 0.098, blue: 0.122, alpha: 1)
        newsTitleLabel.font = UIFont(name: "NunitoSans-Bold", size: 15) ?? UIFont.boldSystemFont(ofSize: 15)
        newsTitleLabel.numberOfLines = 3
        newsTitleLabel.lineBreakMode = .byWordWrapping

        newshHotSale.numberOfLines = 1
        newshHotSale.text = "Ưu đãi hot"
        newshHotSale.textColor = UIColor(red: 0.173, green: 0.525, blue: 0.404, alpha: 1)
        newshHotSale.font = UIFont(name: "NunitoSans-Bold", size: 13) ?? UIFont.boldSystemFont(ofSize: 13)
        newshHotSale.lineBreakMode = .byWordWrapping
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
    
    func heightOfLabel(text: String, font: UIFont, maxWidth: CGFloat, lines: Int = 0) -> CGFloat {
           let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: maxWidth, height: CGFloat.greatestFiniteMagnitude))
           label.numberOfLines = lines
           label.lineBreakMode = NSLineBreakMode.byWordWrapping
           label.text = text
           label.font = font
           label.sizeToFit()
           return label.frame.height
       }
    
    func calculateMaxLabelHeight(articles: [ArticleList]) -> CGFloat {
        var maxHeight: CGFloat = 0
        for article in articles {
            let label = UILabel()
            label.text = article.title
            label.font = newsTitleLabel.font
            label.numberOfLines = newsTitleLabel.numberOfLines
            label.lineBreakMode = newsTitleLabel.lineBreakMode
            let height = calculateLabelHeight(label: label)
            if height > maxHeight {
                maxHeight = height
            }
        }
        return maxHeight
    }

    func configure(data: ArticleList) {
        newsTitleLabel.text = data.title
        if let imageUrl = URL(string: data.picture) {
            let placeholderImage = UIImage(named: "placeholder")
            newsImageView.kf.setImage(with: imageUrl, placeholder: placeholderImage)
        }
    }

}

extension NewsCollectionViewCell {
    func calculateCellHeight(articles: [ArticleList]) -> CGFloat {
        var maxHeight: CGFloat = 0
        for article in articles {
            let label = UILabel()
            label.text = article.title
            label.font = newsTitleLabel.font
            label.numberOfLines = newsTitleLabel.numberOfLines
            label.lineBreakMode = newsTitleLabel.lineBreakMode
            label.frame.size.width = newsTitleLabel.frame.size.width
            label.sizeToFit()
            let height = label.frame.size.height
            if height > maxHeight {
                maxHeight = height
            }
        }
 
        let hotSaleHeight = calculateLabelHeight(label: newshHotSale)
        let additionalHeight: CGFloat = 173
        let totalHeight = maxHeight + hotSaleHeight + additionalHeight
        return totalHeight
    }
}




//extension NewsCollectionViewCell {
//    func calculateCellHeight() -> CGFloat {
//        let titleHeight = calculateLabelHeight(label: newsTitleLabel)
//
//        let hotSaleHeight = calculateLabelHeight(label: newshHotSale)
//
//        let additionalHeight: CGFloat = 173
//        let totalHeight = titleHeight + hotSaleHeight + additionalHeight
//        return totalHeight
//    }
//}

//extension NewsCollectionViewCell {
//    func calculateCellHeight() -> CGFloat {
//        var maxTitleHeight: CGFloat = 0
//        var maxHotSaleHeight: CGFloat = 0
//
//        for cell in cells {
//            let titleHeight = cell.calculateLabelHeight(label: cell.newsTitleLabel)
//            let hotSaleHeight = cell.calculateLabelHeight(label: cell.newshHotSale)
//            
//            if titleHeight > maxTitleHeight {
//                maxTitleHeight = titleHeight
//            }
//            
//            if hotSaleHeight > maxHotSaleHeight {
//                maxHotSaleHeight = hotSaleHeight
//            }
//        }
//       
//        let additionalHeight: CGFloat = 173
//        let totalHeight = maxTitleHeight + maxHotSaleHeight + additionalHeight
//        return totalHeight
//    }
//}



