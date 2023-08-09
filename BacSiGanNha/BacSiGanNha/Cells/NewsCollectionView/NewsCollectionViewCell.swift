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
//        newscContentView.layer.cornerRadius = 8
//        newscContentView.layer.borderWidth = 0.0
//
//        layer.shadowColor = UIColor.red.cgColor
//        layer.shadowOffset = CGSize(width: 0, height: 4)
//        layer.shadowRadius = 20
//        layer.shadowOpacity = 1.0
//        layer.masksToBounds = false
////        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: MainView.layer.cornerRadius).cgPath
//        let shadowRect = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height - 10)
//        layer.shadowPath = UIBezierPath(roundedRect: shadowRect, cornerRadius: newscContentView.layer.cornerRadius).cgPath
//        newscContentView.layer.masksToBounds = true
        

        
        // Apply rounded corners to contentView
              contentView.layer.cornerRadius = cornerRadius
              contentView.layer.masksToBounds = true

              // Set masks to bounds to false to avoid the shadow
              // from being clipped to the corner radius
              layer.cornerRadius = cornerRadius
              layer.masksToBounds = false

              // Apply a shadow
              layer.shadowRadius = 5.0
        layer.shadowOpacity = 1.0
              layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
//        layer.shadowColor = UIColor.red.cgColor
              layer.shadowOffset = CGSize(width: 0, height: 5)
        
      
      
    }
    
    override func layoutSubviews() {
           super.layoutSubviews()

           // Improve scrolling performance with an explicit shadowPath
           layer.shadowPath = UIBezierPath(
               roundedRect: bounds,
               cornerRadius: cornerRadius
           ).cgPath
       }
    
 
    
    func configure(data: ArticleList) {
        let attributesHotSale: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor(red: 0.173, green: 0.525, blue: 0.404, alpha: 1)
            ]
        let attributesCreateAt: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor(red: 0.588, green: 0.608, blue: 0.671, alpha: 1)
            ]

        newshHotSale.attributedText = NSMutableAttributedString(string: "Ưu đãi hot", attributes: attributesHotSale)
        newsTitleLabel.text = data.title
        newsCreatedAtLabel.attributedText = NSMutableAttributedString(string: data.createdAt, attributes: attributesCreateAt)
        
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

//extension UIView {
//
//    func addShadow(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {
//        layer.masksToBounds = false
//        layer.shadowOffset = offset
//        layer.shadowColor = color.cgColor
//        layer.shadowRadius = radius
//        layer.shadowOpacity = opacity
//
//        let backgroundCGColor = backgroundColor?.cgColor
//        backgroundColor = nil
//        layer.backgroundColor =  backgroundCGColor
//    }
//}
