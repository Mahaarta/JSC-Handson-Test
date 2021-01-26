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
        navigationBar.barTintColor = UIColor.black
        navigationBar.tintColor = .white
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationBar.isTranslucent = false
    }
}
