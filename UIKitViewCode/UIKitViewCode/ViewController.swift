//
//  ViewController.swift
//  UIKitViewCode
//
//  Created by Lucca Claus on 27/06/24.
//

import UIKit

class ViewController: UIViewController {
    
    let nextButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
    }

    func setupButton() {
        view.addSubview(nextButton)
        
        nextButton.configuration = .filled()
        nextButton.configuration?.baseBackgroundColor = .systemBrown
//        nextButton.configuration?.image = UIImage(systemName: "plus")
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 140, weight: .bold, scale: .large)
        let boldsd = UIImage(systemName: "plus", withConfiguration: imageConfig)
        nextButton.setImage(boldsd, for: .normal)
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: 200),
            nextButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }

}

