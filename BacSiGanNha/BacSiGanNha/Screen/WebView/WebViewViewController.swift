//
//  WebViewViewController.swift
//  BacSiGanNha
//
//  Created by devsenior on 10/08/2023.
//

import UIKit
import WebKit

class WebViewViewController: UIViewController {
    // MARK: - Outlet
    @IBOutlet weak var webView: WKWebView!
    
    // MARK: - Property
    var url: URL?
    var titleString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigation()
        
        if let url = url {
            let request = URLRequest(url: url)
            webView.load(request)
        }
        
        if let titleString = titleString {
            navigationItem.title = titleString
        }
    }

    
    func setupNavigation() {
        self.navigationItem.leftBarButtonItems = [UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(backButtonTapped))]
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "share"), style: .plain, target: self, action: #selector(shareButtonTapped))
    }

    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func shareButtonTapped() {
        guard let urlString = url?.absoluteString else { return }
        let activityViewController = UIActivityViewController(activityItems: [urlString], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }

}
