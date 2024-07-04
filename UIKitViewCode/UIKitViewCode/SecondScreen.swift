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
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PortfolioTableViewCell")
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
    
//    // We use the system index and the drop session as input parameters.
//    // If the system index is <mark>nil</mark>, then we will have a second index prediction system.
//    
//    private func getDestinationIndexPath(system passedIndexPath: IndexPath?, session: UIDropSession) -> IndexPath? {
//        // Try to get the index by drop location
//        let tapLocation = session.location(in: tableView)
//        let systemByLocationIndexPath = tableView.indexPathForRow(at: tapLocation)
//        
//        // Look for the closest cell within a radius of 100 points if systemByLocationIndexPath is nil
//        var customByLocationIndexPath: IndexPath? = nil
//        if systemByLocationIndexPath == nil {
//            var closestCell: UITableViewCell? = nil
//            var closestCellVerticalDistance: CGFloat = 100
//            
//            for cell in tableView.visibleCells {
//                let cellCenterLocation = tableView.convert(cell.center, to: tableView)
//                let verticalDistance = abs(cellCenterLocation.y - tapLocation.y)
//                if closestCellVerticalDistance > verticalDistance {
//                    closestCellVerticalDistance = verticalDistance
//                    closestCell = cell
//                }
//            }
//            
//            if let cell = closestCell, let indexPath = tableView.indexPath(for: cell) {
//                customByLocationIndexPath = indexPath
//            }
//        }
//        
//        // Return the value in order of priority
//        return passedIndexPath ?? systemByLocationIndexPath ?? customByLocationIndexPath
//    }
}

extension SecondScreen: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return portfolioData.portfolios.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PortfolioTableViewCell", for: indexPath) as? PortfolioTableViewCell else {
            return UITableViewCell()
        }
//        let cell = tableView.dequeueReusableCell(withIdentifier: "PortfolioTableViewCell", for: indexPath)
        
        let rank = (indexPath.row + 1)
        let portfolios = portfolioData.portfolios[indexPath.row].title
        let description = portfolioData.portfolios[indexPath.row].shortDescription
        cell.set(portfolioFormat: portfolios, index: rank, description: description)
//        cell.textLabel?.text = portfolios
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let mover = portfolioData.portfolios.remove(at: sourceIndexPath.row)
        portfolioData.portfolios.insert(mover, at: destinationIndexPath.row)
    }
}

extension SecondScreen: UITableViewDragDelegate, UITableViewDropDelegate {
    
    //MARK: - Drag Methods
    func tableView(_ tableView: UITableView, itemsForBeginning session: any UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let portfolio = portfolioData.portfolios[indexPath.row]
        let itemProvider = NSItemProvider(object: portfolio)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        
        return [dragItem]
    }
    
    func tableView(_ tableView: UITableView, dragSessionWillBegin session: any UIDragSession) {
        print("dragSessionWillBegin")
    }
    
    func tableView(_ tableView: UITableView, dragSessionDidEnd session: any UIDragSession) {
        print("dragSessionDidEnd")
    }
    
    //MARK: - Drop Methods
    func tableView(_ tableView: UITableView, canHandle session: any UIDropSession) -> Bool {
        print("TABLEVIEW: \(session.canLoadObjects(ofClass: PortfolioHomeCard.self))")
        return session.canLoadObjects(ofClass: PortfolioHomeCard.self)
    }
    
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: any UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        
        var dropProposal = UITableViewDropProposal(operation: .copy, intent: .insertAtDestinationIndexPath)
        
        guard session.items.count == 1 else { return dropProposal }
        
        if tableView.hasActiveDrag {
//            if tableView.isEditing {
                dropProposal = UITableViewDropProposal(operation: .copy, intent: .insertAtDestinationIndexPath)
//            }
        } else {
            dropProposal = UITableViewDropProposal(operation: .copy, intent: .insertAtDestinationIndexPath)
        }
        
        return dropProposal
    }
    
    
    func tableView(_ tableView: UITableView, performDropWith coordinator: any UITableViewDropCoordinator) {
        let destinationIndexPath: IndexPath

        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
            print(destinationIndexPath)
        } else {
            let section = tableView.numberOfSections - 1
            let row = tableView.numberOfRows(inSection: section)
            destinationIndexPath = IndexPath(row: row, section: section)
        }
        
        coordinator.session.loadObjects(ofClass: PortfolioHomeCard.self) { items in
            guard let portfolios = items as? [PortfolioHomeCard] else { return }
            var indexPaths = [IndexPath]()
            
            for (index, portfolio) in portfolios.enumerated() {
                let indexPath = IndexPath(row: destinationIndexPath.row + index, section: destinationIndexPath.section)
                self.portfolioData.portfolios.insert(portfolio, at: indexPath.row)
                indexPaths.append(indexPath)
            }
//          pegar o indexpath antigo e depois adicionar
            tableView.insertRows(at: indexPaths, with: .automatic)
            
        }
    }
    
}




