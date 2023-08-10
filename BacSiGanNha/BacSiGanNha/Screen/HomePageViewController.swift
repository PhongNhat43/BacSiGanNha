//
//  HomePageViewController.swift
//  BacSiGanNha
//
//  Created by devsenior on 08/08/2023.
//

import UIKit
import Alamofire
class HomePageViewController: UIViewController {
    
    var newsArr = [ArticleList]()
    var promotionArr = [PromotionList]()
    var doctorArr = [DoctorList]()
    
    @IBOutlet weak var homePageScrollView: UIScrollView!
    @IBOutlet weak var roundView: UIView!
    @IBOutlet weak var doctorCollectionView: UICollectionView!
    @IBOutlet weak var promotionCollectionView: UICollectionView!
    @IBOutlet weak var newsCollectionView: UICollectionView!
    @IBOutlet weak var heightOfNewsConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightOfPromotionConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        setupCollecitonView()
//        roundView.layer.cornerRadius = 8
//        roundView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        roundView.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        roundView.layer.cornerRadius = 10
        roundView.layer.borderWidth = 1
        roundView.layer.borderColor = UIColor.red.cgColor
        roundView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            
        
    }
    
    func setupCollecitonView(){
        newsCollectionView.delegate = self
        newsCollectionView.dataSource = self
        newsCollectionView.register(NewsCollectionViewCell.nib(), forCellWithReuseIdentifier: NewsCollectionViewCell.indentifier)
        
        promotionCollectionView.delegate = self
        promotionCollectionView.dataSource = self
        promotionCollectionView.register(PromotionCollectionViewCell.nib(), forCellWithReuseIdentifier: PromotionCollectionViewCell.indentifier)
        
        doctorCollectionView.delegate = self
        doctorCollectionView.dataSource = self
        doctorCollectionView.register(DoctorCollectionViewCell.nib(), forCellWithReuseIdentifier: DoctorCollectionViewCell.indentifier)
        
        newsCollectionView.collectionViewLayout.invalidateLayout()
        newsCollectionView.layoutIfNeeded()
        newsCollectionView.reloadData()
//        heightOfNewsConstraint.constant = 244
//        heightOfPromotionConstraint.constant = 244

    }
    
    
    func getData() {
        APICaller.sharedInstance.fetchingAPIData { articleData, promotionData, doctorData in
                self.newsArr = articleData
                self.promotionArr = promotionData
                self.doctorArr = doctorData
                
                DispatchQueue.main.async {
                    self.newsCollectionView.reloadData()
                    self.promotionCollectionView.reloadData()
                    self.doctorCollectionView.reloadData()
                }
            }
    }
    
    @IBAction func didTapNextNewsBtn(_ sender: Any) {
        let vc = NewsDetailViewController(nibName: "NewsDetailViewController", bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
        navigationController?.isNavigationBarHidden = false
    }
    
    
    @IBAction func didTapNextPromotionBtn(_ sender: Any) {
        let vc = PromotionDeatailTableView(nibName: "PromotionDeatailTableView", bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
        navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func didTapNextDoctor(_ sender: Any) {
        let vc = DoctorTableViewController(nibName: "DoctorTableViewController", bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
        navigationController?.isNavigationBarHidden = false
    }
    
    
    

}

extension HomePageViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case newsCollectionView:
            return newsArr.count
        case promotionCollectionView:
            return promotionArr.count
        case doctorCollectionView:
            return doctorArr.count
        default: return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        switch collectionView {
        case newsCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCollectionViewCell.indentifier, for: indexPath) as! NewsCollectionViewCell
            let data = newsArr[indexPath.item]
            cell.configure(data: data)
            return cell
            
        case promotionCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PromotionCollectionViewCell.indentifier, for: indexPath) as! PromotionCollectionViewCell
            let dataPromotion = promotionArr[indexPath.item]
            cell.configure(dataPromotion: dataPromotion)
            return cell
            
        case doctorCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DoctorCollectionViewCell.indentifier, for: indexPath) as! DoctorCollectionViewCell
            let dataDoctor = doctorArr[indexPath.item]
            cell.configure(dataDoctor: dataDoctor)
            return cell
            
        default: return UICollectionViewCell()
        
     }
    }
}

extension HomePageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case newsCollectionView:
            return CGSize(width: 258, height: 220)
        case promotionCollectionView:
            return CGSize(width: 258, height: 220)
        case doctorCollectionView:
            return CGSize(width: 121, height: 185)
        default: return CGSize(width: 0, height: 0)
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch collectionView {
        case newsCollectionView:
            return 12
        case promotionCollectionView:
            return 12
        case doctorCollectionView:
            return 12
        default: return 0
            
        }
    }


}
