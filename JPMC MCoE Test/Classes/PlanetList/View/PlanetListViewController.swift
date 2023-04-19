//
//  PlanetListViewController.swift
//  JPMC MCoE Test
//
//  Created by Nikunj Gangani on 18/04/2023.
//

import Foundation
import Combine
import UIKit

class PlanetListViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView? {
        didSet {
            tableView?.delegate = self
            tableView?.dataSource = self
            tableView?.registerCell(ofType: PlanetListCell.self)
            tableView?.addSubview(refreshControl)
        }
    }
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    var viewModel: PlanetViewModel!
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
                                    #selector(refresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.gray
        return refreshControl
    }()
    private var cancellable: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupBinders()
        getPlanetsAPI()
    }
}

// MARK: - Helper Methods
extension PlanetListViewController {
    private func setupData() {
        self.title = Title.planets
    }
    
    private func setupBinders() {
        viewModel = PlanetViewModel(manager: ServiceManager())
        viewModel.$planetList.sink { [weak self] (list) in
            guard let self = self else { return }
            self.stopIndicator()
            DispatchQueue.main.async {
                self.tableView?.reloadData()
            }
        }.store(in: &cancellable)
        
        viewModel.$message.sink { message in
            self.stopIndicator()
            print("\(message)")
        }.store(in: &cancellable)
    }
    
    func getPlanetsAPI() {
        startIndicator()
        viewModel.getPlanetList()
    }
    
    private func startIndicator() {
        DispatchQueue.main.async {
            LoadingView.show()
        }
    }
    
    private func stopIndicator() {
        DispatchQueue.main.async {
            LoadingView.hide()
        }
    }
}

// MARK: - Actions
extension PlanetListViewController {
    @objc func refresh(_ sender: AnyObject) {
        getPlanetsAPI()
    }
}

// MARK: - UITableView Delegate & UITableView DataSource methods
extension PlanetListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.planetList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PlanetListCell = tableView.dequeueCell(ofType: PlanetListCell.self)
        cell.planet = viewModel.planetList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        // Uncomment for more data
        /*
        if viewModel.planetList.count - 2 == indexPath.row && viewModel.apiState == .completed && viewModel.planetList.count < (viewModel.planetResult?.count ?? 0){
            viewModel.pageIndex += 1
            viewModel.getPlanetList()
        }
         */
    }
}
