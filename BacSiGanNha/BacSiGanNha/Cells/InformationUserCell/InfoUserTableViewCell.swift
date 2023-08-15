import UIKit

protocol InfoUserTableViewCellDelegate: AnyObject {
    func infoTextFieldDidChange(_ cell: InfoUserTableViewCell)
}

class InfoUserTableViewCell: UITableViewCell {
    
    var indexPath: IndexPath?
    weak var delegate: InfoUserTableViewCellDelegate?
    var isEditingTextField: Bool = false
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
        infoTextField.inputView = nil
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
        infoTextField.delegate = self
        dropDownBtn.isHidden = isDropDownButtonHidden
        infoTextField.isUserInteractionEnabled = isUserInteractionEnabled
        self.selectionStyle = selectionStyle
        updateTitleLabelColor()
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
