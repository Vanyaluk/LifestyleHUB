//
//  SkeletonLoadable.swift
//  LifestyleHUB
//
//  Created by Иван Лукъянычев on 24.03.2024.
//

import UIKit

protocol SkeletonLoadable {}

extension SkeletonLoadable {
    func makeAnimationGroup(color1: UIColor? = nil, color2: UIColor? = nil, previousGroup: CAAnimationGroup? = nil) -> CAAnimationGroup {
        let animDuration: CFTimeInterval = 1.0
        let anim1 = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.backgroundColor))
        if let color1 {
            anim1.fromValue = color1.cgColor
        } else {
            anim1.fromValue = UIColor(red: 200 / 255.0, green: 200 / 255.0, blue: 200 / 255.0, alpha: 1).cgColor
        }
        
        if let color2 {
            anim1.toValue = color2.cgColor
        } else {
            anim1.toValue = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.2).cgColor
        }
        anim1.duration = animDuration
        anim1.beginTime = 0.0

        let anim2 = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.backgroundColor))
        anim2.fromValue = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.2).cgColor
        if let color2 {
            anim2.fromValue = color2.cgColor
        } else {
            anim2.fromValue = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.2).cgColor
        }
        
        if let color1 {
            anim2.toValue = color1.cgColor
        } else {
            anim2.toValue = UIColor(red: 200 / 255.0, green: 200 / 255.0, blue: 200 / 255.0, alpha: 1).cgColor
        }
        anim2.duration = animDuration
        anim2.beginTime = anim1.beginTime + anim1.duration

        let group = CAAnimationGroup()
        group.animations = [anim1, anim2]
        group.repeatCount = .greatestFiniteMagnitude // infinite
        group.duration = anim2.beginTime + anim2.duration
        group.isRemovedOnCompletion = false

        if let previousGroup = previousGroup {
            group.beginTime = previousGroup.beginTime + 0.2
        }

        return group
    }
}

