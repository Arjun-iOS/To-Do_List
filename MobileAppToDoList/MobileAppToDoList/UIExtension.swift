//
//  UIExtension.swift
//  MobileAppToDoList
//
//  Created by ADMIN on 19/06/23.
//

import Foundation
import UIKit

extension UIView {

    @IBInspectable var shadow: Bool {
        get {
            return layer.shadowOpacity > 0.0
        }
        set {
            if newValue {
                self.addShadow()
            }
        }
    }

    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue

            // Don't touch the masksToBounds property if a shadow is needed in addition to the cornerRadius
            if !shadow {
                self.layer.masksToBounds = true
            }
        }
    }

    @IBInspectable var borderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }

    @IBInspectable var borderColor: UIColor? {
        get {
            return self.layer.borderColor.map { UIColor(cgColor: $0) }
        }
        set {
            self.layer.borderColor = newValue?.cgColor
        }
    }

    func addShadow(shadowColor: CGColor = UIColor.black.cgColor,
                   shadowOffset: CGSize = CGSize(width: 1.0, height: 2.0),
                   shadowOpacity: Float = 0.4,
                   shadowRadius: CGFloat = 3.0) {
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
    }
}
