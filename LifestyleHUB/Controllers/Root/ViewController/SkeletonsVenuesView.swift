//
//  SkeletonsVenuesView.swift
//  LifestyleHUB
//
//  Created by Иван Лукъянычев on 24.03.2024.
//

import UIKit

class SkeletonsVenuesView: UIView {
    
    let firstView = SkeletonVenuesView()
    let secondView = SkeletonVenuesView()
    let thirdView = SkeletonVenuesView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        
        addSubview(firstView)
        addSubview(secondView)
        addSubview(thirdView)
        
        NSLayoutConstraint.activate([
            firstView.heightAnchor.constraint(equalToConstant: 200),
            firstView.widthAnchor.constraint(equalTo: widthAnchor, constant: -32),
            firstView.centerXAnchor.constraint(equalTo: centerXAnchor),
            firstView.topAnchor.constraint(equalTo: topAnchor),
            
            secondView.heightAnchor.constraint(equalToConstant: 200),
            secondView.widthAnchor.constraint(equalTo: widthAnchor, constant: -32),
            secondView.centerXAnchor.constraint(equalTo: centerXAnchor),
            secondView.topAnchor.constraint(equalTo: firstView.bottomAnchor, constant: 10),
            
            thirdView.heightAnchor.constraint(equalToConstant: 200),
            thirdView.widthAnchor.constraint(equalTo: widthAnchor, constant: -32),
            thirdView.centerXAnchor.constraint(equalTo: centerXAnchor),
            thirdView.topAnchor.constraint(equalTo: secondView.bottomAnchor, constant: 10)
        ])
    }
}

class SkeletonVenuesView: UIView, SkeletonLoadable {
    
    let categorySkeleton: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.3)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 7
        view.layer.cornerCurve = .continuous
        view.clipsToBounds = true
        return view
    }()
    
    let labelSkeleton: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.3)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.layer.cornerCurve = .continuous
        view.clipsToBounds = true
        return view
    }()
    
    let townSkeleton: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.3)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 7
        view.layer.cornerCurve = .continuous
        view.clipsToBounds = true
        return view
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let contentViewLayer = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentViewLayer.frame = contentView.bounds
    }
    
    private func configureUI() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 20
        layer.cornerCurve = .continuous
        layer.masksToBounds = true
        
        contentViewLayer.startPoint = CGPoint(x: 0, y: 0.5)
        contentViewLayer.endPoint = CGPoint(x: 1, y: 0.5)
        contentView.layer.addSublayer(contentViewLayer)
        
        let layerGroupe = makeAnimationGroup(color1: UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 0.1),
                                             color2: UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 0.4))
        layerGroupe.beginTime = 0.0
        contentViewLayer.add(layerGroupe, forKey: "backgroundColor")
        
        addSubview(contentView)
        addSubview(categorySkeleton)
        addSubview(labelSkeleton)
        addSubview(townSkeleton)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            categorySkeleton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            categorySkeleton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 17),
            categorySkeleton.heightAnchor.constraint(equalToConstant: 15),
            categorySkeleton.widthAnchor.constraint(equalToConstant: 70),
            
            townSkeleton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            townSkeleton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            townSkeleton.widthAnchor.constraint(equalToConstant: 50),
            townSkeleton.heightAnchor.constraint(equalToConstant: 15),
            
            labelSkeleton.bottomAnchor.constraint(equalTo: categorySkeleton.topAnchor, constant: -5),
            labelSkeleton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            labelSkeleton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -100),
            labelSkeleton.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}

