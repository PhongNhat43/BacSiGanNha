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

    @IBOutlet private weak var doctorMainView: UIView!
    @IBOutlet private weak var doctorImageView: UIImageView!
    @IBOutlet private weak var doctorNameLabel: UILabel!
    @IBOutlet private weak var doctorLastNameLabel: UILabel!
    @IBOutlet private weak var doctorStarRateabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    func setupUI() {
        doctorImageView.layer.cornerRadius = 8
        doctorMainView.translatesAutoresizingMaskIntoConstraints = false
        doctorMainView.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        doctorMainView.layer.cornerRadius = 8
        doctorMainView.layer.borderWidth = 1
        doctorMainView.layer.borderColor = UIColor(red: 0.588, green: 0.608, blue: 0.671, alpha: 1).cgColor
    }
    
    func calculateLabelHeight(label: UILabel) -> CGFloat {
        let width = label.frame.size.width
        let size = CGSize(width: width, height: .greatestFiniteMagnitude)
        let result = label.sizeThatFits(size)
        return result.height
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
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

extension DoctorCollectionViewCell {
    func calculateCellHeight() -> CGFloat {
        let nameHeight = calculateLabelHeight(label: doctorNameLabel)
        let majorHeight = calculateLabelHeight(label: doctorLastNameLabel)
        let rateHeight = calculateLabelHeight(label: doctorStarRateabel)
        let additionalHeight: CGFloat = 145
        let totalHeight = nameHeight + majorHeight + rateHeight + additionalHeight
        return totalHeight
    }
}
