//
//  ContextMenu.swift
//  UIKitViewCode
//
//  Created by Lucca Claus on 28/06/24.
//

import UIKit

class ContextMenu: UIView {

    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "My Favorite Quote"
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemRed
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func setupContextButton() {
//        
//        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            descriptionLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 12),
//            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant:  -12),
//            descriptionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
//            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
//        ])
//    }
    
}
