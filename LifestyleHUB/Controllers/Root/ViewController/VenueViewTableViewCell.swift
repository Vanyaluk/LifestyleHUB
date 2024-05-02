//
//  VenueViewTableViewCell.swift
//  LifestyleHUB
//
//  Created by Иван Лукъянычев on 18.03.2024.
//

import UIKit

protocol VenueCellViewProtocol: UIView {
    func configure(model: VenueModel)
}

final class VenueCellView: UIView, VenueCellViewProtocol {
    
    private let errorImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(systemName: "photo")
        view.tintColor = .systemBackground
        view.isHidden = true
        return view
    }()
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor.clear.cgColor,
            UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1).cgColor
        ]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        return gradient
    }()
    
    private let title: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.textColor = .white
        return label
    }()
    
    private let about: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        return label
    }()
    
    private let place: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.text = ""
        label.textColor = .white
        label.textAlignment = .right
        return label
    }()
    
    private var venueModel: VenueModel?
    
    init() {
        super.init(frame: .zero)
        
        layer.cornerRadius = 20
        layer.cornerCurve = .continuous
        layer.masksToBounds = true
        
        backgroundColor = UIColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 0.4)
        
        addSubview(errorImageView)
        
        addSubview(imageView)
        imageView.layer.insertSublayer(gradient, at: 1)
        
        addSubview(title)
        addSubview(about)
        addSubview(place)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            about.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            about.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 17),
            about.heightAnchor.constraint(equalToConstant: 15),
            
            place.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            place.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            place.leadingAnchor.constraint(equalTo: about.trailingAnchor, constant: 10),
            
            title.bottomAnchor.constraint(equalTo: about.topAnchor, constant: -2),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            errorImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -10),
            errorImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            errorImageView.heightAnchor.constraint(equalToConstant: 100),
            errorImageView.widthAnchor.constraint(equalTo: heightAnchor)
        ])
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = imageView.bounds
    }
    
    func configure(model: VenueModel) {
        self.venueModel = model
        
        
        title.text = model.venue?.name ?? ""
        
        let categories = model.venue?.categories ?? []
        let shortNames = categories.map { $0.shortName ?? "unknown" }
        about.text = shortNames.joined(separator: ", ")
        
        place.text = model.venue?.location?.city ?? ""
        
        imageView.image = UIImage(data: model.imageData ?? Data())
    }
}


final class VenueViewTableViewCell: UITableViewCell {
    
    private lazy var view = VenueCellView()
    
    static let id = "VenueViewTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let bottomAnchorPr = view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        bottomAnchorPr.priority = UILayoutPriority(999)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            view.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            view.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            bottomAnchorPr
        ])
        view.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .vertical)

        selectionStyle = .none
        backgroundColor = .clear
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(venueModel: VenueModel) {
        view.configure(model: venueModel)
    }
}
