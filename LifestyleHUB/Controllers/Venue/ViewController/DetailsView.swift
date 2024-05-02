//
//  DetailsView.swift
//  LifestyleHUB
//
//  Created by Иван Лукъянычев on 21.03.2024.
//

import UIKit

protocol DetailsViewProtocol: AnyObject {
    func configure(contact: String, adress: String, open: String, description: String, workTime: String)
}

class DetailsView: UIView, DetailsViewProtocol {
    
    private lazy var contactLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Контакты"
        label.textColor = .secondaryLabel
        return label
    }()
    
    private lazy var contactInfoLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "+7 (925) 414-44-98"
        return label
    }()
    
    private func Divider() -> UIView {
        let view = UIView()
        view.backgroundColor = .separator
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    private lazy var divider1 = Divider()
    
    private lazy var adressLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Адрес"
        label.textColor = .secondaryLabel
        return label
    }()
    
    private lazy var adressInfoLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var divider2 = Divider()
    
    private lazy var openLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Статус"
        label.textColor = .secondaryLabel
        return label
    }()
    
    private lazy var openInfoLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var divider3 = Divider()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Описание"
        label.textColor = .secondaryLabel
        return label
    }()
    
    private lazy var descriptionInfoLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 10
        return label
    }()
    
    private lazy var divider4 = Divider()
    
    private lazy var workTimeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Режим работы"
        label.textColor = .secondaryLabel
        return label
    }()
    
    private lazy var workTimeInfoLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 10
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        layer.cornerRadius = 18
        layer.cornerCurve = .continuous
        backgroundColor = .secondarySystemBackground
        alpha = 0
        
        self.addSubview(contactLabel)
        self.addSubview(contactInfoLabel)
        self.addSubview(divider1)
        self.addSubview(adressLabel)
        self.addSubview(adressInfoLabel)
        self.addSubview(divider2)
        self.addSubview(openLabel)
        self.addSubview(openInfoLabel)
        self.addSubview(divider3)
        self.addSubview(descriptionLabel)
        self.addSubview(descriptionInfoLabel)
        self.addSubview(divider4)
        self.addSubview(workTimeLabel)
        self.addSubview(workTimeInfoLabel)
        
        NSLayoutConstraint.activate([
            // контакты
            contactLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            contactLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            contactLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            contactInfoLabel.topAnchor.constraint(equalTo: contactLabel.bottomAnchor, constant: 5),
            contactInfoLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            contactInfoLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            divider1.heightAnchor.constraint(equalToConstant: 0.3),
            divider1.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            divider1.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            divider1.topAnchor.constraint(equalTo: contactInfoLabel.bottomAnchor, constant: 10),
            
            // адрес
            adressLabel.topAnchor.constraint(equalTo: divider1.bottomAnchor, constant: 10),
            adressLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            adressLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            adressInfoLabel.topAnchor.constraint(equalTo: adressLabel.bottomAnchor, constant: 5),
            adressInfoLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            adressInfoLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            divider2.heightAnchor.constraint(equalToConstant: 0.3),
            divider2.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            divider2.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            divider2.topAnchor.constraint(equalTo: adressInfoLabel.bottomAnchor, constant: 10),
            
            // открыто/закрыто
            openLabel.topAnchor.constraint(equalTo: divider2.bottomAnchor, constant: 10),
            openLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            openLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            openInfoLabel.topAnchor.constraint(equalTo: openLabel.bottomAnchor, constant: 5),
            openInfoLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            openInfoLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            divider3.heightAnchor.constraint(equalToConstant: 0.3),
            divider3.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            divider3.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            divider3.topAnchor.constraint(equalTo: openInfoLabel.bottomAnchor, constant: 10),
            
            // режим работы
            workTimeLabel.topAnchor.constraint(equalTo: divider3.bottomAnchor, constant: 10),
            workTimeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            workTimeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            workTimeInfoLabel.topAnchor.constraint(equalTo: workTimeLabel.bottomAnchor, constant: 5),
            workTimeInfoLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            workTimeInfoLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            divider4.heightAnchor.constraint(equalToConstant: 0.3),
            divider4.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            divider4.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            divider4.topAnchor.constraint(equalTo: workTimeInfoLabel.bottomAnchor, constant: 10),
            
            // описание
            descriptionLabel.topAnchor.constraint(equalTo: divider4.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            descriptionInfoLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 5),
            descriptionInfoLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            descriptionInfoLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            self.bottomAnchor.constraint(equalTo: descriptionInfoLabel.bottomAnchor, constant: 16)
        ])
    }
    
    func configure(contact: String, adress: String, open: String, description: String, workTime: String) {
        contactInfoLabel.text = contact
        adressInfoLabel.text = adress
        openInfoLabel.text = open
        descriptionInfoLabel.text = description
        workTimeInfoLabel.text = workTime
        
        UIView.animate(withDuration: 0.3) {
            self.alpha = 1.0
        }
    }
}
