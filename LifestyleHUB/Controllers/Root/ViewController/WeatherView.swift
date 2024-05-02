//
//  WeatherView.swift
//  LifestyleHUB
//
//  Created by Иван Лукъянычев on 16.03.2024.
//

import UIKit

protocol WeatherViewProtocol: UIView {
    func configure(with result: WeatherData)
    
    func startLoading()
}

class WeatherView: UIView {
    
    private lazy var skeletonWeather = SkeletonWeatherView()
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 36, weight: .regular)
        label.text = "-"
        label.textColor = .white
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowRadius = 2.0
        label.layer.shadowOpacity = 0.3
        label.layer.shadowOffset = CGSize(width: 0, height: 0)
        label.layer.masksToBounds = false
        return label
    }()
    
    // город + разброс
    private lazy var firstInfo: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.text = "-"
        label.textColor = .white
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowRadius = 2.0
        label.layer.shadowOpacity = 0.3
        label.layer.shadowOffset = CGSize(width: 0, height: 0)
        label.layer.masksToBounds = false
        return label
    }()
    
    // статус
    private lazy var statusInfo: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.text = "-"
        label.textAlignment = .right
        label.textColor = .white
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowRadius = 2.0
        label.layer.shadowOpacity = 0.3
        label.layer.shadowOffset = CGSize(width: 0, height: 0)
        label.layer.masksToBounds = false
        return label
    }()
    
    private lazy var feelsLikeInfo: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.text = "-"
        label.textAlignment = .right
        label.textColor = .white
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowRadius = 2.0
        label.layer.shadowOpacity = 0.3
        label.layer.shadowOffset = CGSize(width: 0, height: 0)
        label.layer.masksToBounds = false
        return label
    }()
    
    private lazy var weatherIcon: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowRadius = 2.0
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.masksToBounds = false
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
    
    private lazy var warningImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tintColor = .white
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowRadius = 2.0
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.masksToBounds = false
        view.image = UIImage(systemName: "exclamationmark.icloud.fill")
        view.contentMode = .scaleAspectFit
        return view
    }()

    init() {
        super.init(frame: .zero)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        layer.cornerRadius = 20
        layer.cornerCurve = .continuous
        layer.masksToBounds = true
        
        layer.insertSublayer(gradient, at: 0)
        
        addSubview(temperatureLabel)
        addSubview(firstInfo)
        addSubview(statusInfo)
        addSubview(weatherIcon)
        addSubview(skeletonWeather)
        addSubview(warningImage)
        addSubview(feelsLikeInfo)
        
        NSLayoutConstraint.activate([            
            firstInfo.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            firstInfo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            firstInfo.heightAnchor.constraint(equalToConstant: 15),
            
            temperatureLabel.topAnchor.constraint(equalTo: firstInfo.bottomAnchor, constant: 3),
            temperatureLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            temperatureLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
            feelsLikeInfo.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            feelsLikeInfo.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            feelsLikeInfo.leadingAnchor.constraint(equalTo: temperatureLabel.trailingAnchor),
            feelsLikeInfo.heightAnchor.constraint(equalToConstant: 15),
            
            statusInfo.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            statusInfo.bottomAnchor.constraint(equalTo: feelsLikeInfo.topAnchor, constant: -2),
            statusInfo.leadingAnchor.constraint(equalTo: temperatureLabel.trailingAnchor),
            statusInfo.heightAnchor.constraint(equalToConstant: 15),
            
            weatherIcon.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            weatherIcon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            weatherIcon.bottomAnchor.constraint(equalTo: statusInfo.topAnchor, constant: 6),
            weatherIcon.widthAnchor.constraint(equalTo: weatherIcon.heightAnchor),
            
            skeletonWeather.topAnchor.constraint(equalTo: topAnchor),
            skeletonWeather.bottomAnchor.constraint(equalTo: bottomAnchor),
            skeletonWeather.leadingAnchor.constraint(equalTo: leadingAnchor),
            skeletonWeather.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            warningImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            warningImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            warningImage.heightAnchor.constraint(equalToConstant: 50),
            warningImage.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = bounds
    }
    
}

extension WeatherView: WeatherViewProtocol {
    func startLoading() {
        temperatureLabel.alpha = 0
        firstInfo.alpha = 0
        statusInfo.alpha = 0
        feelsLikeInfo.alpha = 0
        weatherIcon.alpha = 0
        warningImage.alpha = 0
        skeletonWeather.isHidden = false
    }
    
    func configure(with result: WeatherData) {
        temperatureLabel.alpha = 0
        firstInfo.alpha = 0
        statusInfo.alpha = 0
        feelsLikeInfo.alpha = 0
        weatherIcon.alpha = 0
        warningImage.alpha = 0
        
        switch result {
        case .dataError:
            skeletonWeather.isHidden = true
            UIView.animate(withDuration: 0.5) { [self] in
                warningImage.alpha = 1.0
            }
        case .weatherInfo(let temperature, let firstText, let feelsLike, let status, let image):
            temperatureLabel.text = temperature
            firstInfo.text = firstText
            statusInfo.text = status
            feelsLikeInfo.text = feelsLike
            weatherIcon.image = image
            skeletonWeather.isHidden = true
            
            UIView.animate(withDuration: 0.5) { [self] in
                temperatureLabel.alpha = 1.0
                firstInfo.alpha = 1.0
                statusInfo.alpha = 1.0
                weatherIcon.alpha = 1.0
                feelsLikeInfo.alpha = 1.0
            }
        }
    }
    
}
