//
//  UITableViewExtension.swift
//  pokeSearchApp
//
//  Created by burcu kirik on 7.02.2021.
//

import Foundation
import UIKit

public protocol Reusable: class {
    static var reuseIdentifier: String { get }
    static var nib: UINib? { get }
}

public extension Reusable {
    static var reuseIdentifier: String { return String(describing: self) }
    static var nib: UINib? { return nil }
}

public extension UITableView {
    
    final func createCell<T: Reusable>(_ indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
    
    final func registerCell<T:Reusable>(_ type:T.Type){
        let identifier = T.reuseIdentifier
        self.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    final func registerReusableCell<T: UITableViewCell>(_: T.Type) where T: Reusable {
        if let nib = T.nib {
            self.register(nib, forCellReuseIdentifier: T.reuseIdentifier)
        } else {
            self.register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
        }
    }
    
    final func registerReusableHeaderFooterView<T: UITableViewHeaderFooterView>(_: T.Type) where T: Reusable {
        if let nib = T.nib {
            self.register(nib, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
        } else {
            self.register(T.self, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
        }
    }
    
    final func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T? where T: Reusable {
        return self.dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as! T?
    }
    
    final func dequeueReusableCell<T:Reusable>(_ type:T.Type)->T?{
        return self.dequeueReusableCell(withIdentifier: T.reuseIdentifier) as? T
    }
}

// MARK: - Animate Function -

public extension UITableView {
    
    final func update() {
        UIView.performWithoutAnimation {
            self.beginUpdates()
            self.endUpdates()
        }
    }
    
    final func animateTableView(toPoint: CGPoint, duration: TimeInterval, completion: ((Bool) -> Void)?) {
        
        reloadData()
        layoutIfNeeded()
        
        visibleCells.forEach { cell in
            cell.transform = CGAffineTransform(translationX: toPoint.x, y: toPoint.y)
        }
        
        var delayCounter: Double = 0
        var finishedCounter = 1
        
        visibleCells.forEach({ cell in
            UIView.animate(withDuration: duration,
                           delay: Double(delayCounter) * 0.03,
                           usingSpringWithDamping: 0.6,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut,
                           animations: {
                            cell.transform = .identity
            }, completion: { finished in
                if finishedCounter == self.visibleCells.count, finished {
                    completion!(true)
                } else {
                    completion!(false)
                    finishedCounter += 1
                }
                delayCounter += 1
            })
        })
    }
}
