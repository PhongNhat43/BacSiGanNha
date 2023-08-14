//
//  InfoUserTableViewCell.swift
//  BacSi_App
//
//  Created by devsenior on 24/07/2023.
//

import UIKit

class InfoUserTableViewCell: UITableViewCell {
    
    var isDatePickerEnabled = false
    var selectedIndexPath: IndexPath?
    
    static let indentifier = "InfoUserTableViewCell"

    static func nib() -> UINib {
       return UINib(nibName: "InfoUserTableViewCell", bundle: nil)
    }
    @IBOutlet weak var dropDownBtn: UIButton!
    @IBOutlet weak var validationLabel: UIView!
    @IBOutlet weak var infoTitleLabel: UILabel!
    @IBOutlet weak var infoTextField: UITextField!
    @IBOutlet weak var wrongLabel: UILabel!
    @IBOutlet weak var lineLabel: UILabel!
    
    override func awakeFromNib() {
           super.awakeFromNib()
    }

    func showDatePicker() {
        let datePicker = UIDatePicker()
        datePicker.addTarget(self, action: #selector(dateChange(datePicker:)), for: UIControl.Event.valueChanged)
        datePicker.frame.size = CGSize(width: 0, height: 300)
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        infoTextField.inputView = datePicker
    }
       
    @IBAction func didTapDropDownBtn(_ sender: Any) {
        print("did Tap")
        showDatePicker()
        infoTextField.becomeFirstResponder()
    }
        
    
    @IBAction func textFieldidChanged(_ textField: UITextField) {

        }
    
    @objc func dateChange(datePicker: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        let dateString = formatter.string(from: datePicker.date)
        infoTextField.text = dateString
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configure(with data: (title: String, placeholder: String), isDropDownButtonHidden: Bool,isUserInteractionEnabled : Bool ,selectionStyle: UITableViewCell.SelectionStyle ,delegate: UITextFieldDelegate? = nil) {
        infoTitleLabel.text = data.title
        infoTextField.placeholder = data.placeholder
        infoTextField.delegate = delegate
        dropDownBtn.isHidden = isDropDownButtonHidden
        infoTextField.isUserInteractionEnabled = isUserInteractionEnabled
        self.selectionStyle = selectionStyle
    }
}


