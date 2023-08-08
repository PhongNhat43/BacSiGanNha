//
//  OtpViewController.swift
//  BacSiGanNha
//
//  Created by devsenior on 08/08/2023.
//

import UIKit
import IQKeyboardManagerSwift
class OtpViewController: UIViewController {
    
    @IBOutlet var textFieldsOutletCollection: [UITextField]!
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var reSendBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var nextImageView: UIImageView!
    @IBOutlet weak var resendLabel: UILabel!
    
    var user: User?
    var activeTextField: UITextField?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupUI()
    }
    
    func setupNavigation() {
        self.navigationItem.title = "Xác minh số điện thoại"
        self.navigationItem.leftBarButtonItems = [UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(backButtonTapped))]
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    func setupUI() {
        for textField in textFieldsOutletCollection {
            textField.keyboardType = .numberPad
            textField.textAlignment = .center
            textField.layer.cornerRadius = 8
            textField.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.08).cgColor
            textField.layer.shadowOpacity = 1
            textField.layer.shadowOffset = CGSize(width: 0, height: 4)
            textField.layer.shadowRadius = 8
            textField.layer.masksToBounds = false // Important to display shadow properly
        }
        
        if let data = user {
               let paragraphStyle = NSMutableParagraphStyle()
               paragraphStyle.lineHeightMultiple = 1.05
               
               let phoneNumberAttributes: [NSAttributedString.Key: Any] = [
                   .font: UIFont(name: "NunitoSans-Bold", size: 14) ?? UIFont.systemFont(ofSize: 14, weight: .bold),
               ]
               
               let instructionText = "Vui lòng nhập mã gồm 6 chữ số đã được gửi đến bạn vào số điện thoại +84 \(data.phoneNumber.toPhoneNumber())"
               let attributedInstructionText = NSMutableAttributedString(string: instructionText, attributes: [
                   .foregroundColor: UIColor(red: 0.212, green: 0.239, blue: 0.306, alpha: 1),
                   .font: UIFont(name: "NunitoSans-Regular", size: 14) ?? UIFont.systemFont(ofSize: 14),
                   .paragraphStyle: paragraphStyle,
               ])
               
               attributedInstructionText.addAttributes(phoneNumberAttributes, range: (instructionText as NSString).range(of: "+84 \(data.phoneNumber.toPhoneNumber())"))
               
               instructionLabel.numberOfLines = 0
               instructionLabel.lineBreakMode = .byWordWrapping
               instructionLabel.attributedText = attributedInstructionText
           }
        resendLabel.layer.cornerRadius = 18
        resendLabel.layer.borderWidth = 1
        resendLabel.layer.borderColor = UIColor(red: 0.173, green: 0.525, blue: 0.404, alpha: 1).cgColor
        nextBtn.isEnabled = false
        nextImageView.alpha = 0.5
    }
    
    @IBAction func didChanged(_ textField: UITextField) {
        if textField.text!.count == 1 {
            if IQKeyboardManager.shared.canGoNext {
                IQKeyboardManager.shared.goNext()
            }
        }
        
        if textField.text!.count != 1 {
            if IQKeyboardManager.shared.canGoPrevious {
                IQKeyboardManager.shared.goPrevious()
            }
        }
//        self.textFieldAction()
    }
    
    
    @IBAction func didBeginEditing(_ sender: UITextField) {
        for textField in textFieldsOutletCollection {
               if textField == sender {
                   textField.layer.borderWidth = 1
                   textField.layer.borderColor = UIColor(red: 0.173, green: 0.525, blue: 0.404, alpha: 1).cgColor
               } else {
                   textField.layer.borderWidth = 0
                   textField.layer.borderColor = UIColor.clear.cgColor
               }
           }
    }
    

}

extension OtpViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == " " {
            return false
        } else if string.isEmpty {
            return true
        } else if textField.text!.count == 1 {
            textField.text = string
            if IQKeyboardManager.shared.canGoNext {
                IQKeyboardManager.shared.goNext()
            }
            textField.resignFirstResponder()
            return false
        }
        return true
    }
}

extension String {
     func toPhoneNumber() -> String {
        return self.replacingOccurrences(of: "(\\d{3})(\\d{3})(\\d+)", with: "$1 $2 $3", options: .regularExpression, range: nil)
    }
}

