//
//  LoadingCell.swift
//  BacSiGanNha
//
//  Created by devsenior on 24/08/2023.
//

import UIKit

class LoadingCell: UITableViewCell {
    
    static let indentifier = "LoadingCell"
    static func nib() -> UINib {
       return UINib(nibName: "LoadingCell", bundle: nil)
    }

    @IBOutlet weak var activityIndicatorLoad: UIActivityIndicatorView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
