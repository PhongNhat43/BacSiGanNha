//
//  DoctorCollectionViewCell.swift
//  BacSiGanNha
//
//  Created by devsenior on 09/08/2023.
//

import UIKit

class DoctorCollectionViewCell: UICollectionViewCell {
    
    static let indentifier = "DoctorCollectionViewCell"
    
    static func nib() -> UINib {
       return UINib(nibName: "DoctorCollectionViewCell", bundle: nil)
    }

    @IBOutlet weak var doctorMainView: UIView!
    @IBOutlet weak var doctorImageView: UIImageView!
    @IBOutlet weak var doctorNameLabel: UILabel!
    @IBOutlet weak var doctorLastNameLabel: UILabel!
    @IBOutlet weak var doctorStarRateabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupUI() {
        doctorImageView.layer.cornerRadius = 8
        doctorMainView.translatesAutoresizingMaskIntoConstraints = false
        doctorMainView.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        doctorMainView.layer.cornerRadius = 8
        doctorMainView.layer.borderWidth = 1
        doctorMainView.layer.borderColor = UIColor(red: 0.933, green: 0.937, blue: 0.957, alpha: 1).cgColor
    }
    
    
    func configure(dataDoctor: DoctorList) {
        let placeholderImage = UIImage(named: "doctor")
           if let url = URL(string: dataDoctor.avatar) {
               doctorImageView.kf.setImage(with: url, placeholder: placeholderImage)
           } else {
               doctorImageView.image = placeholderImage
           }

        doctorNameLabel.text = "Dr. \(dataDoctor.name)"
        doctorLastNameLabel.text = dataDoctor.majorsName
        doctorLastNameLabel.textColor = UIColor(red: 0.588, green: 0.608, blue: 0.671, alpha: 1)
        doctorLastNameLabel.font = UIFont(name: "NunitoSans-Regular", size: 12)

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.87

        let starsText = NSAttributedString(string: "\(dataDoctor.ratioStar)", attributes: [
            .foregroundColor: UIColor(red: 0.278, green: 0.29, blue: 0.341, alpha: 1),
            .font: UIFont(name: "NunitoSans-Regular", size: 11)!
        ])

        let reviewsText = NSAttributedString(string: " (\(dataDoctor.numberOfReviews))", attributes: [
            .foregroundColor: UIColor(red: 0.588, green: 0.608, blue: 0.671, alpha: 1),
            .font: UIFont(name: "NunitoSans-Regular", size: 11)!
        ])

        let combinedText = NSMutableAttributedString()
        combinedText.append(starsText)
        combinedText.append(reviewsText)
        doctorStarRateabel.attributedText = combinedText

    }

}
