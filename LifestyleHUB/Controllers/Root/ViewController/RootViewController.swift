//
//  RootViewController.swift
//  LifestyleHUB
//
//  Created by Иван Лукъянычев on 16.03.2024.
//

import UIKit

// запросы во view
protocol RootViewProtocol: AnyObject {
    
    /// показываем виджет погоды
    func showWeather(content: WeatherData)
    
    /// показываем места
    func showVenues(content: [VenueModel])
    
    /// подгружаем картинки к местам
    func showVenueImage(with data: Data?, of id: String)
    
    /// перезагрузка после получения погоды (если нужна)
    func ifNeedReload()
}

class RootViewController: UIViewController {
    
    // UI
    
    private lazy var refreshControl: UIRefreshControl = {
        let spinner = UIRefreshControl()
        spinner.addTarget(self, action: #selector(pullToRefresh(sender:)), for: .valueChanged)
        return spinner
    }()
    
    private lazy var weatherView: WeatherView = {
        let view = WeatherView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(VenueViewTableViewCell.self, forCellReuseIdentifier: VenueViewTableViewCell.id)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        return table
    }()
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.text = "Разрешите доступ к локации и включите интернет."
        label.isHidden = true
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var skeletonVenue = SkeletonsVenuesView()
    
    var presenter: RootPresenterProtocolInput?
    
    private var isLoadedNewData: Bool = false
    private var venues = [VenueModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        check(for: .loading)
        presenter?.viewDidLoaded()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        title = "Предложения"
        weatherView.startLoading()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.refreshControl = refreshControl
        
        view.addSubview(tableView)
        tableView.addSubview(errorLabel)
        tableView.addSubview(skeletonVenue)
        
        navigationItem.largeTitleDisplayMode = .never
        
        let headerViewContainerWrapper = UIView()
        headerViewContainerWrapper.translatesAutoresizingMaskIntoConstraints = false
        headerViewContainerWrapper.addSubview(weatherView)
        tableView.tableHeaderView = headerViewContainerWrapper
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            errorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            errorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            errorLabel.topAnchor.constraint(equalTo: tableView.topAnchor, constant: 300),
            
            skeletonVenue.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            skeletonVenue.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            skeletonVenue.topAnchor.constraint(equalTo: tableView.topAnchor, constant: 110),
            skeletonVenue.bottomAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.bottomAnchor),
            
            weatherView.leadingAnchor.constraint(equalTo: headerViewContainerWrapper.leadingAnchor, constant: 16),
            weatherView.trailingAnchor.constraint(equalTo: headerViewContainerWrapper.trailingAnchor, constant: -16),
            weatherView.topAnchor.constraint(equalTo: headerViewContainerWrapper.topAnchor, constant: 5),
            weatherView.bottomAnchor.constraint(equalTo: headerViewContainerWrapper.bottomAnchor, constant: -8),
            weatherView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -32),
            weatherView.heightAnchor.constraint(equalToConstant: 92),
        ])
    }
    
    enum StatusRoot {
        case success
        case error
        case loading
    }
    
    private func check(for status: StatusRoot) {
        tableView.tableFooterView = nil
        refreshControl.endRefreshing()
        switch status {
        case .success:
            errorLabel.isHidden = true
            skeletonVenue.isHidden = true
            refreshControl.isEnabled = true
        case .error:
            errorLabel.isHidden = false
            skeletonVenue.isHidden = true
            refreshControl.isEnabled = true
        case .loading:
            errorLabel.isHidden = true
            skeletonVenue.isHidden = false
        }
    }
    
    @objc private func pullToRefresh(sender: UIRefreshControl) {
        venues.removeAll()
        tableView.reloadData()
        check(for: .loading)
        weatherView.startLoading()
        presenter?.viewDidLoaded()
    }
}

extension RootViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return venues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VenueViewTableViewCell.id, for: indexPath) as? VenueViewTableViewCell else { return UITableViewCell() }
        
        cell.configure(venueModel: venues[indexPath.row])
        
        return cell
    }
}

extension RootViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        presenter?.pushVenueDetails(with: venues[indexPath.row])
    }
}

extension RootViewController: RootViewProtocol {
    func showVenues(content: [VenueModel]) {
        check(for: .success)
        if !content.isEmpty {
            isLoadedNewData = false
            venues.append(contentsOf: content)
            self.tableView.reloadData()
        } else if venues.count == 0 {
            check(for: .error)
        }
    }
    
    func showVenueImage(with data: Data?, of id: String) {
        if !venues.isEmpty, let index = venues.indices.firstIndex(where: { venues[$0].id == id }) {
            venues[index].imageData = data
            if let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0)) as? VenueViewTableViewCell {
                cell.configure(venueModel: venues[index])
            }
        }
    }
    
    func showWeather(content: WeatherData) {
        weatherView.configure(with: content)
    }
    
    func ifNeedReload() {
        if !errorLabel.isHidden {
            presenter?.viewDidLoaded()
            weatherView.startLoading()
            check(for: .loading)
        }
    }
}

extension RootViewController: UIScrollViewDelegate {
    
    // MARK: - Пагинация
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (tableView.contentSize.height - scrollView.frame.size.height) && !isLoadedNewData && venues.count > 0 {
            let spiner = createSpinerFooter()
            tableView.tableFooterView = spiner
            isLoadedNewData = true
            presenter?.loadingVenues(offset: venues.count)
        }
        
    }
    
    private func createSpinerFooter() -> UIView {
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50))
    
        let spinner = UIActivityIndicatorView()
        footer.addSubview(spinner)
        spinner.startAnimating()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            spinner.topAnchor.constraint(equalTo: footer.topAnchor),
            spinner.bottomAnchor.constraint(equalTo: footer.bottomAnchor),
            spinner.leadingAnchor.constraint(equalTo: footer.leadingAnchor),
            spinner.trailingAnchor.constraint(equalTo: footer.trailingAnchor)
        ])
        
        return footer
    }
}
