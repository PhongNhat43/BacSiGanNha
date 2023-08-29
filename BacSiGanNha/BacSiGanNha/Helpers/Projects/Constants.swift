//
//  constants.swift
//  BacSiGanNha
//
//  Created by devsenior on 21/08/2023.
//

import Foundation
import UIKit
struct Constants {
    
    struct Font {
        static let regular = "NunitoSans-Regular"
        static let light = "NunitoSans-Light"
        static let semiBold = "NunitoSans-SemiBold"
        static let bold = "NunitoSans-Bold"
    }
    
    struct AllPromotionVC{
        static let newsCellHeight: CGFloat = 103
    }

    struct AllNewsVC {
        static let newsCellHeight: CGFloat = 103
        static let newsBigCellHeight: CGFloat = 300
    }

    struct AllDoctorVC {
        static let doctorCellHeight: CGFloat = 105
    }
    
    struct AllHomePage {
        static let spacingCell: CGFloat = 12
    }
    
    struct AllinfoVC {
        static let infoCellHeight: CGFloat = 85
    }
    
    struct Icon {
        static let iconError = UIImage(named: "icon-toast-error")
        static let iconSusses = UIImage(named: "icon-toast-success")
        static let iconWarning = UIImage(named: "icon-toast-warning")
        static let iconNormal = UIImage(named: "icon-toast-normal")
    }

}

