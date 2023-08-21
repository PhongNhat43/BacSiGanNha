//
//  PromotionDeatailTableView.swift
//  BacSiGanNha
//
//  Created by devsenior on 09/08/2023.
//

import UIKit

class PromotionDeatailTableView: UIViewController {
    
    // MARK: - Outlet
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Property
    var promotionArr = [PromotionList]()

    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        setupTableView()
       
        view.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
    }
    
    func getData() {
        APICaller.sharedInstance.fetchingAPIData { articleData, promotionData, doctorData in
                self.promotionArr = promotionData
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
        }
    }
    
    func setupNavigation() {
        self.navigationItem.title = "Danh sách khuyến mại"
        if let navigationBar = self.navigationController?.navigationBar {
            let titleTextAttributes: [NSAttributedString.Key: Any] = [
                    .foregroundColor: UIColor(red: 0.141, green: 0.165, blue: 0.38, alpha: 1),
                    .font: UIFont(name: "NunitoSans-Bold", size: 18) ?? UIFont.boldSystemFont(ofSize: 18),
                    .paragraphStyle: { () -> NSMutableParagraphStyle in
                        let paragraphStyle = NSMutableParagraphStyle()
                        paragraphStyle.lineHeightMultiple = 0.81
                        return paragraphStyle
                    }()
                ]
        navigationBar.titleTextAttributes = titleTextAttributes
        }
        // Thiết lập nút bên trái
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "back"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        let backBarButton = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem = backBarButton
        if let navigationBar = self.navigationController?.navigationBar {
            let borderView = UIView(frame: CGRect(x: 0, y: navigationBar.frame.height - 1, width: navigationBar.frame.width, height: 1))
            borderView.backgroundColor = UIColor(red: 0.933, green: 0.937, blue: 0.957, alpha: 1)
            navigationBar.addSubview(borderView)
        }
    }

    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PromotionTableViewCell.nib(), forCellReuseIdentifier: PromotionTableViewCell.indentifier)
    }
}

extension PromotionDeatailTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return promotionArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PromotionTableViewCell.indentifier, for: indexPath) as! PromotionTableViewCell
        let data = promotionArr[indexPath.row]
        cell.configure(data: data)
        return cell
    }
}

extension PromotionDeatailTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let dataPromotion = promotionArr[indexPath.row]
        let urlString = dataPromotion.link.replacingOccurrences(of: "bvsoft.vn", with: "jiohealth.com")
        guard let url = URL(string: urlString) else { return }
        let webViewVC = WebViewViewController()
        webViewVC.url = url
        let titleLabel = UILabel()
        titleLabel.text =  "Chi tiết Khuyến mãi"
        titleLabel.font = UIFont(name: "NunitoSans-Bold", size: 18)
        titleLabel.textColor = .black
        titleLabel.sizeToFit()
        webViewVC.navigationItem.titleView = titleLabel
        navigationController?.pushViewController(webViewVC, animated: true)
        navigationController?.isNavigationBarHidden = false
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 102
    }
}
