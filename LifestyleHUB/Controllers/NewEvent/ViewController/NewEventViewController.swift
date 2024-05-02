//
//  NewEventViewController.swift
//  Super easy dev
//
//  Created by vanyaluk on 23.03.2024
//

import UIKit

protocol NewEventViewProtocol: AnyObject {
    
}

class NewEventViewController: UIViewController {
    
    private lazy var titleTextField: UITextField = {
        let field = UITextField()
        field.font = .systemFont(ofSize: 32, weight: .medium)
        field.placeholder = "Название"
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .dateAndTime
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.minimumDate = Date.now.addingTimeInterval(960)
        return picker
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Заметки:"
        return label
    }()
    
    private lazy var textViewBG: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 18
        view.layer.cornerCurve = .continuous
        return view
    }()
    
    private lazy var textView: UITextView = {
        let view = UITextView()
        view.isScrollEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 16)
        view.backgroundColor = .secondarySystemBackground
        return view
    }()
    
    private lazy var notificationViewBG: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 18
        view.layer.cornerCurve = .continuous
        return view
    }()
    
    private lazy var notificationText: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 16)
        view.text = "Напомнить за 15 минут"
        return view
    }()
    
    private lazy var notificationSwitch: UISwitch = {
        let view = UISwitch()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.onTintColor = .systemYellow
        view.isOn = true
        return view
    }()
    
    private lazy var venueView = EventVenueView()
    
    var presenter: NewEventPresenterProtocolInput?
    
    var venueId, venueName: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        presenter?.viewDidLoaded()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        title = "Новый досуг"
        
        let saveButton = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(saveButtonTapped))
        navigationItem.rightBarButtonItem = saveButton
        
        let exitButton = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(exitButtonTapped))
        navigationItem.leftBarButtonItem = exitButton
        
        titleTextField.addTarget(self, action: #selector(onTitleCange), for: .editingChanged)
        navigationItem.rightBarButtonItem?.isEnabled = false
        
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
//        view.addGestureRecognizer(tapGesture)
        
        textView.delegate = self
        
        if let temp = venueName {
            venueView.configure(title: temp)
        }
        
        view.addSubview(titleTextField)
        view.addSubview(datePicker)
        view.addSubview(textViewBG)
        view.addSubview(textView)
        view.addSubview(descriptionLabel)
        view.addSubview(venueView)
        view.addSubview(notificationViewBG)
        view.addSubview(notificationSwitch)
        view.addSubview(notificationText)
        
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            datePicker.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 20),
            
            textViewBG.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 16),
            textViewBG.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textViewBG.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            descriptionLabel.topAnchor.constraint(equalTo: textViewBG.topAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: textViewBG.leadingAnchor, constant: 13),
            descriptionLabel.trailingAnchor.constraint(equalTo: textViewBG.trailingAnchor, constant: -13),
            
            textView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 0),
            textView.leadingAnchor.constraint(equalTo: textViewBG.leadingAnchor, constant: 10),
            textView.trailingAnchor.constraint(equalTo: textViewBG.trailingAnchor, constant: -10),
            textView.bottomAnchor.constraint(equalTo: textViewBG.bottomAnchor, constant: -5),
            
            notificationViewBG.topAnchor.constraint(equalTo: textViewBG.bottomAnchor, constant: 16),
            notificationViewBG.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            notificationViewBG.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            notificationViewBG.heightAnchor.constraint(equalToConstant: 50),
            
            notificationSwitch.trailingAnchor.constraint(equalTo: notificationViewBG.trailingAnchor, constant: -16),
            notificationSwitch.centerYAnchor.constraint(equalTo: notificationViewBG.centerYAnchor),
            
            notificationText.leadingAnchor.constraint(equalTo: notificationViewBG.leadingAnchor, constant: 16),
            notificationText.trailingAnchor.constraint(equalTo: notificationSwitch.leadingAnchor, constant: -16),
            notificationText.centerYAnchor.constraint(equalTo: notificationViewBG.centerYAnchor),
            
            venueView.topAnchor.constraint(equalTo: notificationViewBG.bottomAnchor, constant: 16),
            venueView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            venueView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            venueView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func saveButtonTapped() {
        hideKeyboard()
        let title = titleTextField.text ?? ""
        let notes = textView.text ?? ""
        let date = datePicker.date
        presenter?.saveEvent(title: title, notes: notes, date: date, venueId: venueId, venueName: venueName, isOn: notificationSwitch.isOn)
    }
    
    @objc private func exitButtonTapped() {
        hideKeyboard()
        dismiss(animated: true)
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func onTitleCange() {
        let text = titleTextField.text ?? ""
        if text.replacingOccurrences(of: " ", with: "").isEmpty {
            navigationItem.rightBarButtonItem?.isEnabled = false
        } else {
            navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }
}

extension NewEventViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfLines = newText.components(separatedBy: "\n").count
        
        return (newText.count <= 180) && (numberOfLines <= 5)
    }
}

extension NewEventViewController: NewEventViewProtocol {
    
}
