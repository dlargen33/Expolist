//
//  UIView+Extensions.swift
//  Expolist
//
//  Created by Donald Largen on 5/1/24.
//

import Foundation
import UIKit

extension UIView {
    
    func add(view: UIView, constraints: [NSLayoutConstraint]) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        NSLayoutConstraint.activate(constraints)
    }
    
    func constraintToEdges(view: UIView, padding: CGFloat = 0.0) {
        view.translatesAutoresizingMaskIntoConstraints = false

        addSubview(view)
        NSLayoutConstraint.activate([view.topAnchor.constraint(equalTo: topAnchor, constant: padding),
                                     view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
                                     view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
                                     view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding)])
    }
    
    func height(constant: CGFloat) {
        setConstraint(value: constant, attribute: .height)
    }
      
    func width(constant: CGFloat) {
        setConstraint(value: constant, attribute: .width)
    }
    
    func shake() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))
        self.layer.add(animation, forKey: "position")
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius))
        
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
      
    private func removeConstraint(attribute: NSLayoutConstraint.Attribute) {
        constraints.forEach {
            if $0.firstAttribute == attribute {
                removeConstraint($0)
            }
        }
    }
      
    private func setConstraint(value: CGFloat, attribute: NSLayoutConstraint.Attribute) {
        removeConstraint(attribute: attribute)
        let constraint =
          NSLayoutConstraint(item: self,
                             attribute: attribute,
                             relatedBy: .equal,
                             toItem: nil,
                             attribute: .notAnAttribute,
                             multiplier: 1,
                             constant: value)
        self.addConstraint(constraint)
      }
}
