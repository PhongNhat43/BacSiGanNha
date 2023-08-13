//
//  ViewController.swift
//  BacSiGanNha
//
//  Created by devsenior on 07/08/2023.
//

import UIKit

class IntroViewController: UIViewController {
    
    // MARK: - Outlet
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var introPageControl: UIPageControl!
    @IBOutlet weak var heightOfIntroContrains: NSLayoutConstraint!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    
    // MARK: - Property
    var intros: [Intro] = []
    
    var timer: Timer?
    var currentCellIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        fillData()
        setupPage()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupUI()
    }
    
    func setupPage(){
        introPageControl.currentPage = 0
        introPageControl.numberOfPages = intros.count
    }
    
    func setupUI() {
        navigationController?.navigationBar.isHidden = true
        // Thiết lập thuộc tính cho nút loginBtn
        loginBtn.layer.backgroundColor = UIColor(red: 0.173, green: 0.525, blue: 0.404, alpha: 1).cgColor
        loginBtn.layer.cornerRadius = 24
        loginBtn.setTitle("Đăng Nhập", for: .normal)
        loginBtn.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        loginBtn.titleLabel?.font = UIFont(name: "NunitoSans-Bold", size: 15)
        let paragraphStyleLogin = NSMutableParagraphStyle()
        paragraphStyleLogin.lineHeightMultiple = 0.95
        loginBtn.titleLabel?.textAlignment = .center
               
        // Thiết lập thuộc tính cho nút registerBtn
        registerBtn.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        registerBtn.layer.cornerRadius = 24
        registerBtn.setTitle("Tạo tài khoản", for: .normal)
        registerBtn.layer.borderWidth = 1
        registerBtn.layer.borderColor = UIColor(red: 0.141, green: 0.165, blue: 0.38, alpha: 1).cgColor
        registerBtn.setTitleColor(UIColor(red: 0.141, green: 0.165, blue: 0.38, alpha: 1), for: .normal)
        registerBtn.titleLabel?.font = UIFont(name: "NunitoSans-Bold", size: 15)
        let paragraphStyleRegister = NSMutableParagraphStyle()
        paragraphStyleRegister.lineHeightMultiple = 0.95
        registerBtn.titleLabel?.textAlignment = .center
    }
    
    // fill data to model
    func fillData() {
      intros = [Intro(title: "Bác sĩ sẵn lòng chăm sóc khi bạn cần", description: "Chọn chuyên khoa, bác sĩ phù hợp và được thăm khám trong không gian thoải mái tại nhà", image: "Intro1"),
                Intro(title: "Bác sĩ sẵn lòng chăm sóc khi bạn cần", description: "Chọn chuyên khoa, bác sĩ phù hợp và được thăm khám trong không gian thoải mái tại nhà", image: "Intro2"),
                Intro(title: "Bác sĩ sẵn lòng chăm sóc khi bạn cần", description: "Chọn chuyên khoa, bác sĩ phù hợp và được thăm khám trong không gian thoải mái tại nhà", image: "Intro3")
      ]
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(moveToNextIndex), userInfo: nil, repeats: true)
        
    }
    
    @objc func moveToNextIndex() {
        currentCellIndex += 1
        collectionView.scrollToItem(at: IndexPath(item: currentCellIndex, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    func setupCollectionView(){
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    
    @IBAction func didTapLoginBtn(_ sender: Any) {
        let vc = LoginViewController(nibName: "LoginViewController", bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
        navigationController?.navigationBar.isHidden = false
    }
}

// MARK: - CollectionView
extension IntroViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return intros.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! IntroCollectionViewCell
        let data = intros[indexPath.item]
        cell.configure(data: data)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? IntroCollectionViewCell else {
            fatalError("Failed to dequeue NewsCollectionViewCell")
        }
        let totalHeight = cell.calculateCellHeight()
        heightOfIntroContrains.constant = totalHeight + 10
        print("doctorCollectionView Cell - Width: \(collectionView.frame.width), Height: \(totalHeight)")
        return CGSize(width: collectionView.frame.width, height: totalHeight)
       
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        introPageControl.currentPage = indexPath.row
    }
    
}

