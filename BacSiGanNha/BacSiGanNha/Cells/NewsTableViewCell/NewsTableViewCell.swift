//
//  NewsTableViewCell.swift
//  BacSiGanNha
//
//  Created by devsenior on 09/08/2023.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    static let indentifier = "NewsTableViewCell"
    
    static func nib() -> UINib {
       return UINib(nibName: "NewsTableViewCell", bundle: nil)
    }
    
    @IBOutlet weak var newsMainView: UIView!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsCreateNews: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUI() {
        newsImageView.layer.cornerRadius = 8
        newsImageView.layer.borderWidth = 1
        newsImageView.layer.borderColor = UIColor(red: 0.933, green: 0.937, blue: 0.957, alpha: 1).cgColor

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
        // Tạo một NSMutableParagraphStyle với lineHeightMultiple
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineHeightMultiple = 1.13
            
            // Thiết lập thuộc tính của newsTitleLabel
            let attributedText = NSAttributedString(
                string: data.title,
                attributes: [
                    .paragraphStyle: paragraphStyle,
                    .font: newsTitleLabel.font, // Bạn cần thiết lập font cho attributed string
                    .foregroundColor: newsTitleLabel.textColor // Bạn cũng có thể thiết lập màu sắc
                ]
            )
            newsTitleLabel.attributedText = attributedText
        newsCreateNews.text = data.createdAt
    }
    
}



