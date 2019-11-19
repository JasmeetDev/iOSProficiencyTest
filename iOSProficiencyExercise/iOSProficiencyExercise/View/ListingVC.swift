//
//  ViewController.swift
//  iOSProficiencyExercise
//
//  Created by Jasmeet Singh on 18/11/19.
//  Copyright © 2019 Jasmeet. All rights reserved.
//

import UIKit
import TDResult

class ListingVC: AppBaseViewController {
    
    static let cellIdentifer = "ListingTableCell"
    
    //Variable(s)
    var serviceManager = ListingVCServiceManager()
    var contentTableview = UITableView()
    var content = Content() {
        didSet {
            self.title = self.content.title
            contentTableview.reloadData()
        }
    }
    
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    
    //MARK: - Private methods
    private func initialize() {
        serviceManager.delegate = self
        setupView()
        initiateApiCall()
    }
    private func setupView() {
        self.view.addSubview(contentTableview)
        contentTableview.estimatedRowHeight = 100
        contentTableview.rowHeight = UITableView.automaticDimension

        // Disable auto resizing
        contentTableview.translatesAutoresizingMaskIntoConstraints = false
        
        // Set tableview constraints to the superview
        contentTableview.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        contentTableview.leadingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        contentTableview.trailingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        contentTableview.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        // Set Datasource and delegates
        contentTableview.dataSource = self
        contentTableview.delegate = self
        
        registerCell()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Refresh", style: .plain, target: self, action: #selector(refresh))
    }
    
    // Register Tableview cell
    private func registerCell() {
        contentTableview.register(ListingTableCell.self, forCellReuseIdentifier: ListingVC.cellIdentifer)
    }
    
    @objc private func refresh() {
        initiateApiCall()
    }
    
    private func initiateApiCall() {
        self.showActivityLoader(self.view)
        serviceManager.getContent()
    }
}

//MARK: - ListingVCServiceManager Delegate
extension ListingVC: ListingVCServiceManagerDelegate {
    func listingVCServiceManager(_ listingVCServiceManager: ListingVCServiceManager, didSuccessfullyGetContent content:Content) {
        self.hideActivityLoader(self.view)
        self.content = content
    }
    
    func completeProfileVCServiceManager(_ completeProfileVCServiceManager: ListingVCServiceManager, failedWithError error: TDError) {
        self.hideActivityLoader(self.view)
    }
}

//MARK: - UITableview Datasource & Delegate
extension ListingVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.content.rows.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListingVC.cellIdentifer, for: indexPath) as! ListingTableCell
        cell.row = self.content.rows[indexPath.row]
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
