//
//  Mock.swift
//  UIKitViewCode
//
//  Created by Lucca Claus on 02/07/24.
//

import Foundation

struct Mock {
    
    var portfolios: [PortfolioHomeCard] = [
        PortfolioHomeCard(title: "Stanley's Portfolio", description: "Stanley's Soul"),
        PortfolioHomeCard(title: "Lucca's Portfolio", description: "Lucca's Rock and Roll"),
        PortfolioHomeCard(title: "Thiago's Portfolio", description: "Thiago's Indie"),
        PortfolioHomeCard(title: "Pedro's Portfolio", description: "Pedro's Eminem"),
        PortfolioHomeCard(title: "Fernanda's Portfolio", description: "Fernanda's Blues"),
        PortfolioHomeCard(title: "Victoria's Portfolio", description: "Victoria's Pagode")
    ]
    
}

//import UIKit
//import UniformTypeIdentifiers
//
//class SecondScreen: UIViewController, UITableViewDataSource, UITableViewDelegate, UITableViewDragDelegate, UITableViewDropDelegate {
//
//    var tableView: UITableView!
//    var portfolioData: [PortfolioHomeCard] = []
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        // Initialize sample data
//        portfolioData = [
//            PortfolioHomeCard(title: "Portfolio 1", description: "Description 1"),
//            PortfolioHomeCard(title: "Portfolio 2", description: "Description 2")
//        ]
//        
//        tableView = UITableView(frame: view.bounds, style: .plain)
//        tableView.dataSource = self
//        tableView.delegate = self
//        tableView.dragDelegate = self
//        tableView.dropDelegate = self
//        tableView.dragInteractionEnabled = true
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        
//        view.addSubview(tableView)
//    }
//
//    // MARK: - UITableViewDataSource
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return portfolioData.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.text = portfolioData[indexPath.row].title
//        return cell
//    }
//
//    // MARK: - UITableViewDragDelegate
//
//    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
//        let portfolio = portfolioData[indexPath.row]
//        let itemProvider = NSItemProvider(object: portfolio)
//        return [UIDragItem(itemProvider: itemProvider)]
//    }
//
//    // MARK: - UITableViewDropDelegate
//
//    func tableView(_ tableView: UITableView, canHandle session: UIDropSession) -> Bool {
//        return session.canLoadObjects(ofClass: PortfolioHomeCard.self)
//    }
//
//    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
//        return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
//    }
//
//    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
//        let destinationIndexPath: IndexPath
//
//        if let indexPath = coordinator.destinationIndexPath {
//            destinationIndexPath = indexPath
//        } else {
//            let section = tableView.numberOfSections - 1
//            let row = tableView.numberOfRows(inSection: section)
//            destinationIndexPath = IndexPath(row: row, section: section)
//        }
//
//        coordinator.session.loadObjects(ofClass: PortfolioHomeCard.self) { items in
//            guard let portfolios = items as? [PortfolioHomeCard] else { return }
//            var indexPaths = [IndexPath]()
//            for (index, portfolio) in portfolios.enumerated() {
//                let indexPath = IndexPath(row: destinationIndexPath.row + index, section: destinationIndexPath.section)
//                self.portfolioData.insert(portfolio, at: indexPath.row)
//                indexPaths.append(indexPath)
//            }
//            tableView.insertRows(at: indexPaths, with: .automatic)
//        }
//    }
//}
//
//final class PortfolioHomeCard: NSObject, NSItemProviderWriting, NSItemProviderReading, Codable {
//    static var writableTypeIdentifiersForItemProvider: [String] {
//        return [UTType.data.identifier]
//    }
//    
//    func loadData(withTypeIdentifier typeIdentifier: String, forItemProviderCompletionHandler completionHandler: @escaping (Data?, Error?) -> Void) -> Progress? {
//        let progress = Progress(totalUnitCount: 100)
//        do {
//            let data = try JSONEncoder().encode(self)
//            progress.completedUnitCount = 100
//            completionHandler(data, nil)
//        } catch {
//            completionHandler(nil, error)
//        }
//        return progress
//    }
//
//    static var readableTypeIdentifiersForItemProvider: [String] {
//        return [UTType.data.identifier]
//    }
//
//    static func object(withItemProviderData data: Data, typeIdentifier: String) throws -> PortfolioHomeCard {
//        let decoder = JSONDecoder()
//        return try decoder.decode(PortfolioHomeCard.self, from: data)
//    }
//    
//    var title: String
//    var shortDescription: String
//
//    init(title: String, description: String) {
//        self.title = title
//        self.shortDescription = description
//    }
//}
//
