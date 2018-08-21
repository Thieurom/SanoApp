//
//  SettingViewController.swift
//  Three
//
//  Created by Doan Le Thieu on 8/20/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    
    // MARK: - Subviews
    
    lazy var selectionView: GamePieceSelectionView = {
        let view = GamePieceSelectionView(titleOne: "PLAYER ONE", titleTwo: "PLAYER TWO")
        
        return view
    }()
    
    lazy var startButton: UIButton = {
        let button = UIButton()
        button.setTitle("Start", for: .normal)
        
        return button
    }()
    
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
        // customize subviews
        startButton.backgroundColor = .black
        startButton.titleLabel?.textColor = .white
        startButton.titleLabel?.font = UIFont.systemFont(ofSize: 18.0, weight: .bold)
        startButton.layer.cornerRadius = 8.0
        
        // add subviews to view hierarchy
        view.addSubview(selectionView)
        view.addSubview(startButton)
        
        // constraint subviews
        selectionView.translatesAutoresizingMaskIntoConstraints = false
        startButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            selectionView.bottomAnchor.constraint(equalTo: startButton.topAnchor, constant: -80),
            selectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            selectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)])
        
        NSLayoutConstraint.activate([
            startButton.heightAnchor.constraint(equalToConstant: 50),
            startButton.widthAnchor.constraint(equalToConstant: 280),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100)])
    }
}
