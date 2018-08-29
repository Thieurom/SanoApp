//
//  MenuViewController.swift
//  Three
//
//  Created by Doan Le Thieu on 8/28/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    // we have to a strong reference to an UIViewControllerTransitioningDelegate object,
    // so later when we assign it to transitioningDelegate, the retain count would inrease.
    private var transitionManager: TransitionManager?

    // MARK: - Subviews
    
    lazy var menuView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var quitButton: GhostButton = {
        let button = GhostButton(title: "Quit game", icon: UIImage(named: "quit_button_icon"))
        
        return button
    }()
    
    lazy var restartButton: GhostButton = {
        let button = GhostButton(title: "Restart current board", icon: UIImage(named: "restart_button_icon"))
        
        return button
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setTitle("CLOSE", for: .normal)
        
        return button
    }()
    
    // MARK: - Initialization
    
    init(transitioningAnimated: Bool = false) {
        super.init(nibName: nil, bundle: nil)
        
        if transitioningAnimated {
            self.transitionManager = TransitionManager()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configView()
        setUpSubviews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: - Private helpers

extension MenuViewController {
    
    // Further config the root view since it will be created programmatically
    private func configView() {
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        transitioningDelegate = transitionManager
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissSelf))
        tapGestureRecognizer.delegate = self
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func setUpSubviews() {
        // customize subviews
        closeButton.backgroundColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1.0)
        closeButton.setTitleColor(UIColor(red: 74/255, green: 74/255, blue: 74/255, alpha: 1.0), for: .normal)
        closeButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        closeButton.layer.cornerRadius = 3
        
        menuView.backgroundColor = .white
        menuView.layer.cornerRadius = 3
        
        // add subviews to view hierarchy
        menuView.addSubview(quitButton)
        menuView.addSubview(restartButton)
        menuView.addSubview(closeButton)
        view.addSubview(menuView)
        
        // constraint subviews
        menuView.translatesAutoresizingMaskIntoConstraints = false
        quitButton.translatesAutoresizingMaskIntoConstraints = false
        restartButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            menuView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            menuView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            menuView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8)])
        
        NSLayoutConstraint.activate([
            quitButton.heightAnchor.constraint(equalToConstant: 40),
            quitButton.topAnchor.constraint(equalTo: menuView.topAnchor, constant: 8),
            quitButton.leadingAnchor.constraint(equalTo: menuView.leadingAnchor, constant: 8),
            quitButton.trailingAnchor.constraint(equalTo: menuView.trailingAnchor, constant: -8)])
        
        NSLayoutConstraint.activate([
            restartButton.heightAnchor.constraint(equalToConstant: 40),
            restartButton.topAnchor.constraint(equalTo: quitButton.bottomAnchor, constant: 8),
            restartButton.leadingAnchor.constraint(equalTo: menuView.leadingAnchor, constant: 8),
            restartButton.trailingAnchor.constraint(equalTo: menuView.trailingAnchor, constant: -8)])
        
        NSLayoutConstraint.activate([
            closeButton.heightAnchor.constraint(equalToConstant: 40),
            closeButton.topAnchor.constraint(equalTo: restartButton.bottomAnchor, constant: 8),
            closeButton.leadingAnchor.constraint(equalTo: menuView.leadingAnchor, constant: 8),
            closeButton.trailingAnchor.constraint(equalTo: menuView.trailingAnchor, constant: -8),
            closeButton.bottomAnchor.constraint(equalTo: menuView.bottomAnchor, constant: -8)])
        
        // further config
        quitButton.addTarget(self, action: #selector(dimissToRootViewController), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(dismissSelf), for: .touchUpInside)
    }
    
    @objc private func dimissToRootViewController() {
        guard let rootViewController = view.window?.rootViewController as? UINavigationController else {
            return
        }
        
        rootViewController.dismiss(animated: true) {
            rootViewController.popToRootViewController(animated: true)
        }
    }
    
    @objc private func dismissSelf() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UIGestureRecognizerDelegate

extension MenuViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if let subview = touch.view, subview != view && subview.isDescendant(of: view) {
            return false
        }
        
        return true
    }
}
