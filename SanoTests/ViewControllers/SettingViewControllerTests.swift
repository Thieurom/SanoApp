//
//  SettingViewControllerTests.swift
//  SanoTests
//
//  Created by Doan Le Thieu on 8/20/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import XCTest
@testable import Sano

class SettingViewControllerTests: XCTestCase {
    
    var sut: SettingViewController!
    
    override func setUp() {
        super.setUp()
        
        sut = SettingViewController(isFightingRobot: false)
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        sut = nil
        
        super.tearDown()
    }
    
    func testHasSelectionView() {
        let view = sut.selectionView
        
        XCTAssertTrue(view.isDescendant(of: sut.view), "The selectionView is not in view hierarchy!")
    }
    
    func testHasStartButton() {
        let button = sut.startButton
        
        XCTAssertTrue(button.isDescendant(of: sut.view), "The startButton is not in the view hierarchy!")
    }
    
    func testStartButtonActionWhenPieceSelectionIsRightOrder() {
        UIApplication.shared.keyWindow?.rootViewController = sut
        
        let button = sut.startButton
        button.sendActions(for: .touchUpInside)
        
        guard let nextViewController = sut.presentedViewController as? UINavigationController else {
            XCTFail("The modally-presented view controller should be an instance of UINavigationController!")
            return
        }
        
        guard let gameViewController = nextViewController.viewControllers.first as? GameViewController else {
            XCTFail("Root view controller of presented UINavigationController should be an instance of GameViewController!")
            return
        }
        
        XCTAssertEqual(gameViewController.gameManager.firstPlayingPiece, GamePiece.solid, "The firstPlayingPiece should be GamePiece.solid!")
    }
    
    func testStartButtonActionWhenPieceSelectionIsNotRightOrder() {
        UIApplication.shared.keyWindow?.rootViewController = sut
        
        let selectionView = sut.selectionView
        selectionView.setRightOrder(false)
        
        let button = sut.startButton
        button.sendActions(for: .touchUpInside)
        
        guard let nextViewController = sut.presentedViewController as? UINavigationController else {
            XCTFail("The modally-presented view controller should be an instance of UINavigationController!")
            return
        }
        
        guard let gameViewController = nextViewController.viewControllers.first as? GameViewController else {
            XCTFail("Root view controller of presented UINavigationController should be an instance of GameViewController!")
            return
        }
        
        XCTAssertEqual(gameViewController.gameManager.firstPlayingPiece, GamePiece.donut, "The firstPlayingPiece should be GamePiece.donut!")
    }
}
