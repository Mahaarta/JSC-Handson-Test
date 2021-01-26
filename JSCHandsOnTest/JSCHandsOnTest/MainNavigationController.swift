//
//  MainNavigationController.swift
//  JSCHandsOnTest
//
//  Created by Minata Mahaarta on 26/01/21.
//

import UIKit

class MainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationBar.barStyle = .black
        navigationBar.barTintColor = UIColor.white
        navigationBar.tintColor = .brownGrey
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.brownGrey]
        navigationBar.isTranslucent = false
    }
}
