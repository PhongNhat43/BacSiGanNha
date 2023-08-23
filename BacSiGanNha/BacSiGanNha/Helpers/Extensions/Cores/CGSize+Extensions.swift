//
//  CGSize+Extensions.swift
//  BSGN
//
//  Created by Hoang Dinh Huy on 30/07/2021.
//

import UIKit

extension CGSize {
    
    func toPixel() -> CGSize {
        let scale = UIScreen.main.scale
        
        return CGSize(width: self.width * scale, height: self.height * scale)
    }
}
