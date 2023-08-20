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
    
    @IBOutlet private weak var promotionImageView: UIImageView!
    @IBOutlet private weak var promotionCreateAtLabel: UILabel!
    @IBOutlet private weak var promotionTitleLabel: UILabel!
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
        bookmarkTapped = {
              self.bookMarkImageView.isHighlighted = !self.bookMarkImageView.isHighlighted
        }
    }
    
    func configure(data: PromotionList) {
        promotionImageView.setImage(imageUrl: data.picture)
        promotionTitleLabel.text = data.name
        let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
           if let date = dateFormatter.date(from: data.createdAt) {
               dateFormatter.dateFormat = "d 'tháng' M, yyyy"
               promotionCreateAtLabel.text = dateFormatter.string(from: date)
        }
        selectionStyle = .none
    }
}
