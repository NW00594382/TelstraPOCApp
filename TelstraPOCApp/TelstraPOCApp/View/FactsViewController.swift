//
//  FactsViewController.swift
//  TelstraPOCApp
//
//  Created by Nikhil Wagh on 04/05/20.
//  Copyright © 2020 Tech Mahindra. All rights reserved.
//

import UIKit

class FactsViewController: UITableViewController {
    
    //MARK: - Parameters
    
    let factsViewModel = FactsViewModel()
    var activityView: UIActivityIndicatorView?
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpInitialView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFacts()
    }
    
    //MARK: - Private Methods
    
    /// This method is to do initial setup
    func setUpInitialView() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
        setupTableView()
        addActivityIndicator()
    }
    
    /// This method is to setup tableView
    func setupTableView() {
        tableView.register(FactsTableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = UIColor.themeColor
        self.tableView.tableFooterView = UIView()
        self.navigationController?.navigationBar.barTintColor = UIColor.themeColor
    }
    
    /// This method is to setup Activity indicator
    func addActivityIndicator() {
        activityView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        activityView?.center =  CGPoint(x: self.view.bounds.midX, y: self.view.bounds.midY)
        activityView?.hidesWhenStopped = true
        view.addSubview(activityView!)
    }
    
    /// This method is to get facts data from ViewModel
    func getFacts() {
        activityView?.startAnimating()
        factsViewModel.getFactsData { result in
            switch(result) {
            case .success:
                self.activityView?.stopAnimating()
                self.navigationItem.title = self.factsViewModel.screenTitle
                self.tableView.reloadData()
            case .failure(let error):
                let alert = UIAlertController(title: Constants.errorTitle, message: error.localizedDescription , preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: Constants.ok, style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    //MARK: - Actions
    
    /// This method get called when user pull down the table to refresh data
    /// - Parameter refreshControl: This paramter used to perform operation
    @objc func pullToRefresh(refreshControl: UIRefreshControl) {
        getFacts()
        refreshControl.endRefreshing()
    }
}

extension FactsViewController {
    
    //MARK: - Delegate and DataSource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as? FactsTableViewCell else { return FactsTableViewCell() }
        cell.configureCell(viewModel: self.factsViewModel, indexPath: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return factsViewModel.factsArray.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
