//
//  ViewController.swift
//  UIKitViewCode
//
//  Created by Lucca Claus on 27/06/24.
//

import UIKit
import CoreGraphics

class FirstScreen: UIViewController {
    
    let imageView = UIImageView()
    let nextButton = UIButton()
    let collectionViewButton = UIButton()
        
    let stack = UIStackView() //test stack
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let interaction = UIContextMenuInteraction(delegate: self)
        nextButton.addInteraction(interaction)
        //drawRectangle()
        setupButton()
        setupCollectionViewButton()
        view.backgroundColor = .systemBackground
        title = "First Screen"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.center = view.center
    }
    
    func setupButton() {
        view.addSubview(nextButton)
        
        nextButton.configuration = .filled()
        nextButton.configuration?.baseBackgroundColor = .systemBrown
        //        nextButton.configuration?.image = UIImage(systemName: "plus")
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .bold, scale: .large)
        let boldImg = UIImage(systemName: "plus", withConfiguration: imageConfig)
        nextButton.setImage(boldImg, for: .normal)
        
        nextButton.addTarget(self, action: #selector(goToNextScreen), for: .touchUpInside)
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: 200),
            nextButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setupCollectionViewButton() {
        view.addSubview(collectionViewButton)
        
        collectionViewButton.configuration = .filled()
        collectionViewButton.configuration?.baseBackgroundColor = .systemGreen
        //        nextButton.configuration?.image = UIImage(systemName: "plus")
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .bold, scale: .large)
        let boldImg = UIImage(systemName: "chevron.right", withConfiguration: imageConfig)
        collectionViewButton.setImage(boldImg, for: .normal)
        
        collectionViewButton.addTarget(self, action: #selector(goToCollectionViewScreen), for: .touchUpInside)
        
        collectionViewButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionViewButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionViewButton.centerYAnchor.constraint(equalTo: nextButton.centerYAnchor, constant: 70),
            collectionViewButton.widthAnchor.constraint(equalToConstant: 200),
            collectionViewButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    
    @objc func goToNextScreen() {
        let nextScreen = SecondScreen()
        nextScreen.title = "Second Screen"
        navigationController?.pushViewController(nextScreen, animated: true)
    }
    
    @objc func goToCollectionViewScreen() {
        //Creating layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (view.frame.size.width / 3) - 3, height: (view.frame.size.height / 3) - 3)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        
        // Collection VC
        let nextScreen = PortfolioCollectionViewController(collectionViewLayout: layout)
        nextScreen.title = "Portfolio"
        navigationController?.pushViewController(nextScreen, animated: true)
    }
    
    
    
    
    func drawRectangle() {
        view.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 200)
        ])

        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image { ctx in
            let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512)
            ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(10)
            
            ctx.cgContext.addRect(rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
            
        }
        
        imageView.image = img
    }
    


}

extension FirstScreen: UIContextMenuInteractionDelegate {
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { suggestedActions in
            
            // Create an action for sharing
            let share = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up")) { action in
                // Show system share sheet
            }
            
            // Create an action for renaming
            let rename = UIAction(title: "Rename", image: UIImage(systemName: "square.and.pencil")) { action in
                // Perform renaming
            }
            
            // Here we specify the "destructive" attribute to show that it’s destructive in nature
            let delete = UIAction(title: "Delete", image: UIImage(systemName: "trash"), attributes: .destructive) { action in
                // Perform delete
            }
            
            // Create and return a UIMenu with all of the actions as children
            return UIMenu(title: "", children: [share, rename, delete])
        }
        
    }
}

