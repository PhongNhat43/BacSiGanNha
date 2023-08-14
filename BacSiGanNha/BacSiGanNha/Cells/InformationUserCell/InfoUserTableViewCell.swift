import UIKit

protocol InfoUserTableViewCellDelegate: AnyObject {
    func infoTextFieldDidChange(_ cell: InfoUserTableViewCell)
}

class InfoUserTableViewCell: UITableViewCell {
    
    weak var delegate: InfoUserTableViewCellDelegate?
    var indexPath: IndexPath?
   
    
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
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }


    func showDatePicker() {
        if indexPath?.section == 2 {
            let datePicker = UIDatePicker()
            datePicker.addTarget(self, action: #selector(dateChange(datePicker:)), for: .valueChanged)
            datePicker.preferredDatePickerStyle = .wheels
            datePicker.datePickerMode = .date
            infoTextField.inputView = datePicker
            infoTextField.becomeFirstResponder()
            
            // Hãy thêm dòng sau để tự động chọn ngày hiện tại khi hiển thị datePicker
            if let date = infoTextField.text, let currentDate = dateFormatter.date(from: date) {
                datePicker.date = currentDate
            }
        }
    }
     
    
    @IBAction func textTouch(_ textField: UITextField) {
        if textField == infoTextField, indexPath?.section == 2 {
            print("did Tap")
            if indexPath?.section == 2 {
                showDatePicker()
                infoTextField.becomeFirstResponder()
            }
        }
    }



    @IBAction func didTapDropDownBtn(_ sender: Any) {
//          print("did Tap")
//          if indexPath?.section == 2 {
//              showDatePicker()
//              infoTextField.becomeFirstResponder()
//          }
      }
    
    @IBAction func textFieldidChanged(_ textField: UITextField) {
                delegate?.infoTextFieldDidChange(self)
        
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
    
//    func configure(with data: (title: String, placeholder: String), isDropDownButtonHidden: Bool,isUserInteractionEnabled : Bool ,selectionStyle: UITableViewCell.SelectionStyle ,delegate: UITextFieldDelegate? = nil) {
//        infoTitleLabel.text = data.title
//        infoTextField.placeholder = data.placeholder
//        infoTextField.delegate = delegate
//        dropDownBtn.isHidden = isDropDownButtonHidden
//        infoTextField.isUserInteractionEnabled = isUserInteractionEnabled
//        self.selectionStyle = selectionStyle
//    }
    
    func configure(with data: (title: String, placeholder: String), isDropDownButtonHidden: Bool, isUserInteractionEnabled: Bool, selectionStyle: UITableViewCell.SelectionStyle, delegate: UITextFieldDelegate? = nil) {
        infoTitleLabel.text = data.title
        infoTextField.placeholder = data.placeholder
        infoTextField.delegate = delegate
        dropDownBtn.isHidden = isDropDownButtonHidden
        infoTextField.isUserInteractionEnabled = isUserInteractionEnabled
        self.selectionStyle = selectionStyle
        
        if indexPath?.section == 2 {
            infoTextField.addTarget(self, action: #selector(infoTextFieldTouchedDown), for: .touchDown)
        } else {
            infoTextField.removeTarget(self, action: #selector(infoTextFieldTouchedDown), for: .touchDown)
        }
    }
    
    @objc private func infoTextFieldTouchedDown() {
        if let indexPath = indexPath, indexPath.section == 2 {
            showDatePicker()
            infoTextField.becomeFirstResponder()
        }
    }




}

