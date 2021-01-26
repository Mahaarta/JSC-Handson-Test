//
//  UINavigationController.swift
//  JSCHandsOnTest
//
//  Created by Minata Mahaarta on 26/01/21.
//

import Foundation
import UIKit

extension UINavigationController {
    func popToViewController(ofClass: AnyClass, animated: Bool = true) {
        if let vc = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
            popToViewController(vc, animated: animated)
        }
    }
}
