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
               newsCreateNews.text = dateFormatter.string(from: date)
        }
     
        selectionStyle = .none
    }
    
}



