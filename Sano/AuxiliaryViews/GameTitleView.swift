//
//  GameTitleView.swift
//  Sano
//
//  Created by Doan Le Thieu on 9/4/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import UIKit

class GameTitleView: UIView {
    
    // MARK: Subviews
    
    private var gameImageView: UIImageView!
    private var descriptionLabel: UILabel!
    
    // MARK: Initializations
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initSubviews()
        addSubviews()
        constraintSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initSubviews()
        addSubviews()
        constraintSubviews()
    }
    
    // MAKR: Override

    override var intrinsicContentSize: CGSize {
        let width = descriptionLabel.intrinsicContentSize.width
        let height = gameImageView.frame.height + 20 + descriptionLabel.intrinsicContentSize.height
        return CGSize(width: width, height: height)
    }
}

// MARK: - Private helpers

extension GameTitleView {
    
    private func initSubviews() {
        gameImageView = UIImageView(image: UIImage(named: "app_logo"))
        
        descriptionLabel = UILabel()
        descriptionLabel.text = "Yet another tic-tac-toe game".uppercased()
        descriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        descriptionLabel.minimumScaleFactor = 0.75
        descriptionLabel.textAlignment = .center
    }
    
    private func addSubviews() {
        addSubview(gameImageView)
        addSubview(descriptionLabel)
    }
    
    private func constraintSubviews() {
        gameImageView.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            gameImageView.topAnchor.constraint(equalTo: self.topAnchor),
            gameImageView.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            gameImageView.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor)])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: gameImageView.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)])
    }
}
