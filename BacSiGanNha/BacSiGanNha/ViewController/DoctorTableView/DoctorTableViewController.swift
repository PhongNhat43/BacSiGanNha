//
//  DoctorTableViewController.swift
//  BacSiGanNha
//
//  Created by devsenior on 09/08/2023.
//

import UIKit

class DoctorTableViewController: UIViewController {
    // MARK: - Outlet
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Property
    var doctorArr = [DoctorList]()
    var isLoading = false
    var isAllDataLoaded = false 
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
        configureRefreshControl()
    }
    
    func getData() {
        APICaller.sharedInstance.fetchingAPIData { articleData, promotionData, doctorData in
                self.doctorArr = doctorData
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
    }
    
    func loadMoreData() {
        if !self.isLoading && doctorArr.count > 0 {
            self.isLoading = true
            DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(1)) {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.isLoading = false
                }
            }
        }
    }

    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DoctorTableViewCell.nib(), forCellReuseIdentifier: DoctorTableViewCell.indentifier)
        tableView.register(LoadingCell.nib(), forCellReuseIdentifier: LoadingCell.indentifier)
    }
    
    func configureRefreshControl() {
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action:
                                          #selector(handleRefreshControl),
                                          for: .valueChanged)
    }
  
    @objc func handleRefreshControl() {
       getData()
       DispatchQueue.main.async {
          self.tableView.refreshControl?.endRefreshing()
       }
    }
    
    func setupNavigation() {
        self.navigationItem.title = "Bác sĩ"
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

extension DoctorTableViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return doctorArr.count
        } else if section == 1 {
            let totalRowHeight = CGFloat(doctorArr.count) * 105
            if totalRowHeight < tableView.frame.height {
                return 0
            } else {
                return 1
            }
        } else {
            return 0
        }
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: DoctorTableViewCell.indentifier, for: indexPath) as! DoctorTableViewCell
            let data = doctorArr[indexPath.row]
            cell.configure(data: data)
            return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: LoadingCell.indentifier, for: indexPath) as! LoadingCell
                cell.activityIndicatorLoad.startAnimating()
                return cell
            }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == doctorArr.count - 10, !isLoading {
            loadMoreData()
        }
    }
}

extension DoctorTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 105
        } else {
            return 115
        }
    }
    
    
}
