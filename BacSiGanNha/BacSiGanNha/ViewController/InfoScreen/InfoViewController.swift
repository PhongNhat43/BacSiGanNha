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
    var temporaryData: [Int: String] = [:]
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
        nextBtnImageView.alpha = 0.5
        infoNextBtn.isEnabled = false
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
    // kiểm tra xem có ký tự đặc biệt không
    func isTextValid(_ text: String) -> Bool {
           let characterSet = CharacterSet.letters
           return text.rangeOfCharacter(from: characterSet.inverted) == nil
    }
    func setupNavigation() {
        self.navigationItem.title = "Thông tin cá nhân"
        if let navigationBar = self.navigationController?.navigationBar {
            let font = UIFont(name: Constants.Font.bold, size: 18)
                  let headColor = UIColor(red: 0.141, green: 0.165, blue: 0.38, alpha: 1)
                  let titleTextAttributes: [NSAttributedString.Key: Any] = [
                      .font: font,
                      .foregroundColor: headColor
                  ]
            navigationBar.titleTextAttributes = titleTextAttributes
        }
        // Thiết lập nút bên trái
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "back"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        let backBarButton = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem = backBarButton
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
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.(com|net|org|edu|gov|mil|vc|info|mobi|name|aero|asia|jobs|museum|co\\.vn|vn)$"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    func checkTextFieldValid() {
        var allFieldsValid = true
           var validTextFieldCount = 0

           // Kiểm tra các section từ 0 đến 2
           for section in 0...2 {
               let indexPath = IndexPath(row: 0, section: section)
               guard let cell = tableView.cellForRow(at: indexPath) as? InfoUserTableViewCell else {
                   continue
               }
               if cell.isInfoTextFieldEmpty() {
                   cell.updateWrongLabelText("Không để trống")
                   cell.updateWrongLabelTextColor(UIColor.red)
                   allFieldsValid = false
                   nextBtnImageView.alpha = 0.5
                   infoNextBtn.isEnabled = false
                   return
               }
               if (section == 0 || section == 1), let text = cell.getInfoTextFieldText(), !isTextValid(text) {
                   cell.updateWrongLabelText("Vui lòng đúng thông tin")
                   cell.updateWrongLabelTextColor(UIColor.red)
                   allFieldsValid = false
                   nextBtnImageView.alpha = 0.5
                   infoNextBtn.isEnabled = false
                   return
               }
               validTextFieldCount += 1
           }
           // Chỉ lưu dữ liệu nếu tất cả các textfield đều hợp lệ
           if validTextFieldCount == 3 {
               for section in 0...2 {
                   let indexPath = IndexPath(row: 0, section: section)
                   guard let cell = tableView.cellForRow(at: indexPath) as? InfoUserTableViewCell else {
                       continue
                   }
                   cell.updateWrongLabelText("")
                   cell.saveCellData()
               }
               nextBtnImageView.alpha = 1
               infoNextBtn.isEnabled = true
           }
        // Kiểm tra section 5
        let indexPath = IndexPath(row: 0, section: 5)
        if let cell = tableView.cellForRow(at: indexPath) as? InfoUserTableViewCell {
            if let text = cell.getInfoTextFieldText(), !isValidEmail(text) {
                cell.updateWrongLabelText("Email không hợp lệ")
                cell.updateWrongLabelTextColor(UIColor.red)
                allFieldsValid = false
            } else {
                cell.updateWrongLabelText("")
                cell.saveCellData()
            }
        }
        if allFieldsValid {
            let alertController = UIAlertController(title: "Lưu dữ liệu thành công", message: nil, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
    }

    @IBAction func didTapDoneBtn(_ sender: Any) {
        self.checkTextFieldValid()
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
            guard let cell = tableView.dequeueReusableCell(withIdentifier: InfoUserTableViewCell.indentifier, for: indexPath) as? InfoUserTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: currentData, isDropDownButtonHidden: true, isUserInteractionEnabled: true, selectionStyle: .none, section: sectionNumber, indexPath: indexPath)
            cell.delegate = self
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: GenderTableViewCell.indentifier, for: indexPath) as? GenderTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: currentData, selectionStyle: .none)
            cell.delegate = self
            return cell
        case 6...10:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: InfoUserTableViewCell.indentifier, for: indexPath) as? InfoUserTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: currentData, isDropDownButtonHidden: false, isUserInteractionEnabled: false, selectionStyle: .none, section: sectionNumber, indexPath: indexPath)
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension InfoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.AllinfoVC.infoCellHeight
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
           [0, 1, 2, 5].contains(indexPath.section),
           cell.isEditingTextField,
           let updatedText = cell.getInfoTextFieldText(), !updatedText.isEmpty {
            cell.updateWrongLabelText("")
            nextBtnImageView.alpha = 1.0
            infoNextBtn.isEnabled = true
        }
    }
    func datePickerDidChange(_ cell: InfoUserTableViewCell) {
           if let indexPath = tableView.indexPath(for: cell),
              indexPath.section == 2,
              let updatedText = cell.getInfoTextFieldText(), !updatedText.isEmpty {
               cell.updateWrongLabelText("")
               nextBtnImageView.alpha = 1.0
               infoNextBtn.isEnabled = true
           }
       }
    func segmentedControlDidChange(_ cell: GenderTableViewCell) {
        nextBtnImageView.alpha = 1.0
        infoNextBtn.isEnabled = true
    }
}
