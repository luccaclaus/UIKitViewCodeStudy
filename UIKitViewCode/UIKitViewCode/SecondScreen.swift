//
//  SecondScreen.swift
//  UIKitViewCode
//
//  Created by Lucca Claus on 27/06/24.
//

import UIKit
import UniformTypeIdentifiers

class SecondScreen: UIViewController {
    
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
    
    var portfolioData = Mock()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        tableView.dataSource = self
        tableView.delegate = self
        tableView.dragDelegate = self
        tableView.dropDelegate = self
        tableView.dragInteractionEnabled = true
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
        return portfolioData.portfolios.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PortfolioTableViewCell", for: indexPath) as? PortfolioTableViewCell else {
            return UITableViewCell()
        }
        let rank = (indexPath.row + 1)
        let portfolios = portfolioData.portfolios[indexPath.row].title
        let description = portfolioData.portfolios[indexPath.row].shortDescription
        cell.set(portfolioFormat: portfolios, index: rank, description: description)
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension SecondScreen: UITableViewDragDelegate, UITableViewDropDelegate {
    
    func tableView(_ tableView: UITableView, itemsForBeginning session: any UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let portfolio = portfolioData.portfolios[indexPath.row]
        let itemProvider = NSItemProvider.init(object: portfolio)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        
        return [dragItem]
    }
    
    func tableView(_ tableView: UITableView, dragSessionWillBegin session: any UIDragSession) {
        
    }
    
    func tableView(_ tableView: UITableView, dragSessionDidEnd session: any UIDragSession) {
        
    }
    
    func tableView(_ tableView: UITableView, canHandle session: any UIDropSession) -> Bool {
        session.canLoadObjects(ofClass: PortfolioHomeCard.self)
    }
    
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: any UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        var dropProposal = UITableViewDropProposal(operation: .cancel)
        
        guard session.items.count == 1 else { return dropProposal }
        
        if tableView.hasActiveDrag {
            if tableView.isEditing {
                dropProposal = UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
            }
        } else {
            dropProposal = UITableViewDropProposal(operation: .copy, intent: .insertAtDestinationIndexPath)
        }
        
        return dropProposal
    }
    
    
    func tableView(_ tableView: UITableView, performDropWith coordinator: any UITableViewDropCoordinator) {
        let destinationIndexPath: IndexPath
        
        print("jeff")
        
        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
        } else {
            let section = tableView.numberOfSections - 1
            let row = tableView.numberOfRows(inSection: section)
            destinationIndexPath = IndexPath(row: row, section: section)
        }
        
        // attempt to load strings from the drop coordinator
        coordinator.session.loadObjects(ofClass: PortfolioHomeCard.self) { portfolios in
            
            // convert the item provider array to a string array or bail out
            DispatchQueue.main.async {
                
                print("entered stirngs")
                guard let portfolios = portfolios as? [PortfolioHomeCard] else { return }
                
                
                // create an empty array to track rows we've copied
                var indexPaths = [IndexPath]()
                
                // loop over all the strings we received
                for (index, portfolio) in portfolios.enumerated() {
                    // create an index path for this new row, moving it down depending on how many we've already inserted
                    let indexPath = IndexPath(row: destinationIndexPath.row + index, section: destinationIndexPath.section)
                    
                    // insert the copy into the correct array
                    self.portfolioData.portfolios.insert(portfolio, at: indexPath.row)
                    
                    // keep track of this new row
                    indexPaths.append(indexPath)
                }
                
                // insert them all into the table view at once
                tableView.insertRows(at: indexPaths, with: .automatic)
            }
        }
    }
    
    
}


