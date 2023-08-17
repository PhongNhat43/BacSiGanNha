//
//  ExtensionLoading.swift
//  BacSiGanNha
//
//  Created by devsenior on 10/08/2023.
//

import Foundation
import UIKit

//extension String {
//    static func heightOfLabel(text: String, font: UIFont, maxWidth: CGFloat, lines: Int = 0) -> CGFloat {
//            let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: maxWidth, height: CGFloat.greatestFiniteMagnitude))
//            label.numberOfLines = lines
//            label.lineBreakMode = NSLineBreakMode.byWordWrapping
//            label.text = text
//            label.font = font
//            label.sizeToFit()
//            return label.frame.height
//        }
//
//    static func heightLabelWithLineHeight(text: String, font: UIFont, maxWidth: CGFloat, lines: CGFloat) -> CGFloat {
//            if text.count > 0 {
//                let attrString = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.font: font])
//                let style = NSMutableParagraphStyle()
//                style.lineHeightMultiple = lines
//                attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSRange(location: 0, length: text.count - 1))
//                attrString.addAttribute(NSAttributedString.Key.font, value: font, range: NSRange(location: 0, length: text.count - 1))
//                let width = Constants.ScreenSize.SCREEN_WIDTH
//                let rect = attrString.boundingRect(with: CGSize(width: width - maxWidth, height: CGFloat.greatestFiniteMagnitude), options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
//                return rect.height
//            }
//            return 0
//        }
//}


