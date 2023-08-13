//
//  LoginViewController.swift
//  BacSiGanNha
//
//  Created by devsenior on 07/08/2023.
//

import UIKit
import IQKeyboardManagerSwift
class LoginViewController: UIViewController {
    
    // MARK: - Outlet
    @IBOutlet weak var viewTextfield: UIView!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var nexBtnImageView: UIImageView!
    @IBOutlet weak var validationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupUI()
    }
    
    func setupNavigation() {
        self.navigationItem.leftBarButtonItems = [UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(backButtonTapped))]
    }

    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    func setupUI() {
        // Thiết lập các thuộc tính UI
        phoneTextField.delegate = self
        phoneTextField.keyboardType = .numberPad
        viewTextfield.layer.cornerRadius = 28
        viewTextfield.layer.borderWidth = 1
        viewTextfield.layer.borderColor = UIColor(red: 0.933, green: 0.937, blue: 0.957, alpha: 1).cgColor
        viewTextfield.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        viewTextfield.layer.shadowOffset = CGSize(width: 0, height: 5)
        viewTextfield.layer.shadowRadius = 20
        viewTextfield.layer.shadowOpacity = 1.0
        
        nextBtn.isEnabled = false
        nexBtnImageView.layer.cornerRadius = 24
        nexBtnImageView.alpha = 0.5
        
        phoneTextField.borderStyle = .none
    }
    
    @IBAction func textFieldDidBeginEditing(_ textField: UITextField) {
        viewTextfield.layer.borderColor = UIColor(red: 0.173, green: 0.525, blue: 0.404, alpha: 1).cgColor
    }
    
    @IBAction func textFieldDidChange(_ textField: UITextField) {
        if let text = textField.text {
            if text.isValidPhoneNumber() {
                   nextBtn.isEnabled = true
                   nexBtnImageView.alpha = 1
                   return
               }
            if !text.isValidPhoneNumber() {
                   nextBtn.isEnabled = false
                   nexBtnImageView.alpha = 0.5
                   return
               }
           }
    }
    
    @IBAction func didTapNextBtn(_ sender: Any) {
        let vc = OtpViewController(nibName: "OtpViewController", bundle: nil)
        let user = User(phoneNumber: phoneTextField.text!)
        vc.user = user
        UserDefaults.standard.set(phoneTextField.text!, forKey: "phoneNumber")
        navigationController?.pushViewController(vc, animated: true)
    }
}


extension LoginViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let maxLength = currentText.first == "0" ? 11 : 10
        
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        if updatedText.count > maxLength {
            return false
        }
        
        if updatedText.count == maxLength {
            if updatedText.isValidPhoneNumber() {
                nextBtn.isEnabled = true
                nexBtnImageView.alpha = 1
            } else {
                nextBtn.isEnabled = false
                nexBtnImageView.alpha = 0.5
            }
        } else {
            nextBtn.isEnabled = false
            nexBtnImageView.alpha = 0.5
        }
        
        return true
    }
}

extension String {
    func isValidPhoneNumber() -> Bool {
        let phoneRegEx = "^(086|096|097|098|0162|0163|0164|0165|0166|0167|0168|0169|86|96|97|98|162|163|164|165|166|167|168|169)\\d{7}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegEx)
        let result = phoneTest.evaluate(with: self)
        return result
    }
}
