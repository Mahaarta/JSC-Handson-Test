//
//  UIViewController.swift
//  JSCHandsOnTest
//
//  Created by Minata Mahaarta on 26/01/21.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwifterSwift
import ObjectMapper
import PKHUD

extension UIViewController {
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }
        
        return instantiateFromNib()
    }
    
    public func setupBackButton() {
        
    }
    
    public func setupCloseButton() {
        
    }
    
    public func setupLogoView() {
        guard let _ = navigationController else { print("setupLogoView - not working"); return }
    
        let imageView = UIImageView()
        imageView.image = UIImage(named: "")
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView

    }
    
    public func whiteAppBarShadow() {
        self.navigationController?.navigationBar.layer.masksToBounds = false
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.lightGray.cgColor
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.3
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 0
    }
    
    public func appBarNoShadow() {
        self.navigationController?.navigationBar.layer.masksToBounds = false
    }
    
    @available(iOS 13.0, *)
    var appDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
}
