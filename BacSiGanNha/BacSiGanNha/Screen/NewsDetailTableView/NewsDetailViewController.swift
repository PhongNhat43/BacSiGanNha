//
//  NewsDetailViewController.swift
//  BacSiGanNha
//
//  Created by devsenior on 09/08/2023.
//

import UIKit

class NewsDetailViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    var newsArr = [ArticleList]()

    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        setupTableView()
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
        self.navigationItem.leftBarButtonItems = [UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(backButtonTapped))]
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
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        let dataNews = newsArr[indexPath.row]
//        let urlString = dataNews.link.replacingOccurrences(of: "bvsoft.vn", with: "jiohealth.com")
//        guard let url = URL(string: urlString) else { return }
//        let vc = SFSafariViewController(url: url)
//        present(vc, animated: true)
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 300
        default:
            return 102
        }
    }

}
