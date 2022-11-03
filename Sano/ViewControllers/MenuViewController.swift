//
//  MenuViewController.swift
//  Sano
//
//  Created by Doan Le Thieu on 8/28/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    // we have to a strong reference to an UIViewControllerTransitioningDelegate object,
    // so later when we assign it to transitioningDelegate, the retain count would inrease.
    private var transitionManager: TransitionManager?
    
    private var menuActions = [MenuAction]()
    private var bottomActionButton: GhostButton?
    
    var numberOfMenuActions: Int {
        return menuActions.count
    }

    // MARK: - Subviews
    
    lazy var menuView: UIView = {
        let view = UIView()
        return view
    }()
    
    // MARK: - Initialization
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        self.transitionManager = TransitionManager()
        self.modalPresentationStyle = .overFullScreen
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

// MARK: - Public

extension MenuViewController {
    
    func addMenuAction(_ menuAction: MenuAction) {
        menuActions.append(menuAction)
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
        menuView.backgroundColor = .white
        menuView.layer.cornerRadius = 8
        menuView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        // add subviews to view hierarchy
        view.addSubview(menuView)
        
        // constraint subviews
        menuView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            menuView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            menuView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            menuView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        for (index, menuAction) in menuActions.enumerated() {
            let button = GhostButton(title: menuAction.title, icon: menuAction.style.icon())
            button.tag = index
            
            menuView.addSubview(button)
            
            button.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                button.heightAnchor.constraint(equalToConstant: 40),
                button.leadingAnchor.constraint(equalTo: menuView.leadingAnchor, constant: 8),
                button.trailingAnchor.constraint(equalTo: menuView.trailingAnchor, constant: -8),
                button.topAnchor.constraint(equalTo: bottomActionButton?.bottomAnchor ?? menuView.topAnchor, constant: 8)
            ])
            
            button.addTarget(self, action: #selector(actionHandling(_:)), for: .touchUpInside)
            
            bottomActionButton = button
        }
        
        // menu will have at least one item, and it allows user just to dismiss the controller
        // add a close button at the bottom of the menuView
        let closeButton: UIButton = {
            let closeButton = UIButton()
            
            closeButton.setTitle("CLOSE", for: .normal)
            closeButton.backgroundColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1.0)
            closeButton.setTitleColor(UIColor(red: 74/255, green: 74/255, blue: 74/255, alpha: 1.0), for: .normal)
            closeButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
            closeButton.layer.cornerRadius = 3
            
            return closeButton
        }()
        
        menuView.addSubview(closeButton)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            closeButton.heightAnchor.constraint(equalToConstant: 40),
            closeButton.topAnchor.constraint(equalTo: bottomActionButton?.bottomAnchor ?? menuView.topAnchor, constant: 8),
            closeButton.leadingAnchor.constraint(equalTo: menuView.leadingAnchor, constant: 8),
            closeButton.trailingAnchor.constraint(equalTo: menuView.trailingAnchor, constant: -8),
            closeButton.bottomAnchor.constraint(equalTo: menuView.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])

        closeButton.addTarget(self, action: #selector(dismissSelf), for: .touchUpInside)
    }
    
    @objc private func actionHandling(_ sender: UIButton) {
        dismiss(animated: true) {
            let index = sender.tag
            self.menuActions[index].handler!()
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

// MARK: - Extensions for helper

extension MenuItemStyle {

    // return icon for menu item
    func icon() -> UIImage? {
        switch self {
        case .cancel:
            return UIImage(named: "quit_button_icon")
        case .continnue:
            return UIImage(named: "restart_button_icon")
        }
    }
}
