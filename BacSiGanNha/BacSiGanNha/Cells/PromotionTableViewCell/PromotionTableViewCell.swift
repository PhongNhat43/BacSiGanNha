//
//  PromotionTableViewCell.swift
//  BacSiGanNha
//
//  Created by devsenior on 09/08/2023.
//

import UIKit

class PromotionTableViewCell: UITableViewCell {
    
    static let indentifier = "PromotionTableViewCell"
    
    static func nib() -> UINib {
       return UINib(nibName: "PromotionTableViewCell", bundle: nil)
    }
    var bookmarkTapped: (() -> Void)?
    
    @IBOutlet weak var promotionImageView: UIImageView!
    @IBOutlet weak var promotionCreateAtLabel: UILabel!
    @IBOutlet weak var promotionTitleLabel: UILabel!
    @IBOutlet weak var bookMarkImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }

    func setupUI() {
        promotionImageView.layer.cornerRadius = 8
        promotionImageView.layer.borderWidth = 1
        promotionImageView.layer.borderColor = UIColor(red: 0.933, green: 0.937, blue: 0.957, alpha: 1).cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func bookMarkButtonTapped(_ sender: Any) {
            bookmarkTapped?()
    }
    
    func configure(data: PromotionList) {
        promotionImageView.setImage(imageUrl: data.picture)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.13
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "NunitoSans-Bold", size: 13) ?? UIFont.systemFont(ofSize: 13, weight: .bold),
            .foregroundColor: UIColor(red: 0.071, green: 0.071, blue: 0.071, alpha: 1),
            .paragraphStyle: paragraphStyle
        ]
        
        let attributedText = NSAttributedString(string: data.name, attributes: attributes)
        promotionTitleLabel.attributedText = attributedText
        promotionTitleLabel.numberOfLines = 0
        promotionTitleLabel.lineBreakMode = .byWordWrapping
        promotionCreateAtLabel.text = data.createdAt
    }

    
}
