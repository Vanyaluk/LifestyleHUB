//
//  VenueViewController.swift
//  LifestyleHUB
//
//  Created by Иван Лукъянычев on 20.03.2024.
//

import UIKit


protocol VenueViewProtocol: AnyObject {
    func showVenueInformation(name: String, category: String, contact: String, adress: String, open: String, description: String, workTime: String)
    
    func showMainImage(image: UIImage?)
    
    func showImages(images: [UIImage?])
}

class VenueViewController: UIViewController {
    
    // MARK: - UI
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .systemBackground
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .systemBackground
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.alpha = 0
        return imageView
    }()
    
    private lazy var imageFooter: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 24
        view.layer.cornerCurve = .continuous
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.alpha = 0
        return label
    }()
    
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.alpha = 0
        return label
    }()
    
    private lazy var informationView: DetailsView = {
        let view = DetailsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    private lazy var imagesView: ImagesView = {
        let view = ImagesView()
        view.alpha = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    // MARK: - View Lifecycle
    
    var presenter: VenuePresenterProtocolInput?
    var venueId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        presenter?.viewDidLoaded(id: venueId)
    }
    
    // MARK: - UI Setup
    
    private func configureUI() {
        view.backgroundColor = .white
        title = "Детали места"
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.topItem?.backButtonTitle = "Назад"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        imageView.addSubview(imageFooter)
        scrollView.addSubview(nameLabel)
        scrollView.addSubview(categoryLabel)
        scrollView.addSubview(informationView)
        scrollView.addSubview(imagesView)
        view.addSubview(spinner)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            imageFooter.heightAnchor.constraint(equalToConstant: 48),
            imageFooter.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            imageFooter.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            imageFooter.centerYAnchor.constraint(equalTo: imageView.bottomAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: imageFooter.topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            categoryLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 3),
            categoryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            categoryLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            informationView.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 20),
            informationView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            informationView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            imagesView.topAnchor.constraint(equalTo: informationView.bottomAnchor, constant: 20),
            imagesView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            imagesView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            imagesView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16),
            imagesView.heightAnchor.constraint(equalToConstant: 250),

            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc func addButtonTapped() {
        if let id = venueId, let title = nameLabel.text {
            presenter?.createNewEvent(with: id, title: title)
        }
    }
}



extension VenueViewController: VenueViewProtocol {
    func showVenueInformation(name: String, category: String, contact: String, adress: String, open: String, description: String, workTime: String) {
        spinner.stopAnimating()
        navigationItem.rightBarButtonItem?.isEnabled = true
        nameLabel.text = name
        categoryLabel.text = category
        UIView.animate(withDuration: 0.3) {
            self.nameLabel.alpha = 1.0
            self.categoryLabel.alpha = 1.0
            self.imagesView.alpha = 1.0
        }
        informationView.configure(contact: contact, adress: adress, open: open, description: description, workTime: workTime)
    }
    
    func showMainImage(image: UIImage?) {
        imageView.image = image
        UIView.animate(withDuration: 0.3) {
            self.imageView.alpha = 1.0
        }
    }
    
    func showImages(images: [UIImage?]) {
        imagesView.addNewImages(images: images)
    }
}
