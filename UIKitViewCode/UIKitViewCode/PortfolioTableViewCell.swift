//
//  PortfolioTableViewCell.swift
//  UIKitViewCode
//
//  Created by Lucca Claus on 01/07/24.
//

import UIKit

class PortfolioTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    /// Cell informations creation:
    private var portfolioTitle: UILabel = {
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 16.0, weight: .bold)
        title.numberOfLines = 0
        title.text = "Lucca's Portfolio"
        
        return title
    }()
    
    private var portfolioShortDescription: UILabel = {
        let description = UILabel()
        description.font = UIFont.systemFont(ofSize: 10.0, weight: .regular)
        description.text = "Lucca's Rock and Roll Portfolio"
        
        return description
    }()
    
    private var portfolioOrderLabel: UILabel = {
        let orderLabel = UILabel()
        orderLabel.font = UIFont.systemFont(ofSize: 20.0, weight: .bold)
        orderLabel.textColor = UIColor.blue
        orderLabel.text = "2"
        
        return orderLabel
    }()
    
    /// Information stack set up
    var infoStackView: UIStackView = {
       let stack = UIStackView()
        stack.spacing = 4
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    var portfolioStackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 18
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "PortfolioTableViewCell")
        self.selectionStyle = .none
        self.backgroundColor = .clear
        contentView.backgroundColor = .systemGray
        
        hierarchy()
        setConstraints()
        setupDragInteraction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func hierarchy() {
        contentView.addSubview(portfolioStackView)
        portfolioStackView.addArrangedSubview(portfolioOrderLabel)
        portfolioStackView.addArrangedSubview(infoStackView)
        
        infoStackView.addArrangedSubview(portfolioTitle)
        infoStackView.addArrangedSubview(portfolioShortDescription)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            portfolioStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            portfolioStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            portfolioStackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func set(portfolioFormat: String, index: Int, description: String) {
        portfolioTitle.text = portfolioFormat
        portfolioShortDescription.text = "This is \(description) portfolio"
        portfolioOrderLabel.text = String(index)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.contentView.layer.cornerRadius = 8
        self.contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3))
        self.contentView.layer.shadowColor = UIColor.label.cgColor
        self.contentView.layer.shadowOpacity = 0.1
        self.contentView.layer.shadowOffset = .zero
        self.contentView.layer.shadowRadius = 2
    }
    
    private func setupDragInteraction() {
        let dragInteraction = UIDragInteraction(delegate: self)
        self.addInteraction(dragInteraction)
    }
}


extension PortfolioTableViewCell: UIDragInteractionDelegate {
    func dragInteraction(_ interaction: UIDragInteraction, itemsForBeginning session: UIDragSession) -> [UIDragItem] {
        guard let title = portfolioTitle.text else { return [] }
        let itemProvider = NSItemProvider(object: title as NSString)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        return [dragItem]
    }
    
    
}

