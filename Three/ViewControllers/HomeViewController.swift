//
//  HomeViewController.swift
//  Three
//
//  Created by Doan Le Thieu on 8/20/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Subviews
    
    lazy var playWithFriendButton: UIButton = {
        let button = UIButton()
        button.setTitle("Play with Friend", for: .normal)
        
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

extension HomeViewController {
    
    @objc private func playWithFriendPressed(_ sender: UIButton) {
        let settingViewController = SettingViewController()
        
        navigationController?.pushViewController(settingViewController, animated: true)
    }
    
    // Further config the root view since it will be created programmatically
    private func configView() {
        view.backgroundColor = .white
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    // Setup subviews
    private func setUpSubviews() {
        // customize subviews
        playWithFriendButton.backgroundColor = .black
        playWithFriendButton.titleLabel?.textColor = .white
        playWithFriendButton.titleLabel?.font = UIFont.systemFont(ofSize: 18.0, weight: .bold)
        playWithFriendButton.layer.cornerRadius = 8.0
        
        // add subviews to view hierarchy
        view.addSubview(playWithFriendButton)
        
        // constraint subviews
        playWithFriendButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            playWithFriendButton.heightAnchor.constraint(equalToConstant: 50),
            playWithFriendButton.widthAnchor.constraint(equalToConstant: 280),
            playWithFriendButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playWithFriendButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100)])
        
        // config action-target for button
        playWithFriendButton.addTarget(self, action: #selector(playWithFriendPressed(_:)), for: .touchUpInside)
    }
}
