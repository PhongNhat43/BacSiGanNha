import UIKit

protocol InfoUserTableViewCellDelegate: AnyObject {
    func infoTextFieldDidChange(_ cell: InfoUserTableViewCell)
}

class InfoUserTableViewCell: UITableViewCell {
    var indexPath: IndexPath?

    weak var delegate: InfoUserTableViewCellDelegate?

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
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(infoTextFieldTapped))
        infoTextField.addGestureRecognizer(tapGesture)
        infoTextField.inputView = nil
    }

    @objc func infoTextFieldTapped() {
        if indexPath?.section == 2 {
            showDatePicker()
            infoTextField.becomeFirstResponder()
        } else {
            infoTextField.inputView = nil
            infoTextField.reloadInputViews()
            infoTextField.becomeFirstResponder()
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
        
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(infoTextFieldTouch))
//        infoTextField.addGestureRecognizer(tapGesture)
    }

//    @objc func infoTextFieldTouch() {
//        lineLabel.textColor = .red
//        infoTitleLabel.textColor = .red
//
//        if let tableView = superview as? UITableView, let indexPaths = tableView.indexPathsForVisibleRows {
//            for indexPath in indexPaths {
//                if indexPath != self.indexPath, let cell = tableView.cellForRow(at: indexPath) as? InfoUserTableViewCell {
//                    cell.lineLabel.textColor = .black
//                    cell.infoTitleLabel.textColor = .black
//                }
//            }
//        }
//    }

}

