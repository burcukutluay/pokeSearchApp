//
//  GenericExtension.swift
//  pokeSearchApp
//
//  Created by burcu kirik on 7.02.2021.
//

import Foundation
import UIKit
public extension UIResponder {
    
    final func asyncOperation(operation: @escaping () -> ()) {
        DispatchQueue.main.async {
            operation()
        }
    }
    
    final func syncOperation(operation: @escaping () -> ()) {
        DispatchQueue.main.sync {
            operation()
        }
    }
    
    final func delayOperation(delayTime: Double, operation: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delayTime) {
            operation()
        }
    }
    
    var screenWidth: CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    var screenHeight: CGFloat {
        return UIScreen.main.bounds.size.height
    }
}

public extension UIImage {
    
    final func resize(_ targetSize: CGSize) -> UIImage? {
        
        let widthRatio  = targetSize.width / size.width
        let heightRatio = targetSize.height / size.height
        
        var newSize: CGSize
        if widthRatio > heightRatio {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}

public extension Int {
    var toString: String { return String(self) }
}

public extension Double {
    
    var toString: String { return String(self) }
    
    var toUInt: UInt { return UInt(self) }
    
    var toInt32: Int32 { return Int32(self) }
}

public extension UIView {
    
    final func addTapGesture(tapNumber: Int, target: Any, action: Selector) {
        let tap = UITapGestureRecognizer(target: target, action: action)
        tap.numberOfTapsRequired = tapNumber
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
    }
}
