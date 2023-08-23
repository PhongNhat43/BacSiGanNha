//
//  OTPTextField.swift
//  BacSi_App
//
//  Created by devsenior on 06/08/2023.
//

import UIKit

class OTPTextField: UITextField {
    weak var previousTextField: UITextField?
       weak var nextTextField: UITextField?

       override func deleteBackward() {
           if text?.isEmpty ?? true {
               previousTextField?.becomeFirstResponder()
           }
           super.deleteBackward()
       }
}
