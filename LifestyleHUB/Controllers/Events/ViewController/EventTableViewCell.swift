//
//  EventTableViewCell.swift
//  LifestyleHUB
//
//  Created by Иван Лукъянычев on 23.03.2024.
//

import UIKit

protocol EventTableViewCellProtocol: AnyObject {
    func configure(with event: Event)
}

class EventTableViewCell: UITableViewCell {
    
    private lazy var bgView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 20
        view.layer.cornerCurve = .continuous
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22)
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var imageStatus: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "bookmark.square.fill")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = .systemYellow
        return image
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    
    static let id = "EventTableViewCellId"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        contentView.addSubview(bgView)
        bgView.addSubview(titleLabel)
        bgView.addSubview(imageStatus)
        bgView.addSubview(descriptionLabel)
        bgView.addSubview(dateLabel)
        
        selectionStyle = .none
        
        NSLayoutConstraint.activate([
            bgView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            bgView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            bgView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            bgView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            imageStatus.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -16),
            imageStatus.topAnchor.constraint(equalTo: bgView.topAnchor, constant: 16),
            imageStatus.heightAnchor.constraint(equalToConstant: 30),
            imageStatus.widthAnchor.constraint(equalToConstant: 30),
            
            titleLabel.topAnchor.constraint(equalTo: bgView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: imageStatus.leadingAnchor, constant: -10),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -16),
            
            dateLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            dateLabel.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 16),
            dateLabel.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -16),
            dateLabel.bottomAnchor.constraint(equalTo: bgView.bottomAnchor, constant: -16)
        ])

    }
}

extension EventTableViewCell: EventTableViewCellProtocol {
    func configure(with event: Event) {
        titleLabel.text = event.title
        descriptionLabel.text = event.notes
        let cl = Calendar.current
        dateLabel.text = "\(cl.component(.day, from: event.date ?? Date())).\(cl.component(.month, from: event.date ?? Date())).\(cl.component(.year, from: event.date ?? Date())) в \(cl.component(.hour, from: event.date ?? Date())):\(cl.component(.minute, from: event.date ?? Date()))"
        
        imageStatus.isHidden = event.venueId == nil
    }
}
