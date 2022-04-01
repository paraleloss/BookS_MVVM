//
//  UIView+Extansions.swift
//  BookS_MVVM
//
//  Created by Saúl Pérez on 31/03/22.
//

import Foundation
import UIKit

extension UIView {
    
    func dropShadow() {
        layer.cornerRadius = 4
        clipsToBounds = true
        layer.masksToBounds = false
        layer.shadowRadius = 7
        layer.shadowOpacity = 0.6
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowColor = UIColor.black.cgColor
    }
    
}
