//
//  PromotionCollectionViewCell.swift
//  BacSiGanNha
//
//  Created by devsenior on 09/08/2023.
//

import UIKit

class PromotionCollectionViewCell: UICollectionViewCell {
    
    static let indentifier = "PromotionCollectionViewCell"
    
    static func nib() -> UINib {
       return UINib(nibName: "PromotionCollectionViewCell", bundle: nil)
    }
    
    var cornerRadius: CGFloat = 8.0

    @IBOutlet private weak var promotionMainView: UIView!
    @IBOutlet private weak var promotionImageView: UIImageView!
    @IBOutlet private weak var promotionTitleLabel: UILabel!
    @IBOutlet private weak var promotionCreateAt: UILabel!
    @IBOutlet private weak var hotSaleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
    
    func calculateLabelHeight(label: UILabel) -> CGFloat {
        let width = label.frame.size.width
        let size = CGSize(width: width, height: .greatestFiniteMagnitude)
        let result = label.sizeThatFits(size)
        let maxHeight = label.font.lineHeight * CGFloat(label.numberOfLines)
        return min(result.height, maxHeight)
    }
    
    func configure(dataPromotion: PromotionList) {
        promotionTitleLabel.text = dataPromotion.name
        promotionCreateAt.text = dataPromotion.createdAt
        promotionImageView.setImage(imageUrl: dataPromotion.picture)
    }

}

extension PromotionCollectionViewCell {
    func calculateCellHeight() -> CGFloat {
        let titleHeight = calculateLabelHeight(label: promotionTitleLabel)
        let hotSaleHeight = calculateLabelHeight(label: hotSaleLabel)
        let additionalHeight: CGFloat = 173
        let totalHeight = titleHeight + hotSaleHeight + additionalHeight
        return totalHeight
    }
}
