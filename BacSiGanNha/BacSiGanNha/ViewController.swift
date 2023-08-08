//
//  ViewController.swift
//  BacSiGanNha
//
//  Created by devsenior on 07/08/2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


    @IBAction func didTapLoginBtn(_ sender: Any) {
        let vc = LoginViewController(nibName: "LoginViewController", bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
}

