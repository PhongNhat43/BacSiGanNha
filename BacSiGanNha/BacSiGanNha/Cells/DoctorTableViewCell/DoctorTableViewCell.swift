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

    @IBOutlet weak var doctorMainView: UIView!
    @IBOutlet weak var doctorNameLabel: UILabel!
    @IBOutlet weak var doctorMajorLabel: UILabel!
    @IBOutlet weak var doctorRateLabel: UILabel!
    @IBOutlet weak var doctorImageView: UIImageView!

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

        // Configure the view for the selected state
    }
    
//    func configure(data: DoctorList) {
//        let placeholderImage = UIImage(named: "doctor")
//           if let url = URL(string: data.avatar) {
//               doctorImageView.kf.setImage(with: url, placeholder: placeholderImage)
//           } else {
//               doctorImageView.image = placeholderImage
//           }
//
//        doctorNameLabel.text = "BS. \(data.fullName)"
//        doctorMajorLabel.text = "Chuyên ngành \(data.majorsName)"
//        doctorRateLabel.text = "\(data.ratioStar) (\(data.numberOfStars) Đánh giá)"
//    }
    
    func configure(data: DoctorList) {
        let placeholderImage = UIImage(named: "doctor")
        if let url = URL(string: data.avatar) {
            doctorImageView.kf.setImage(with: url, placeholder: placeholderImage)
        } else {
            doctorImageView.image = placeholderImage
        }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.9
        
        let nameAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "NunitoSans-Bold", size: 15) ?? UIFont.systemFont(ofSize: 15, weight: .bold),
            .foregroundColor: UIColor(red: 0.067, green: 0.161, blue: 0.314, alpha: 1),
            .paragraphStyle: paragraphStyle
        ]
        
        let majorAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "NunitoSans-Regular", size: 13) ?? UIFont.systemFont(ofSize: 13),
            .foregroundColor: UIColor(red: 0.588, green: 0.608, blue: 0.671, alpha: 1),
            .paragraphStyle: paragraphStyle
        ]
        
        let rateAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "NunitoSans-Regular", size: 14) ?? UIFont.systemFont(ofSize: 14),
            .paragraphStyle: paragraphStyle
        ]
        
        let numberOfStarsAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "NunitoSans-Regular", size: 14) ?? UIFont.systemFont(ofSize: 14), // Thêm đoạn này
            .foregroundColor: UIColor(red: 0.492, green: 0.516, blue: 0.596, alpha: 1)
        ]
        
        let nameText = NSAttributedString(string: "BS. \(data.fullName)", attributes: nameAttributes)
        doctorNameLabel.attributedText = nameText
        
        let majorText = NSAttributedString(string: "Chuyên ngành \(data.majorsName)", attributes: majorAttributes)
        doctorMajorLabel.attributedText = majorText
        
        let rateText = NSAttributedString(string: "\(data.ratioStar) ", attributes: rateAttributes)
        let numberOfStarsText = NSAttributedString(string: "(\(data.numberOfStars) Đánh giá)", attributes: numberOfStarsAttributes)
        let combinedText = NSMutableAttributedString()
        combinedText.append(rateText)
        combinedText.append(numberOfStarsText)
        
        doctorRateLabel.attributedText = combinedText
    }


    
    
}
