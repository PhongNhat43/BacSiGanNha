//
//  DoctorTableViewCell.swift
//  BacSiGanNha
//
//  Created by devsenior on 09/08/2023.
//

import UIKit

class DoctorTableViewCell: UITableViewCell {
    
    static let indentifier = "DoctorTableViewCell"
    static func nib() -> UINib {
       return UINib(nibName: "DoctorTableViewCell", bundle: nil)
    }

    @IBOutlet private weak var doctorMainView: UIView!
    @IBOutlet private weak var doctorNameLabel: UILabel!
    @IBOutlet private weak var doctorMajorLabel: UILabel!
    @IBOutlet private weak var doctorRateLabel: UILabel!
    @IBOutlet private weak var doctorImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUi()
    }
    
    func setupUi() {
        doctorMainView.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        doctorMainView.layer.cornerRadius = 12
        doctorMainView.layer.borderWidth = 1
        doctorMainView.layer.borderColor = UIColor(red: 0.933, green: 0.937, blue: 0.957, alpha: 1).cgColor
        doctorImageView.layer.cornerRadius = 6
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(data: DoctorList) {
        let placeholderImage = UIImage(named: "doctor")
        if let url = URL(string: data.avatar) {
            doctorImageView.kf.setImage(with: url, placeholder: placeholderImage)
        } else {
            doctorImageView.image = placeholderImage
        }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.9
        
        let rateAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "NunitoSans-Regular", size: 14) ?? UIFont.systemFont(ofSize: 14),
            .paragraphStyle: paragraphStyle
        ]
        
        let numberOfStarsAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "NunitoSans-Regular", size: 14) ?? UIFont.systemFont(ofSize: 14), // Thêm đoạn này
            .foregroundColor: UIColor(red: 0.492, green: 0.516, blue: 0.596, alpha: 1)
        ]
        
        doctorNameLabel.text = "BS. \(data.fullName)"
        doctorMajorLabel.text = "Chuyên ngành \(data.majorsName)"
        let rateText = NSAttributedString(string: "\(data.ratioStar) ", attributes: rateAttributes)
        let numberOfStarsText = NSAttributedString(string: "(\(data.numberOfStars) Đánh giá)", attributes: numberOfStarsAttributes)
        let combinedText = NSMutableAttributedString()
        combinedText.append(rateText)
        combinedText.append(numberOfStarsText)
        doctorRateLabel.attributedText = combinedText
    }
}
