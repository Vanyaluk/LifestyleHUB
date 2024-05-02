//
//  EventsViewController.swift
//  Super easy dev
//
//  Created by vanyaluk on 23.03.2024
//

import UIKit

protocol EventsViewProtocol: AnyObject {
    func showEvents(fetchedEvents: [Event])
}

class EventsViewController: UIViewController {
    
    private lazy var noEventsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.text = "Создайте новый досуг"
        label.isHidden = true
        label.alpha = 0
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(EventTableViewCell.self, forCellReuseIdentifier: EventTableViewCell.id)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        return table
    }()
    
    var presenter: EventsPresenterProtocolInput?
    private var events = [Event]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter?.viewDidLoaded()
    }
    
    private func configureUI() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        title = "Мой досуг"
        
        let exitButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(plusButtonTapped))
        navigationItem.rightBarButtonItem = exitButton
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        view.addSubview(tableView)
        tableView.addSubview(noEventsLabel)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            noEventsLabel.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            noEventsLabel.centerYAnchor.constraint(equalTo: tableView.centerYAnchor, constant: -130),
        ])
    }
    
    @objc func plusButtonTapped() {
        presenter?.openNewEventView()
    }
    
    // проверка на показ о отсутствии событий
    private func checkIsEmptyLabel() {
        if events.isEmpty {
            noEventsLabel.isHidden = false
            UIView.animate(withDuration: 0.3) {
                self.noEventsLabel.alpha = 1
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.noEventsLabel.alpha = 0
            } completion: { _ in
                self.noEventsLabel.isHidden = true
            }
        }
    }
}

extension EventsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EventTableViewCell.id, for: indexPath) as? EventTableViewCell else { return UITableViewCell() }
        cell.configure(with: events[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        presenter?.cellTapped(id: events[indexPath.row].venueId)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if let id = events[indexPath.row].id {
            events.remove(at: indexPath.row)
//            UIView.transition(with: tableView, duration: 0.2, options: .transitionCrossDissolve) {
//                self.tableView.reloadData()
//            }
            tableView.deleteRows(at: [indexPath], with: .automatic)
            presenter?.removeCellTapped(id: id)
            checkIsEmptyLabel()
        }
    }
}


extension EventsViewController: EventsViewProtocol {
    func showEvents(fetchedEvents: [Event]) {
        events = fetchedEvents
        self.tableView.reloadData()
        checkIsEmptyLabel()
    }
}
