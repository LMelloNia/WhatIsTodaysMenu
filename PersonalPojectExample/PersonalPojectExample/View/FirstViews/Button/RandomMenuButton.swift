//
//  RandomMenuButton.swift
//  PersonalPojectExample
//
//  Created by 김시훈 on 2023/03/14.
//

import UIKit

@IBDesignable
class RandomMenuButton: UIButton {

    @IBInspectable
    var conerRadius: CGFloat {
        get {
            layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
}
