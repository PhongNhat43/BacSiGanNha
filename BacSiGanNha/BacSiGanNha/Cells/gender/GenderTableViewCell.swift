//
//  GenderTableViewCell.swift
//  TableView5
//
//  Created by devsenior on 24/07/2023.
//

import UIKit
protocol GenderTableViewCellDelegate: AnyObject {
    func genderTableViewCell(_ cell: GenderTableViewCell, didSelectGender gender: String)
}
class GenderTableViewCell: UITableViewCell {

    weak var delegate: GenderTableViewCellDelegate?
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
            delegate?.genderTableViewCell(self, didSelectGender: "Nam")
        case 1:
            print("FeMale")
            delegate?.genderTableViewCell(self, didSelectGender: "Nữ")
        default:
            print("zero")
        }
        
       UserDefaults.standard.set(genIndex, forKey: "genderKey")
       UserDefaults.standard.synchronize()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
  
    
}




