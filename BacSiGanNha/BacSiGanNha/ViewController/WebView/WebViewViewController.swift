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
    @IBOutlet private weak var webView: WKWebView!
    private var activityIndicator: UIActivityIndicatorView?
    // MARK: - Property
    var url: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupWebView()
        if let url = url {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    func setupWebView() {
        webView.navigationDelegate = self
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator?.center = view.center
        view.addSubview(activityIndicator!)
    }
    
    func setupNavigation() {
        // Thiết lập nút bên trái
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "back"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        let backBarButton = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem = backBarButton
        
        // Thiết lập nút bên phải
        let rightButton = UIButton(type: .custom)
        rightButton.setImage(UIImage(named: "share"), for: .normal)
        rightButton.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        let rightBarButton = UIBarButtonItem(customView: rightButton)
        self.navigationItem.rightBarButtonItem = rightBarButton
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

extension WebViewViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
         activityIndicator?.startAnimating()
    }
       
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
           activityIndicator?.stopAnimating()
    }
       
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
           activityIndicator?.stopAnimating()
    }
}
