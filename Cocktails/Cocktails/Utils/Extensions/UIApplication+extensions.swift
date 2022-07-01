//
//  UIApplication+extensions.swift
//  Cocktails
//
//  Created by Pasquale on 30/06/22.
//

import UIKit

extension UIApplication {
    class func topViewController() -> UIViewController? {
        var topvc = UIApplication.shared.keyWindow?.rootViewController
        guard topvc != nil else { return nil }
        
        while topvc?.presentedViewController != nil {
            topvc = topvc?.presentedViewController
        }
        return topvc
    }
}
