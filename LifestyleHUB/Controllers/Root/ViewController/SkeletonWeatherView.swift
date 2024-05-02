//
//  SkeletonWeatherView.swift
//  LifestyleHUB
//
//  Created by Иван Лукъянычев on 24.03.2024.
//

import UIKit

class SkeletonWeatherView: UIView, SkeletonLoadable {
    
    private lazy var temperatureLabel: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 7
        view.clipsToBounds = true
        view.backgroundColor = .systemBackground
        return view
    }()
    
    // город + разброс
    private lazy var firstInfo: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 7
        view.clipsToBounds = true
        view.backgroundColor = .systemBackground
        return view
    }()
    
    // статус
    private lazy var statusInfo: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 7
        view.clipsToBounds = true
        view.backgroundColor = .systemBackground
        return view
    }()
    
    private lazy var feelsLikeInfo: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 7
        view.clipsToBounds = true
        view.backgroundColor = .systemBackground
        return view
    }()
    
    private lazy var weatherIcon: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 7
        view.clipsToBounds = true
        view.backgroundColor = .systemBackground
        return view
    }()
    
    private lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor(named: "gradientTop")?.cgColor ?? UIColor.red.cgColor,
            UIColor(named: "gradientBottom")?.cgColor ?? UIColor.red.cgColor
        ]
        return gradient
    }()
    
    let temperatureLayer = CAGradientLayer()
    let firstLayer = CAGradientLayer()
    let statusLayer = CAGradientLayer()
    let feelsLikeLayer = CAGradientLayer()
    let weatherIconLayer = CAGradientLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        temperatureLayer.frame = temperatureLabel.bounds
        firstLayer.frame = firstInfo.bounds
        statusLayer.frame = statusInfo.bounds
        feelsLikeLayer.frame = feelsLikeInfo.bounds
        weatherIconLayer.frame = weatherIcon.bounds
    }
    
    private func configureUI() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.insertSublayer(gradient, at: 0)
        alpha = 0.5
        
        temperatureLayer.startPoint = CGPoint(x: 0, y: 0.5)
        temperatureLayer.endPoint = CGPoint(x: 1, y: 0.5)
        firstLayer.startPoint = CGPoint(x: 0, y: 0.5)
        firstLayer.endPoint = CGPoint(x: 1, y: 0.5)
        statusLayer.startPoint = CGPoint(x: 0, y: 0.5)
        statusLayer.endPoint = CGPoint(x: 1, y: 0.5)
        feelsLikeLayer.startPoint = CGPoint(x: 0, y: 0.5)
        feelsLikeLayer.endPoint = CGPoint(x: 1, y: 0.5)
        weatherIconLayer.startPoint = CGPoint(x: 0, y: 0.5)
        weatherIconLayer.endPoint = CGPoint(x: 1, y: 0.5)
        
        temperatureLabel.layer.addSublayer(temperatureLayer)
        firstInfo.layer.addSublayer(firstLayer)
        statusInfo.layer.addSublayer(statusLayer)
        feelsLikeInfo.layer.addSublayer(feelsLikeLayer)
        weatherIcon.layer.addSublayer(weatherIconLayer)
        
        let layerGroupe1 = makeAnimationGroup(color1: UIColor(named: "gradientBottom"))
        layerGroupe1.beginTime = 0.0
        temperatureLayer.add(layerGroupe1, forKey: "backgroundColor")
        firstLayer.add(layerGroupe1, forKey: "backgroundColor")
        
        let layerGroupe2 = makeAnimationGroup(color1: UIColor(named: "gradientBottom"), previousGroup: layerGroupe1)
        statusLayer.add(layerGroupe2, forKey: "backgroundColor")
        feelsLikeLayer.add(layerGroupe2, forKey: "backgroundColor")
        weatherIconLayer.add(layerGroupe2, forKey: "backgroundColor")
        
        addSubview(firstInfo)
        addSubview(temperatureLabel)
        addSubview(statusInfo)
        addSubview(weatherIcon)
        addSubview(feelsLikeInfo)
        
        NSLayoutConstraint.activate([
            firstInfo.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            firstInfo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            firstInfo.heightAnchor.constraint(equalToConstant: 15),
            firstInfo.widthAnchor.constraint(equalToConstant: 150),
            
            temperatureLabel.topAnchor.constraint(equalTo: firstInfo.bottomAnchor, constant: 5),
            temperatureLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            temperatureLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            temperatureLabel.widthAnchor.constraint(equalToConstant: 40),
            
            feelsLikeInfo.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            feelsLikeInfo.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            feelsLikeInfo.leadingAnchor.constraint(equalTo: temperatureLabel.trailingAnchor, constant: 100),
            feelsLikeInfo.heightAnchor.constraint(equalToConstant: 15),
            
            statusInfo.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            statusInfo.bottomAnchor.constraint(equalTo: feelsLikeInfo.topAnchor, constant: -5),
            statusInfo.leadingAnchor.constraint(equalTo: temperatureLabel.trailingAnchor, constant: 150),
            statusInfo.heightAnchor.constraint(equalToConstant: 15),
            
            weatherIcon.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            weatherIcon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            weatherIcon.bottomAnchor.constraint(equalTo: statusInfo.topAnchor, constant: -5),
            weatherIcon.widthAnchor.constraint(equalTo: weatherIcon.heightAnchor),
        ])
    }
}

