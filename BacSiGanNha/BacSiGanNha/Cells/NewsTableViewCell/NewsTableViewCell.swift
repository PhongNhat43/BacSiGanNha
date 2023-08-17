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
    
    var bookmarkTapped: (() -> Void)?
    
    @IBOutlet private weak var newsMainView: UIView!
    @IBOutlet private weak var newsTitleLabel: UILabel!
    @IBOutlet private weak var newsCreateNews: UILabel!
    @IBOutlet private weak var newsImageView: UIImageView!
    @IBOutlet weak var bookMarkImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupUI() {
        newsImageView.layer.cornerRadius = 8
        newsImageView.layer.borderWidth = 1
        newsImageView.layer.borderColor = UIColor(red: 0.933, green: 0.937, blue: 0.957, alpha: 1).cgColor

    }
    
    @IBAction func bookMarkButtonTapped(_ sender: Any) {
        bookmarkTapped?()
        bookmarkTapped = {
              self.bookMarkImageView.isHighlighted = !self.bookMarkImageView.isHighlighted
        }
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
       
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.13
            
        let attributedText = NSAttributedString(
                string: data.title,
                attributes: [
                    .paragraphStyle: paragraphStyle,
                    .font: newsTitleLabel.font,
                    .foregroundColor: newsTitleLabel.textColor
                ]
            )
        newsTitleLabel.attributedText = attributedText
        newsCreateNews.text = data.createdAt
     
        selectionStyle = .none
    }
    
}



