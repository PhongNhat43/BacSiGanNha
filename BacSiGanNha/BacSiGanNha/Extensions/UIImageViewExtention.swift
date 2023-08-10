//
//  UIImageViewExtention.swift
//  News_App
//
//  Created by devsenior on 18/03/2023.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    func setImage(imageUrl: String) {
        self.kf.setImage(with: URL(string: imageUrl))
    }

}
