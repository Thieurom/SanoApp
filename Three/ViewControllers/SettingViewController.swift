//
//  SettingViewController.swift
//  Three
//
//  Created by Doan Le Thieu on 8/20/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    
    // MARK: Data
    
    let isFightingRobot: Bool
    
    private var playerOneName: String {
        return isFightingRobot ? "Human" : "Player One"
    }
    
    private var playerTwoName: String {
        return isFightingRobot ? "Robot" : "Player Two"
    }
    
    // MARK: - Subviews
    
    lazy var selectionView: GamePieceSelectionView = {
        let view = GamePieceSelectionView(titleOne: playerOneName.uppercased(), titleTwo: playerTwoName.uppercased())
        
        return view
    }()
    
    lazy var instructionLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    lazy var startButton: Button = {
        let button = Button()
        button.setTitle("Start game", for: .normal)
        
        return button
    }()
    
    // MARK: - Initializations
    
    init(isFightingRobot: Bool) {
        self.isFightingRobot = isFightingRobot
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configView()
        setUpSubviews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: - Private

extension SettingViewController {
    
    // Further config the root view since it will be created programmatically
    private func configView() {
        view.backgroundColor = .white
        
        navigationItem.title = "SELECT PIECE"
    }
    
    // Setup subviews
    private func setUpSubviews() {
        instructionLabel.numberOfLines = 0
        instructionLabel.text = "\(playerOneName) will play first on the first board".uppercased()
        instructionLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        instructionLabel.textAlignment = .center

        let containerView = UIStackView(arrangedSubviews: [selectionView, instructionLabel, startButton])
        containerView.axis = .vertical
        containerView.alignment = .fill
        containerView.distribution = .fill
        containerView.spacing = 40
        
        view.addSubview(containerView)
        
        // constraint subviews
        containerView.translatesAutoresizingMaskIntoConstraints = false
        startButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 10),
            containerView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -10)])
        
        NSLayoutConstraint.activate([
            startButton.heightAnchor.constraint(equalToConstant: 44)])
        
        // add target-action
        startButton.addTarget(self, action: #selector(startButtonPressed(_:)), for: .touchUpInside)
    }
    
    @objc private func startButtonPressed(_ sender: UIButton) {
        let firstPlayingPiece: GamePiece = selectionView.isOnRightOrder ? .solid : .donut
        let gameManager = GameManager(boardSize: 3, firstPlayingPiece: firstPlayingPiece)
        let gameViewController = GameViewController(gameManager: gameManager, isFightingRobot: isFightingRobot)
        let navigationController = UINavigationController(rootViewController: gameViewController)
        
        present(navigationController, animated: true, completion: nil)
    }
}
