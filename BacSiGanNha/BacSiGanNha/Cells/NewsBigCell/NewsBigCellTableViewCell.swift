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
        
        newsTitleLabel.text = data.title
        let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" // Adjust this format to match your date string
           if let date = dateFormatter.date(from: data.createdAt) {
               dateFormatter.dateFormat = "d 'tháng' M, yyyy"
               newsCreateAt.text = dateFormatter.string(from: date)
           }
    }
    
}
