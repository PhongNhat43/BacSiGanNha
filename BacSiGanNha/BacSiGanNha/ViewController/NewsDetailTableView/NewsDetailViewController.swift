//
//  NewsDetailViewController.swift
//  BacSiGanNha
//
//  Created by devsenior on 09/08/2023.
//

import UIKit

class NewsDetailViewController: UIViewController {
    
    // MARK: - Outlet
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Property
    var newsArr = [ArticleList]()

    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
    }
    
    func getData() {
        APICaller.sharedInstance.fetchingAPIData { articleData, promotionData, doctorData in
                self.newsArr = articleData
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
        }
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewsTableViewCell.nib(), forCellReuseIdentifier: NewsTableViewCell.indentifier)
        tableView.register(NewsBigCellTableViewCell.nib(), forCellReuseIdentifier: NewsBigCellTableViewCell.indentifier)
    }
    
    func setupNavigation() {
        self.navigationItem.title = "Tin Tức"
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
}

extension NewsDetailViewController: UITableViewDataSource {
        func numberOfSections(in tableView: UITableView) -> Int {
            return newsArr.count
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if indexPath.section == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: NewsBigCellTableViewCell.indentifier, for: indexPath) as! NewsBigCellTableViewCell
                let data = newsArr[indexPath.section]
                cell.configure(data: data)
                return cell
            }
            
            if indexPath.section != 0  {
                let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.indentifier, for: indexPath) as! NewsTableViewCell
                let data = newsArr[indexPath.section]
                cell.configure(data: data)
                return cell
            }
            return UITableViewCell()
        }
}

extension NewsDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let dataNews = newsArr[indexPath.row]
        let urlString = dataNews.link.replacingOccurrences(of: "bvsoft.vn", with: "jiohealth.com")
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
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 300
        default:
            return 102
        }
    }

}
