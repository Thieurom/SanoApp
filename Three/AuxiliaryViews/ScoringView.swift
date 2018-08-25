//
//  ScoringView.swift
//  Three
//
//  Created by Doan Le Thieu on 8/24/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import UIKit

class ScoringView: UIView {
    
    private struct Dimension {
        static let nameLabelFontSize: CGFloat = 14
        static let scoreLabelFontSize: CGFloat = 28
        static let boundsHeight: CGFloat = 60
    }
    
    // MARK: - Properties

    private(set) var playerOneNameLabel: UILabel!
    private(set) var playerOneScoreLabel: UILabel!
    
    private(set) var playerTwoNameLabel: UILabel!
    private(set) var playerTwoScoreLabel: UILabel!
    
    private(set) var separatorLabel: UILabel!
    
    var textColor: UIColor = .black {
        didSet {
            separatorLabel.textColor = textColor
            playerOneNameLabel.textColor = textColor
            playerOneScoreLabel.textColor = textColor
            playerTwoNameLabel.textColor = textColor
            playerTwoScoreLabel.textColor = textColor
        }
    }
    
    // MARK: - Initialization
    
    convenience init(playerOneName: String, playerTwoName: String) {
        self.init(frame: CGRect.zero)
        
        self.playerOneNameLabel.text = playerOneName
        self.playerTwoNameLabel.text =  playerTwoName
    }
    
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
}

// MARK: - Public

extension ScoringView {
    
    override var intrinsicContentSize: CGSize {
        let width = playerOneNameLabel.intrinsicContentSize.width +
            playerOneScoreLabel.intrinsicContentSize.width +
            separatorLabel.intrinsicContentSize.width +
            playerTwoScoreLabel.intrinsicContentSize.width +
            playerTwoNameLabel.intrinsicContentSize.width
        
        return CGSize(width: width, height: Dimension.boundsHeight)
    }
    
    func setPlayerOneName(_ name: String) {
        playerOneNameLabel.text = name
    }
    
    func setPlayerTwoName(_ name: String) {
        playerTwoNameLabel.text = name
    }
    
    func setPlayerOneScore(_ score: Int) {
        playerOneScoreLabel.text = "\(score)"
    }
    
    func setPlayerTwoScore(_ score: Int) {
        playerTwoScoreLabel.text = "\(score)"
    }
}

// MARK: - Private helpers

extension ScoringView {
    
    private func initSubviews() {
        separatorLabel = UILabel()
        separatorLabel.text = " - "
        separatorLabel.textAlignment = .center
        separatorLabel.textColor = textColor
        separatorLabel.font = UIFont.systemFont(ofSize: Dimension.scoreLabelFontSize, weight: .medium)
        
        playerOneNameLabel = UILabel()
        playerOneNameLabel.text = "Player One"
        playerOneNameLabel.textAlignment = .left
        playerOneNameLabel.textColor = textColor
        playerOneNameLabel.font = UIFont.systemFont(ofSize: Dimension.nameLabelFontSize, weight: .bold)
        
        playerOneScoreLabel = UILabel()
        playerOneScoreLabel.text = "0"
        playerOneScoreLabel.textAlignment = .right
        playerOneScoreLabel.textColor = textColor
        playerOneScoreLabel.font = UIFont.systemFont(ofSize: Dimension.scoreLabelFontSize, weight: .medium)
        
        playerTwoNameLabel = UILabel()
        playerTwoNameLabel.text = "Player Two"
        playerTwoNameLabel.textAlignment = .right
        playerTwoNameLabel.textColor = textColor
        playerTwoNameLabel.font = UIFont.systemFont(ofSize: Dimension.nameLabelFontSize, weight: .bold)
        
        playerTwoScoreLabel = UILabel()
        playerTwoScoreLabel.text = "0"
        playerTwoScoreLabel.textAlignment = .left
        playerTwoScoreLabel.textColor = textColor
        playerTwoScoreLabel.font = UIFont.systemFont(ofSize: Dimension.scoreLabelFontSize, weight: .medium)
    }
    
    private func addSubviews() {
        addSubview(separatorLabel)
        addSubview(playerOneNameLabel)
        addSubview(playerOneScoreLabel)
        addSubview(playerTwoNameLabel)
        addSubview(playerTwoScoreLabel)
    }
    
    private func constraintSubviews() {
        separatorLabel.translatesAutoresizingMaskIntoConstraints = false
        playerOneNameLabel.translatesAutoresizingMaskIntoConstraints = false
        playerOneScoreLabel.translatesAutoresizingMaskIntoConstraints = false
        playerTwoNameLabel.translatesAutoresizingMaskIntoConstraints = false
        playerTwoScoreLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            separatorLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            separatorLabel.widthAnchor.constraint(equalToConstant: 40),
            separatorLabel.topAnchor.constraint(equalTo: self.topAnchor),
            separatorLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)])
        
        separatorLabel.setContentHuggingPriority(.defaultHigh + 1, for: .horizontal)
        separatorLabel.setContentCompressionResistancePriority(.defaultHigh + 1, for: .horizontal)
        
        // add an UIStackView to group playerOneNameLabel & playerOneScoreLabel
        let playerOneContainerView = UIStackView(arrangedSubviews: [playerOneNameLabel, playerOneScoreLabel])
        playerOneContainerView.axis = .horizontal
        playerOneContainerView.alignment = .fill
        playerOneContainerView.distribution = .fill
        addSubview(playerOneContainerView)
        
        playerOneContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            playerOneContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            playerOneContainerView.trailingAnchor.constraint(equalTo: separatorLabel.leadingAnchor),
            playerOneContainerView.topAnchor.constraint(equalTo: self.topAnchor),
            playerOneContainerView.bottomAnchor.constraint(equalTo: self.bottomAnchor)])
        
        playerOneNameLabel.setContentHuggingPriority(.defaultLow - 1, for: .horizontal)
        playerOneNameLabel.setContentCompressionResistancePriority(.defaultHigh - 1, for: .horizontal)
        
        // add an UIStackView to group playerTwoNameLabel & playerTwoScoreLabel
        let playerTwoContainerView = UIStackView(arrangedSubviews: [playerTwoScoreLabel, playerTwoNameLabel])
        playerTwoContainerView.axis = .horizontal
        playerTwoContainerView.alignment = .fill
        playerTwoContainerView.distribution = .fill
        addSubview(playerTwoContainerView)
        
        playerTwoContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            playerTwoContainerView.leadingAnchor.constraint(equalTo: separatorLabel.trailingAnchor),
            playerTwoContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            playerTwoContainerView.topAnchor.constraint(equalTo: self.topAnchor),
            playerTwoContainerView.bottomAnchor.constraint(equalTo: self.bottomAnchor)])
        
        playerTwoNameLabel.setContentHuggingPriority(.defaultLow - 1, for: .horizontal)
        playerTwoNameLabel.setContentCompressionResistancePriority(.defaultHigh - 1, for: .horizontal)
    }
}
