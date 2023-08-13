//
//  ViewController.swift
//  BacSiGanNha
//
//  Created by devsenior on 07/08/2023.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Outlet
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var introPageControl: UIPageControl!
    @IBOutlet weak var heightOfIntroContrains: NSLayoutConstraint!
    // MARK: - Property
    var intros: [Intro] = []
    
    var timer: Timer?
    var currentCellIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        fillData()
        setupPage()
//        startTimer()
    }
    
    func setupPage(){
        introPageControl.currentPage = 0
        introPageControl.numberOfPages = intros.count
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
//        vc.modalPresentationStyle = .fullScreen
//        present(vc, animated: true, completion: nil)
        navigationController?.pushViewController(vc, animated: true)

    }
}

// MARK: - CollectionView
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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

