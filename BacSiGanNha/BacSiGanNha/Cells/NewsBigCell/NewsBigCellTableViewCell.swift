//
//  NewsBigCellTableViewCell.swift
//  BacSiGanNha
//
//  Created by devsenior on 09/08/2023.
//

import UIKit

class NewsBigCellTableViewCell: UITableViewCell {
    static let indentifier = "NewsBigCellTableViewCell"
    
    static func nib() -> UINib {
       return UINib(nibName: "NewsBigCellTableViewCell", bundle: nil)
    }
    
    @IBOutlet private weak var newsTitleLabel: UILabel!
    @IBOutlet private weak var newsCreateAt: UILabel!
    @IBOutlet private weak var newsImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func formatDate(_ date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" 
        if let date = dateFormatter.date(from: date) {
            dateFormatter.dateFormat = "d 'tháng' M, yyyy"
            return dateFormatter.string(from: date)
        }
        return ""
    }
    
    func configure(data: ArticleList) {
        newsTitleLabel.text = data.title
        if let imageUrl = URL(string: data.picture) {
            let placeholderImage = UIImage(named: "placeholder")
            newsImageView.kf.setImage(with: imageUrl, placeholder: placeholderImage)
        }
        
        newsTitleLabel.text = data.title
        let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
           if let date = dateFormatter.date(from: data.createdAt) {
               dateFormatter.dateFormat = "d 'tháng' M, yyyy"
               newsCreateAt.text = dateFormatter.string(from: date)
        }
    }
    
}
