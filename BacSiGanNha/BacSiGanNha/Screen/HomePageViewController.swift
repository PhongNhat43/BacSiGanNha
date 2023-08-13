//
//  HomePageViewController.swift
//  BacSiGanNha
//
//  Created by devsenior on 08/08/2023.
//

import UIKit
import Alamofire
class HomePageViewController: UIViewController {
    
    // MARK: - Outlet
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var homePageImageView: UIImageView!
    @IBOutlet weak var homePageScrollView: UIScrollView!
    @IBOutlet weak var roundView: UIView!
    @IBOutlet weak var doctorCollectionView: UICollectionView!
    @IBOutlet weak var promotionCollectionView: UICollectionView!
    @IBOutlet weak var newsCollectionView: UICollectionView!
    @IBOutlet weak var heightOfNewsConstraint: NSLayoutConstraint!
    @IBOutlet weak var hegihtofPromotion: NSLayoutConstraint!
    @IBOutlet weak var heightOfDoctor: NSLayoutConstraint!
    
    // MARK: - Property
    var newsArr = [ArticleList]()
    var promotionArr = [PromotionList]()
    var doctorArr = [DoctorList]()
    var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollecitonView()
        setupUI()
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = self.view.center
        self.view.addSubview(activityIndicator)
        getData()
        
    }
    
    func setupUI() {
        roundView.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        roundView.layer.cornerRadius = 15
        roundView.layer.borderWidth = 1
        roundView.layer.borderColor = UIColor.red.cgColor
        roundView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    func setupCollecitonView() {
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
    }
    
    
    func getData() {
        activityIndicator.startAnimating()
        APICaller.sharedInstance.fetchingAPIData { articleData, promotionData, doctorData in
            self.newsArr = articleData
            self.promotionArr = promotionData
            self.doctorArr = doctorData
            
            DispatchQueue.main.async {
                self.newsCollectionView.reloadData()
                self.promotionCollectionView.reloadData()
                self.doctorCollectionView.reloadData()
                self.activityIndicator.stopAnimating()
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
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            navigationController?.isNavigationBarHidden = true
        }
}

extension HomePageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var urlString: String?
        var titleString: String?
        
        switch collectionView {
        case newsCollectionView:
            let dataNews = newsArr[indexPath.row]
            urlString = dataNews.link.replacingOccurrences(of: "bvsoft.vn", with: "jiohealth.com")
            titleString = "Chi tiết tin tức"
            
        case promotionCollectionView:
            let dataPromotion = promotionArr[indexPath.row]
            urlString = dataPromotion.link.replacingOccurrences(of: "bvsoft.vn", with: "jiohealth.com")
            titleString = "Chi tiết khuyến mại"
            
        default:
            break
        }
        
        if let urlString = urlString, let url = URL(string: urlString) {
            let webViewController = WebViewViewController(nibName: "WebViewViewController", bundle: nil)
            webViewController.url = url
            webViewController.titleString = titleString // Thiết lập titleString
            navigationController?.pushViewController(webViewController, animated: true)
        }
    }

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
            let cellWidth: CGFloat = 258
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCollectionViewCell", for: indexPath) as? NewsCollectionViewCell else {
                fatalError("Failed to dequeue NewsCollectionViewCell")
            }
            let totalHeight = cell.calculateCellHeight()
            heightOfNewsConstraint.constant = totalHeight
            print("newsCollectionView Cell - Width: \(cellWidth), Height: \(totalHeight)")
            return CGSize(width: cellWidth, height: totalHeight + 10)
            
        case promotionCollectionView:
            let cellWidth: CGFloat = 258
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PromotionCollectionViewCell", for: indexPath) as? PromotionCollectionViewCell else {
                fatalError("Failed to dequeue NewsCollectionViewCell")
            }
            let totalHeight = cell.calculateCellHeight()
            hegihtofPromotion.constant = totalHeight
            print("promotionCollectionView Cell - Width: \(cellWidth), Height: \(totalHeight)")
            return CGSize(width: cellWidth, height: totalHeight + 10)
            
        case doctorCollectionView:
            let cellWidth: CGFloat = 121
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DoctorCollectionViewCell", for: indexPath) as? DoctorCollectionViewCell else {
                fatalError("Failed to dequeue NewsCollectionViewCell")
            }
            let totalHeight = cell.calculateCellHeight()
            heightOfDoctor.constant = totalHeight
            print("doctorCollectionView Cell - Width: \(cellWidth), Height: \(totalHeight)")
            return CGSize(width: cellWidth, height: totalHeight + 10)
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


