//
//  PromotionDeatailTableView.swift
//  BacSiGanNha
//
//  Created by devsenior on 09/08/2023.
//

import UIKit

class PromotionDeatailTableView: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    var promotionArr = [PromotionList]()

    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        setupTableView()
        setupNavigation()
        view.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
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
        self.navigationItem.leftBarButtonItems = [UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(backButtonTapped))]
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
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        let data = promotionArr[indexPath.row]
//        guard let url = URL(string: data.link ?? "") else { return }
//        let vc = SFSafariViewController(url: url)
//        present(vc, animated: true)
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 102
    }
}
