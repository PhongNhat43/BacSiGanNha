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
    }
    
    func setupUI() {
        generoSegmentControl.setImage(UIImage.textEmbededImage(image: UIImage(named: "icon")!, string: "Nam", color: .black), forSegmentAt: 0)
        generoSegmentControl.setImage(UIImage.textEmbededImage(image: UIImage(named: "male icon")!, string: "Nữ", color: .black), forSegmentAt: 1)
        
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(red: 0.173, green: 0.525, blue: 0.404, alpha: 1),
            .font: UIFont(name: "NunitoSans-Bold", size: 14) ?? UIFont.systemFont(ofSize: 14)
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
    }
    
  
    
}




