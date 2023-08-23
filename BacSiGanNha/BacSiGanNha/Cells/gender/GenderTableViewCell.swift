//
//  GenderTableViewCell.swift
//  TableView5
//
//  Created by devsenior on 24/07/2023.
//

import UIKit

class GenderTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var generoSegmentControl: UISegmentedControl!
    weak var delegate: InfoUserTableViewCellDelegate?
    static let indentifier = "GenderTableViewCell"
    static func nib() -> UINib {
       return UINib(nibName: "GenderTableViewCell", bundle: nil)
    }
    @IBAction func generoAction(_ sender: Any) {
        let genIndex = generoSegmentControl.selectedSegmentIndex
        switch genIndex {
        case 0:
            print("Male")
        case 1:
            print("FeMale")
        default:
            print("zero")
        }
       UserDefaults.standard.set(genIndex, forKey: "genderKey")
       UserDefaults.standard.synchronize()
       delegate?.segmentedControlDidChange(self)
    }

    func setupUI() {
        let iconMale = UIImage(named: "icon")!
        let fontMale = UIFont(name: Constants.Font.bold, size: 14)
        let imageMale = UIImage.textEmbededImage(image: iconMale, string: "Nam", color: .black, imageAlignment: 0, segFont: fontMale)
        generoSegmentControl.setImage(imageMale, forSegmentAt: 0)

        let icon = UIImage(named: "male icon")!
        let font = UIFont(name: Constants.Font.bold, size: 14)
        let image = UIImage.textEmbededImage(image: icon, string: "Nữ", color: .black, imageAlignment: 0, segFont: font)
        generoSegmentControl.setImage(image, forSegmentAt: 1)

        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(red: 0.173, green: 0.525, blue: 0.404, alpha: 1)
        ]
        generoSegmentControl.setTitleTextAttributes(attributes, for: .selected)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with data: (title: String, placeholder: String),selectionStyle: UITableViewCell.SelectionStyle) {
        titleLabel.text = data.title
        self.selectionStyle = selectionStyle
        if let genderIndex = UserDefaults.standard.object(forKey: "genderKey") as? Int {
            generoSegmentControl.selectedSegmentIndex = genderIndex
        }
    }
}

