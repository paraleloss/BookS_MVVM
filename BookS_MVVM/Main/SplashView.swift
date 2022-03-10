//
//  SplashView.swift
//  BookS_MVVM
//
//  Created by Saúl Pérez on 09/03/22.
//

import Foundation
import UIKit

class SplashView: UIView{
    private var path: UIBezierPath!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        path = UIBezierPath(arcCenter: CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2), radius: self.frame.size.height/2, startAngle: deg2rad(CGFloat(180)), endAngle: deg2rad(CGFloat(180)), clockwise: true)
        
        UIColor.red.setFill()
        path.fill()
        
        UIColor.blue.setStroke()
        path.stroke()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func deg2rad(_ number: CGFloat) -> CGFloat{
        return number * .pi / 180
    }
    
    public func animateView(completion: @escaping() -> Void) {
        UIView.animate(withDuration: 1, delay: 0.5, options: [.curveEaseInOut]) {
            self.transform = CGAffineTransform(rotationAngle: self.deg2rad(180)).scaledBy(x: 2, y: 2)
            self.alpha = 0
        } completion: { _ in
            completion()
        }
    }
    
}
