//
//  ToastAlerView.swift
//  BacSiGanNha
//
//  Created by devsenior on 29/08/2023.
//

import UIKit

class ToastAlertView: UIView {

    enum ToastCase {
        case success
        case error
        case warning
        case normal
        
        var backGroundColor: UIColor? {
            switch self {
            case .success:
                return UIColor.green
            case .error:
                return UIColor.red
            case .warning:
                return UIColor.yellow
            case .normal:
                return UIColor.white
            }
        }
        
        var icon: UIImage? {
            switch self {
            case .success:
                return Constants.Icon.iconSusses
            case .error:
                return Constants.Icon.iconError
            case .warning:
                return Constants.Icon.iconWarning
            case .normal:
                return Constants.Icon.iconNormal
            }
        }
        
    }
    
    @IBOutlet weak var imvIcon: UIImageView!
    @IBOutlet weak var lbMessage: UILabel!
    
    var viewTransform: CGAffineTransform?
    var animationDuration: TimeInterval?
    var isDismissing = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let panGesture = UIPanGestureRecognizer()
        panGesture.addTarget(self, action: #selector(toastPanGestureHandler(_:)))
        self.addGestureRecognizer(panGesture)
    }
    
    @objc func toastPanGestureHandler(_ gesture: UIPanGestureRecognizer) {
        let location = gesture.translation(in: self)
        
        if location.y < 0 {
            transformDismiss()
        }
    }
    
    func configViews(toastCase: ToastCase, message: String) {
        self.backgroundColor = toastCase.backGroundColor
        self.imvIcon.image = toastCase.icon
        self.lbMessage.text = message
    }
    
    func configViewTransform(transform: CGAffineTransform, animationDuration: TimeInterval, displayDuration: TimeInterval) {
        self.viewTransform = transform
        self.animationDuration = animationDuration
        
        setupTransform(displayDuration: displayDuration)
    }
    
    func setupTransform(displayDuration: TimeInterval) {
        guard let viewTransform = self.viewTransform, let animationDuration = animationDuration else { return }
        
        self.transform = viewTransform
        
        UIView.animate(withDuration: animationDuration) {
            self.transform = .identity
        } completion: { _ in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + displayDuration) {[weak self] in
                guard let self = self else { return}
                self.transformDismiss()
            }
            
        }
    }
    
    func transformDismiss() {
        guard let viewTransform = self.viewTransform, let animationDuration = animationDuration else { return }
        
        guard self.isDismissing == false else { return }
        self.isDismissing = true
        UIView.animate(withDuration: animationDuration) {
            self.transform = viewTransform
        } completion: { _ in
            self.removeFromSuperview()
        }
        
    }
}

    

    
