//
//  ExtensionLoading.swift
//  BacSiGanNha
//
//  Created by devsenior on 10/08/2023.
//

import Foundation
import UIKit

extension UIViewController {
    func loader() -> UIAlertController {
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        let indicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        indicator.style = UIActivityIndicatorView.Style.large
        alert.view?.addSubview(indicator)
        present(alert, animated: true, completion: nil)
        return alert
        
    }
    
    func stopLoader(loader: UIAlertController) {
        DispatchQueue.main.async {
            loader.dismiss(animated: true, completion: nil)
        }
    }
}
