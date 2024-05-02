//
//  ProfileViewController.swift
//  LifestyleHUB
//
//  Created by Иван Лукъянычев on 16.03.2024.
//

import UIKit
import SnapKit


protocol ProfileViewProtocol: AnyObject {
    func showProfile(user: User?)
}

class ProfileViewController: UIViewController {
    
    // UI
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var userAgeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var userEmailLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 16
        button.layer.cornerCurve = .continuous
        button.setTitle("Войти в аккаунт", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 16
        button.layer.cornerCurve = .continuous
        button.setTitle("Создать аккаунт", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 16
        button.layer.cornerCurve = .continuous
        button.setTitle("Выйти из аккаунта", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var sessionView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0
        return view
    }()
    
    private lazy var welcomeView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0
        return view
    }()
    
    private lazy var profileImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 50
        view.backgroundColor = .lightGray
        view.clipsToBounds = true
        return view
    }()
    
    
    var presenter: ProfilePresenterInput?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoaded()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        title = "Аккаунт"
        
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        
        
        // Welcome View
        view.addSubview(welcomeView)
        welcomeView.addSubview(loginButton)
        welcomeView.addSubview(registerButton)
        welcomeView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        NSLayoutConstraint.activate([
            welcomeView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            welcomeView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            welcomeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            welcomeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            loginButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -100),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            registerButton.heightAnchor.constraint(equalToConstant: 50),
            registerButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -100),
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
        ])
        
        
        // Session View
        view.addSubview(sessionView)
        sessionView.addSubview(userNameLabel)
        sessionView.addSubview(logoutButton)
        sessionView.addSubview(userAgeLabel)
        sessionView.addSubview(userEmailLabel)
        sessionView.addSubview(profileImage)
        NSLayoutConstraint.activate([
            sessionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            sessionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            sessionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sessionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            profileImage.heightAnchor.constraint(equalToConstant: 100),
            profileImage.widthAnchor.constraint(equalToConstant: 100),
            profileImage.trailingAnchor.constraint(equalTo: sessionView.trailingAnchor, constant: -20),
            profileImage.topAnchor.constraint(equalTo: sessionView.topAnchor, constant: 20),
            
            userNameLabel.leadingAnchor.constraint(equalTo: sessionView.leadingAnchor, constant: 20),
            userNameLabel.trailingAnchor.constraint(equalTo: profileImage.leadingAnchor, constant: -20),
            userNameLabel.topAnchor.constraint(equalTo: sessionView.topAnchor, constant: 20),
            
            userAgeLabel.leadingAnchor.constraint(equalTo: sessionView.leadingAnchor, constant: 20),
            userAgeLabel.trailingAnchor.constraint(equalTo: sessionView.trailingAnchor, constant: -20),
            userAgeLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 5),
            
            userEmailLabel.leadingAnchor.constraint(equalTo: sessionView.leadingAnchor, constant: 20),
            userEmailLabel.trailingAnchor.constraint(equalTo: profileImage.leadingAnchor, constant: -20),
            userEmailLabel.topAnchor.constraint(equalTo: userAgeLabel.bottomAnchor, constant: 5),
            
            logoutButton.heightAnchor.constraint(equalToConstant: 50),
            logoutButton.widthAnchor.constraint(equalTo: sessionView.widthAnchor, constant: -100),
            logoutButton.centerXAnchor.constraint(equalTo: sessionView.centerXAnchor),
            logoutButton.bottomAnchor.constraint(equalTo: sessionView.bottomAnchor, constant: -20),
        ])
    }
    
    @objc private func loginButtonTapped() {
        presenter?.openLoginController()
    }
    
    @objc private func registerButtonTapped() {
        presenter?.openRegisterController()
    }
    
    @objc private func logoutButtonTapped() {
        presenter?.logout()
    }
}

extension ProfileViewController: ProfileViewProtocol {
    func showProfile(user: User?) {
        sessionView.alpha = 0
        welcomeView.alpha = 0
        if let user {
            userNameLabel.text = user.name
            userAgeLabel.text = "Возраст: \(user.age)"
            profileImage.image = UIImage(data: user.image ?? Data())
            userEmailLabel.text = user.email ?? ""
            UIView.animate(withDuration: 0.3) {
                self.sessionView.alpha = 1
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.welcomeView.alpha = 1
            }
        }
    }
}
