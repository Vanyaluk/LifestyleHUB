//
//  RegisterViewController.swift
//  Super easy dev
//
//  Created by vanyaluk on 22.03.2024
//

import UIKit

protocol RegisterViewProtocol: AnyObject {
    func registerResultes(result: KeychainRegistrationResult)
}

class RegisterViewController: UIViewController {
    
    private lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Логин"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .systemBackground
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Пароль"
        textField.isSecureTextEntry = true
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .systemBackground
        return textField
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Зарегистрироваться", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var warningLabel: UILabel = {
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
    
    var presenter: RegisterPresenterProtocolInput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        presenter?.viewDidLoaded()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        title = "Регистрация"
        
        registerButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        let exitButton = UIBarButtonItem(image: UIImage(systemName: "multiply"), style: .plain, target: self, action: #selector(exitButtonTapped))
        navigationItem.rightBarButtonItem = exitButton
        
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(registerButton)
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
            
            registerButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 40),
            registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            registerButton.heightAnchor.constraint(equalToConstant: 40),
            
            spinner.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 40),
            spinner.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            spinner.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            spinner.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc private func exitButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc private func loginButtonTapped() {
        registerButton.alpha = 0
        spinner.startAnimating()
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        guard let nickname = usernameTextField.text, let password = passwordTextField.text else { return }
        presenter?.registerUser(with: nickname, password: password)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}


extension RegisterViewController: RegisterViewProtocol {
    func registerResultes(result: KeychainRegistrationResult) {
        spinner.stopAnimating()
        navigationItem.rightBarButtonItem?.isEnabled = true
        
        switch result {
        case .dublicateEntry:
            warningLabel.alpha = 1
            warningLabel.text = "Придумайте другой логин"
            registerButton.alpha = 1
        case .unknown(let error):
            warningLabel.alpha = 1
            warningLabel.text = error
            registerButton.alpha = 1
        case .success:
            dismiss(animated: true)
        }
    }
}
