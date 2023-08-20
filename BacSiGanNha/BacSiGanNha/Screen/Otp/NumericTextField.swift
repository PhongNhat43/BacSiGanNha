//
//  NumericTextField.swift
//  BacSiGanNha
//
//  Created by devsenior on 20/08/2023.
//

import UIKit

class NumericOTPTextField: OTPTextField {
    override func paste(_ sender: Any?) {
        if let string = UIPasteboard.general.string {
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            if allowedCharacters.isSuperset(of: characterSet) {
                super.paste(sender)
            }
        }
    }
}
