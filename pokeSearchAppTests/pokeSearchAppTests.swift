//
//  pokeSearchAppTests.swift
//  pokeSearchAppTests
//
//  Created by burcu kirik on 6.02.2021.
//

import XCTest
import pokeFW
import UIKit

@testable import pokeSearchApp

class pokeSearchAppTests: XCTestCase {
    
    func testInvalidSearchBarPlaceholder() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        viewController.loadView()
        viewController.viewDidLoad()
        XCTAssertFalse(viewController.searchBar.placeholder == "Search")
    }
    
    func testValidSearchBarPlaceholder() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        viewController.loadView()
        viewController.viewDidLoad()
        XCTAssertEqual(viewController.searchBar.placeholder, "Search a Pokemon by name" , "It is default search bar placeholder text, this is true.")
        
    }
    
    func testValidScrollViewSubviews() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        viewController.loadView()
        viewController.viewDidLoad()
        XCTAssertEqual(viewController.scrollContentView.subviews.count, 2 , "Scroll includes _UIScrollViewScrollIndicators, not info view yet, this is true.")
    }
    
    func testValidDeleteInfoView() throws {
        let expectation = self.expectation(description: "Waiting for the complete.")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        viewController.loadView()
        viewController.viewDidLoad()
        let count = viewController.scrollContentView.subviews.count
        
        let infoView = InfoView()
        viewController.scrollContentView.addSubview(infoView)
        let view1 = UIView()
        viewController.scrollContentView.addSubview(view1)
        let view2 = UIView()
        viewController.scrollContentView.addSubview(view2)
        
        for item in viewController.scrollContentView.subviews {
            if item.classForCoder == pokeFW.InfoView.classForCoder() {
                item.removeFromSuperview()
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 10) { error in
            XCTAssertNil(error)
            XCTAssertEqual(viewController.scrollContentView.subviews.count, count + 2)
        }
    }
    
}
