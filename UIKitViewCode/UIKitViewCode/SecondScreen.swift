//
//  SecondScreen.swift
//  UIKitViewCode
//
//  Created by Lucca Claus on 27/06/24.
//

import UIKit

class SecondScreen: UIViewController {

    @objc private func back() {
        dismiss(animated: true)
    }
    
    let portfolioTitleArray = ["Stanley's Portfolio", "Lucca's Portfolio", "Thiago's Portfolio", "Pedro's Portfolio", "Fernanda's Portfolio", "Victoria's Portfolio"]
    
    let descriptionArray = ["Stanley's Soul", "Lucca's Rock and Roll", "Thiago's Indie", "Pedro's Eminem","Fernanda's Blues","Victoria's Pagode"]

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(PortfolioTableViewCell.self, forCellReuseIdentifier: "PortfolioTableViewCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .clear
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none //(ou "tableView.separatorStyle = .none")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.allowsSelection = true
        tableView.isUserInteractionEnabled = true
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        
        setConstraints()
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
}

extension SecondScreen: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return portfolioTitleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PortfolioTableViewCell", for: indexPath) as? PortfolioTableViewCell else {
            return UITableViewCell()
        }
        let rank = (indexPath.row + 1)
        let portfolios = portfolioTitleArray[indexPath.row]
        let description = descriptionArray[indexPath.row]
        cell.set(portfolioFormat: portfolios, index: rank, description: description)
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
}
