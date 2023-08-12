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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        setupTableView()
        setupNavigation()
    }
    
    func getData() {
        APICaller.sharedInstance.fetchingAPIData { articleData, promotionData, doctorData in
                self.doctorArr = doctorData
              
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DoctorTableViewCell.nib(), forCellReuseIdentifier: DoctorTableViewCell.indentifier)
    }
    
    func setupNavigation() {
        self.navigationItem.title = "Bác sĩ"
        self.navigationItem.leftBarButtonItems = [UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(backButtonTapped))]
       
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return doctorArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DoctorTableViewCell.indentifier, for: indexPath) as! DoctorTableViewCell
        let data = doctorArr[indexPath.row]
        cell.configure(data: data)
        return cell
    }
    
}

extension DoctorTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }
}
