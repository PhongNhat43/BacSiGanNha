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
        
//        for section in 0...2 {
//               if let cell = tableView.cellForRow(at: IndexPath(row: 0, section: section)) as? InfoUserTableViewCell {
////                   cell.infoTextField.delegate = self
//                   cell.infoTextField.addTarget(self, action: #selector(textIsChanging), for: UIControlEvents.editingChanged)
//               }
//           }
    }
    
    func saveData() {
        let firstNameIndexPath = IndexPath(row: 0, section: 0)
        let lastNameIndexPath = IndexPath(row: 0, section: 1)
        let birthDateIndexPath = IndexPath(row: 0, section: 2)
        let emailIndexPath = IndexPath(row: 0, section: 5)
        
        if let firstNameCell = tableView.cellForRow(at: firstNameIndexPath) as? InfoUserTableViewCell,
           let lastNameCell = tableView.cellForRow(at: lastNameIndexPath) as? InfoUserTableViewCell,
           let birthDateCell = tableView.cellForRow(at: birthDateIndexPath) as? InfoUserTableViewCell,
           let emailCell = tableView.cellForRow(at: emailIndexPath) as? InfoUserTableViewCell {
            let firstName = firstNameCell.infoTextField.text ?? ""
            let lastName = lastNameCell.infoTextField.text ?? ""
            let birthDate = birthDateCell.infoTextField.text ?? ""
            let email = emailCell.infoTextField.text ?? ""
            
            UserDefaults.standard.set(firstName, forKey: "firstNameKey")
            UserDefaults.standard.set(lastName, forKey: "lastNameKey")
            UserDefaults.standard.set(birthDate, forKey: "dateKey")
            UserDefaults.standard.set(email, forKey: "emailKey")
        }
    }
    
    @IBAction func didTapDoneBtn(_ sender: Any) {
        var isAnyFieldEmpty = false
        
        for section in 0...2 {
            let indexPath = IndexPath(row: 0, section: section)
            if let cell = tableView.cellForRow(at: indexPath) as? InfoUserTableViewCell,
               cell.infoTextField.text?.isEmpty ?? true {
                isAnyFieldEmpty = true
                cell.wrongLabel.text = "Không để trống"
                cell.wrongLabel.textColor = UIColor.red
                nextBtnImageView.alpha = 0.5
                infoNextBtn.isEnabled = false
                return
            }
        }
        saveData()
        
        let emailIndexPath = IndexPath(row: 0, section: 5)
        if let emailCell = tableView.cellForRow(at: emailIndexPath) as? InfoUserTableViewCell,
           let email = emailCell.infoTextField.text,
           !isValidEmail(email) {
            emailCell.wrongLabel.text = "Email không hợp lệ"
            emailCell.wrongLabel.textColor = UIColor.red
            return
        }
        
        
    
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
        switch indexPath.section {
        case 0, 1, 2, 4, 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: InfoUserTableViewCell.indentifier, for: indexPath) as! InfoUserTableViewCell
            cell.configure(with: currentData, isDropDownButtonHidden: true, isUserInteractionEnabled: true, selectionStyle: .none)
            cell.delegate = self
            cell.indexPath = indexPath
            if indexPath.section == 0 {
                cell.infoTextField.text = UserDefaults.standard.string(forKey: "firstNameKey")
            }
            if indexPath.section == 1 {
                cell.infoTextField.text = UserDefaults.standard.string(forKey: "lastNameKey")
            }
            if indexPath.section == 2 {
                cell.dropDownBtn.isHidden = false
                if let dateOfBirth = UserDefaults.standard.object(forKey: "dateKey") as? String {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "'ngày' dd 'thg' MM, yyyy"
                    if let birthDate = dateFormatter.date(from: dateOfBirth) {
                        let formatter = DateFormatter()
                        formatter.dateStyle = .medium
                        formatter.timeStyle = .none
                        let dateString = formatter.string(from: birthDate)
                        cell.infoTextField.text = dateString
                        
                    }
                }
            }
            
            if indexPath.section == 4 {
                if let phoneNumber = UserDefaults.standard.string(forKey: "phoneNumber") {
                        cell.infoTextField.text = phoneNumber
                } else {
                        cell.infoTextField.text = ""
                }
            }

            if indexPath.section == 5 {
                cell.infoTextField.text = UserDefaults.standard.string(forKey: "emailKey")
            }
            
        
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: GenderTableViewCell.indentifier, for: indexPath) as! GenderTableViewCell
            cell.configure(with: currentData, selectionStyle: .none)
            cell.generoSegmentControl.selectedSegmentIndex = UserDefaults.standard.integer(forKey: "genderKey")
            return cell
        case 6...10:
            let cell = tableView.dequeueReusableCell(withIdentifier: InfoUserTableViewCell.indentifier, for: indexPath) as! InfoUserTableViewCell
            cell.configure(with: currentData, isDropDownButtonHidden: false, isUserInteractionEnabled: false, selectionStyle: .none)
            cell.infoTextField.text = ""
            if indexPath.section == 9 {
                cell.dropDownBtn.isHidden = true
            }
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

extension InfoViewController: UITextFieldDelegate {

}

extension InfoViewController: InfoUserTableViewCellDelegate {
    func infoTextFieldDidChange(_ cell: InfoUserTableViewCell) {
        if let indexPath = tableView.indexPath(for: cell),
           [0, 1, 2].contains(indexPath.section),
           cell.infoTextField.isEditing,
           let updatedText = cell.infoTextField.text, !updatedText.isEmpty {
            cell.wrongLabel.text = ""
            nextBtnImageView.alpha = 1.0
            infoNextBtn.isEnabled = true
        }
    }
}





    

func isValidEmail(_ email: String) -> Bool {
    let emailRegex = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.(com|net|org|edu|gov|mil|biz|info|mobi|name|aero|asia|jobs|museum|co\\.vn|vn)$"
    let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
    return emailPredicate.evaluate(with: email)
}
