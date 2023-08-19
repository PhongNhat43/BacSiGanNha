//
//  InfoViewController.swift
//  BacSiGanNha
//
//  Created by devsenior on 14/08/2023.
//

import UIKit
import IQKeyboardManagerSwift
class InfoViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var nextBtnImageView: UIImageView!
    @IBOutlet private weak var infoNextBtn: UIButton!
    
    var isDataSavedSuccessfully: Bool = false
    var selectedIndexPath: IndexPath?
    var data: [(title: String, placeholder: String)] = [
        ("Tên *", "Nhập tên của bạn"),
        ("Họ *", "Nhập họ của bạn"),
        ("Ngày Sinh *", "DD//MM//YY"),
        ("Giới Tính", ""),
        ("Số điện thoại", ""),
        ("Email", "Địa chỉ email của bạn"),
        ("Tỉnh / Thành phố", "Chưa cập nhật"),
        ("Quận/ Huyện", "Chưa cập nhật"),
        ("Phường / Xã", "Chưa cập nhật"),
        ("Địa chỉ ở", "Nơi thường trú của bạn"),
        ("Nhóm máu", "A+/B+/AB/O")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigation()
        printUserDefaultsKeys()
    }
    
    func printUserDefaultsKeys() {
        let defaults = UserDefaults.standard
        let keys = ["firstNameKey", "lastNameKey", "dateKey", "emailKey"]
        for key in keys {
            if let value = defaults.string(forKey: key) {
                print("\(key): \(value)")
            }
        }
    }
    
    func isTextValid(_ text: String) -> Bool {
           let characterSet = CharacterSet.letters
           return text.rangeOfCharacter(from: characterSet.inverted) == nil
       }

    
    func setupNavigation() {
        self.navigationItem.title = "Thông tin cá nhân"
        self.navigationItem.leftBarButtonItems = [UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(backButtonTapped))]
    }

    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(InfoUserTableViewCell.nib(), forCellReuseIdentifier: InfoUserTableViewCell.indentifier)
        tableView.register(GenderTableViewCell.nib(), forCellReuseIdentifier: GenderTableViewCell.indentifier)
    }
  

    @IBAction func didTapDoneBtn(_ sender: Any) {
        // Check if any field is empty
        var isAnyFieldEmpty = false

        for section in 0...2 {
            let indexPath = IndexPath(row: 0, section: section)
            if let cell = tableView.cellForRow(at: indexPath) as? InfoUserTableViewCell,
               let text = cell.getInfoTextFieldText() {
                if cell.isInfoTextFieldEmpty() {
                    cell.updateWrongLabelText("Không để trống")
                    cell.updateWrongLabelTextColor(UIColor.red)
                    isAnyFieldEmpty = true
                } else if (section == 0 || section == 1) && !isTextValid(text) {
                    cell.updateWrongLabelText("Vui lòng đúng thông tin")
                    cell.updateWrongLabelTextColor(UIColor.red)
                    isAnyFieldEmpty = true
                }
            }
        }


        if isAnyFieldEmpty {
            nextBtnImageView.alpha = 0.5
            infoNextBtn.isEnabled = false
        } else {
            // All fields are filled, you can proceed with the rest of your code
        }

        // Check if email is valid
        let emailIndexPath = IndexPath(row: 0, section: 5)
        if let emailCell = tableView.cellForRow(at: emailIndexPath) as? InfoUserTableViewCell,
           let email = emailCell.getInfoTextFieldText() {
            if !isValidEmail(email) {
                emailCell.updateWrongLabelText("Email không hợp lệ")
                emailCell.updateWrongLabelTextColor(UIColor.red)
                return
            } else {
                // Save email to UserDefaults only when it's valid
                UserDefaults.standard.set(email, forKey: "emailKey")
            }
        }


        // Save data to UserDefaults for other fields when all text fields are valid
        for section in 0..<tableView.numberOfSections {
            if section != 5 { // Exclude the email field
                let indexPath = IndexPath(row: 0, section: section)
                if let cell = tableView.cellForRow(at: indexPath) as? InfoUserTableViewCell {
                    cell.saveCellData()
                }
            }
        }

        // Clear "Email không hợp lệ" text
        if let emailCell = tableView.cellForRow(at: emailIndexPath) as? InfoUserTableViewCell {
            emailCell.updateWrongLabelText("")
        }

        // Show alert
        let alertController = UIAlertController(title: "Lưu dữ liệu thành công", message: nil, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }


}

extension InfoViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentData = data[indexPath.section]
        let sectionNumber = indexPath.section
        switch indexPath.section {
        case 0, 1, 2, 4, 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: InfoUserTableViewCell.indentifier, for: indexPath) as! InfoUserTableViewCell
            cell.configure(with: currentData, isDropDownButtonHidden: true, isUserInteractionEnabled: true, selectionStyle: .none, section: sectionNumber)
            cell.indexPath = indexPath
            cell.delegate = self
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: GenderTableViewCell.indentifier, for: indexPath) as! GenderTableViewCell
            cell.configure(with: currentData, selectionStyle: .none)
            return cell
        case 6...10:
            let cell = tableView.dequeueReusableCell(withIdentifier: InfoUserTableViewCell.indentifier, for: indexPath) as! InfoUserTableViewCell
            cell.configure(with: currentData, isDropDownButtonHidden: false, isUserInteractionEnabled: false, selectionStyle: .none, section: sectionNumber)
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension InfoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 85
    }
}

extension InfoViewController: InfoUserTableViewCellDelegate {
    // Save data to user defaults
    func saveData(text: String, forSection section: Int) {
            switch section {
            case 0:
                UserDefaults.standard.set(text, forKey: "firstNameKey")
            case 1:
                UserDefaults.standard.set(text, forKey: "lastNameKey")
            case 2:
                UserDefaults.standard.set(text, forKey: "dateKey")
            case 5:
                UserDefaults.standard.set(text, forKey: "emailKey")
            default:
                break
            }
        }
    
    func infoTextFieldDidChange(_ cell: InfoUserTableViewCell) {
        if let indexPath = tableView.indexPath(for: cell),
           [0, 1, 2].contains(indexPath.section),
           cell.isEditingTextField,
           let updatedText = cell.getInfoTextFieldText(), !updatedText.isEmpty {
            cell.updateWrongLabelText("")
            nextBtnImageView.alpha = 1.0
            infoNextBtn.isEnabled = true
        }
    }


    
}



func isValidEmail(_ email: String) -> Bool {
    let emailRegex = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.(com|net|org|edu|gov|mil|vc|info|mobi|name|aero|asia|jobs|museum|co\\.vn|vn)$"
    let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
    return emailPredicate.evaluate(with: email)
}
