import UIKit

protocol InfoUserTableViewCellDelegate: AnyObject {
    func infoTextFieldDidChange(_ cell: InfoUserTableViewCell)
    func saveData(text: String, forSection section: Int)
}

class InfoUserTableViewCell: UITableViewCell {
    
    var infoText: String? {
           get {
               return infoTextField.text
           }
           set {
               infoTextField.text = newValue
           }
       }
       
       var wrongLabelText: String? {
           get {
               return wrongLabel.text
           }
           set {
               wrongLabel.text = newValue
           }
       }
       
       var wrongLabelTextColor: UIColor? {
           get {
               return wrongLabel.textColor
           }
           set {
               wrongLabel.textColor = newValue
           }
       }
    
    var indexPath: IndexPath?
    weak var delegate: InfoUserTableViewCellDelegate?
    var isEditingTextField: Bool = false
    static let indentifier = "InfoUserTableViewCell"
    static func nib() -> UINib {
       return UINib(nibName: "InfoUserTableViewCell", bundle: nil)
    }
    @IBOutlet private weak var dropDownBtn: UIButton!
    @IBOutlet private weak var validationLabel: UIView!
    @IBOutlet private weak var infoTitleLabel: UILabel!
    @IBOutlet private weak var infoTextField: UITextField!
    @IBOutlet private weak var wrongLabel: UILabel!
    @IBOutlet private weak var lineLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        infoTextField.inputView = nil
    }
    
    func updateInfoText(_ text: String) {
            infoTextField.text = text
        }
        
        func updateWrongLabelText(_ text: String) {
            wrongLabel.text = text
        }
    
    private func updateTitleLabelColor() {
        if isEditingTextField {
            infoTitleLabel.textColor = UIColor(red: 0.173, green: 0.525, blue: 0.404, alpha: 1)
            lineLabel.backgroundColor = UIColor(red: 0.173, green: 0.525, blue: 0.404, alpha: 1)
        } else {
            infoTitleLabel.textColor = UIColor(red: 0.588, green: 0.608, blue: 0.671, alpha: 1)
            lineLabel.backgroundColor = UIColor(red: 0.588, green: 0.608, blue: 0.671, alpha: 1)
        }
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
            delegate?.infoTextFieldDidChange(self)
    }
    
    func saveCellData() {
           let section = infoTextField.tag
           let text = infoTextField.text ?? ""
           delegate?.saveData(text: text, forSection: section)
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
    
    func updateInfoTextField(forSection section: Int) {
        switch section {
        case 0:
            infoTextField.text = UserDefaults.standard.string(forKey: "firstNameKey")
        case 1:
            infoTextField.text = UserDefaults.standard.string(forKey: "lastNameKey")
        case 2:
            dropDownBtn.isHidden = false
            if let dateOfBirth = UserDefaults.standard.object(forKey: "dateKey") as? String {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "'ngày' dd 'thg' MM, yyyy"
                if let birthDate = dateFormatter.date(from: dateOfBirth) {
                    let formatter = DateFormatter()
                    formatter.dateStyle = .medium
                    formatter.timeStyle = .none
                    let dateString = formatter.string(from: birthDate)
                    infoTextField.text = dateString
                }
            }
        case 4:
            if let phoneNumber = UserDefaults.standard.string(forKey: "phoneNumber") {
                infoTextField.text = phoneNumber
            } else {
                infoTextField.text = ""
            }
        case 5:
            infoTextField.text = UserDefaults.standard.string(forKey: "emailKey")
        case 6...10:
            infoTextField.text = ""
            if section == 9 {
                dropDownBtn.isHidden = true
            }
        default:
            break
        }
    }


    func configure(with data: (title: String, placeholder: String), isDropDownButtonHidden: Bool,isUserInteractionEnabled : Bool ,selectionStyle: UITableViewCell.SelectionStyle ,delegate: UITextFieldDelegate? = nil, section: Int) {
        infoTitleLabel.text = data.title
        infoTextField.placeholder = data.placeholder
        infoTextField.delegate = delegate
        infoTextField.delegate = self
        dropDownBtn.isHidden = isDropDownButtonHidden
        infoTextField.isUserInteractionEnabled = isUserInteractionEnabled
        self.selectionStyle = selectionStyle
        updateTitleLabelColor()
        infoTextField.tag = section
        updateInfoTextField(forSection: section)
    }
}
extension InfoUserTableViewCell: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        isEditingTextField = true
        updateTitleLabelColor()
        if indexPath?.section == 2 {
            showDatePicker()
        } else {
            infoTextField.inputView = nil
            infoTextField.reloadInputViews()
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        isEditingTextField = false
         updateTitleLabelColor()
    }

}
