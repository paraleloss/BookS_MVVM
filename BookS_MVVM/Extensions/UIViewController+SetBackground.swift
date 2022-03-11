//
//  UIViewController+SetBackground.swift
//  BookS_MVVM
//
//  Created by Saúl Pérez on 10/03/22.
//
import UIKit

extension UIViewController {

    func setBackgroundImage(_ imageName: String, contentMode: UIView.ContentMode) {
        let backgroundImage = UIImageView(frame: self.view.bounds)
        backgroundImage.image = UIImage(named: "books")
        backgroundImage.contentMode = contentMode
        backgroundImage.alpha = 0.8
        self.view.insertSubview(backgroundImage, at: 0)
        }

}


