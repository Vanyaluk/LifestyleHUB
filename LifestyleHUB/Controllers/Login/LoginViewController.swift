//
//  LoginViewController.swift
//  Super easy dev
//
//  Created by vanyaluk on 22.03.2024
//

import UIKit

protocol LoginViewProtocol: AnyObject {
    func loginResultes(result: KeychainLoginResult)
}

class LoginViewController: UIViewController {
    
    private let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Логин"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .systemBackground
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Пароль"
        textField.isSecureTextEntry = true
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .systemBackground
        return textField
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Войти", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let warningLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .red
        label.alpha = 0
        return label
    }()
    
    private lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    var presenter: LoginPresenterProtocolInput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        presenter?.viewDidLoaded()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        title = "Вход"
        
        let exitButton = UIBarButtonItem(image: UIImage(systemName: "multiply"), style: .plain, target: self, action: #selector(exitButtonTapped))
        navigationItem.rightBarButtonItem = exitButton
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
                
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(warningLabel)
        view.addSubview(spinner)
        
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            usernameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            warningLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10),
            warningLabel.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            warningLabel.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 40),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            loginButton.heightAnchor.constraint(equalToConstant: 40),
            
            spinner.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 40),
            spinner.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            spinner.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            spinner.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    @objc private func loginButtonTapped() {
        loginButton.alpha = 0
        spinner.startAnimating()
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        guard let nickname = usernameTextField.text, let password = passwordTextField.text else { return }
        presenter?.loginUser(with: nickname, password: password)
    }
    
    @objc private func exitButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}


extension LoginViewController: LoginViewProtocol {
    func loginResultes(result: KeychainLoginResult) {
        spinner.stopAnimating()
        navigationItem.rightBarButtonItem?.isEnabled = true
        
        switch result {
        case .noFoundUser:
            warningLabel.alpha = 1
            warningLabel.text = "Пользователь не найден"
            loginButton.alpha = 1
        case .incorrectPassword:
            warningLabel.alpha = 1
            warningLabel.text = "Неверный пароль"
            loginButton.alpha = 1
        case .success:
            dismiss(animated: true)
        case .accountLost:
            warningLabel.alpha = 1
            warningLabel.text = "Данные аккаунта были утеряны"
        }
    }
}
