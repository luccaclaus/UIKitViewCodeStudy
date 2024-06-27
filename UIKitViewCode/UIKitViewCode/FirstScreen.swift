//
//  ViewController.swift
//  UIKitViewCode
//
//  Created by Lucca Claus on 27/06/24.
//

import UIKit

class FirstScreen: UIViewController {
    
    let nextButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
        view.backgroundColor = .systemBackground
        title = "First Screen"
        navigationController?.navigationBar.prefersLargeTitles = true
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
    
    @objc func goToNextScreen() {
        let nextScreen = SecondScreen()
        nextScreen.title = "Second Screen"
        navigationController?.pushViewController(nextScreen, animated: true)
    }

}

