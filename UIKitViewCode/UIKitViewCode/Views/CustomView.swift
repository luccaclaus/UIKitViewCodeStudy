//
//  CustomView.swift
//  UIKitViewCode
//
//  Created by Lucca Claus on 27/06/24.
//

import Foundation
import SwiftUI

final class CustomView: UIView {
    
    let button = UIButton()
        
    // 1. Creating the new element
    lazy var label: UILabel = {
        // internal label, not the same as the external label
        let label = UILabel()
        label.text = "Hello World"
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .yellow
        // 2. Adding the new element into the view
        addSubview(label)
        // 3. Add the auto layout constrains
        setUpLabelConstrains()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpLabelConstrains() {
        // Needed to avoid auto layout conflicts
        label.translatesAutoresizingMaskIntoConstraints = false
        // Set the top part of the label to the safe area of the custom view and add a vertical separation of 64 points
        label.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 64).isActive = true
        // Set the left part of the label to the safe area of the custom view and add a horizontal separation of 18 points
        label.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 18).isActive = true
        // Set the right part of the label to the safe area of the custom view and add a horizontal separation of -18 points
        // note: if this value it's positive the element will be separate from outside the screen 18 points.
        label.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -18).isActive = true
        // Set the height of the label to be equal to 48 points
        label.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
}
