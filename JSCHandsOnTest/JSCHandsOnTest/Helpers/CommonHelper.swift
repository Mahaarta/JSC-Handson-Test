//
//  CommonHelper.swift
//  JSCHandsOnTest
//
//  Created by Minata Mahaarta on 26/01/21.
//

import UIKit
import Alamofire
import RealmSwift
import MaterialComponents

class CommonHelper {
    
    // MARK: - Common Functions
    static let shared = CommonHelper()
    private init() {} //This prevents others from using the default '()' initializer for this class.
    
    //    let networkReachabilityManager: NetworkReachabilityManager? = {
    //        let manager = NetworkReachabilityManager(host: "www.google.com")
    //
    //        manager?.listener = { status in
    //            print("Network Status Changed: \(status)")
    //        }
    //
    //        manager?.startListening()
    //        return manager
    //    }()
    
    func isConnectedToInternet() -> Bool {
        let networkReachabilityManager = NetworkReachabilityManager()
        return networkReachabilityManager?.isReachable ?? false
    }
    
    func textfieldSetupOutlined(textInput: (UIView & MDCTextInput)?) -> MDCTextInputControllerOutlined {
        if let textField = textInput as? UITextField {
            textField.autocorrectionType = .no
            textField.textColor = UIColor.darkGray
            textField.clearButtonMode = .never
        }
        
        let textfieldController = MDCTextInputControllerOutlined(textInput: textInput)
        textfieldController.isFloatingEnabled = true
        textfieldController.activeColor = UIColor.darkSkyBlue
        textfieldController.normalColor = UIColor.brownGrey
        textfieldController.inlinePlaceholderColor = UIColor.brownGrey
        textfieldController.floatingPlaceholderNormalColor = UIColor.brownGrey
        textfieldController.floatingPlaceholderActiveColor = UIColor.peacockBlue
        textfieldController.leadingUnderlineLabelTextColor = UIColor.brownGrey
        
        return textfieldController
    }
    
    func textfieldSetup_brown(textInput: (UIView & MDCTextInput)?) -> MDCTextInputControllerOutlined {
        if let textField = textInput as? UITextField {
            textField.autocorrectionType = .no
            textField.textColor = UIColor.darkGray
            textField.clearButtonMode = .never
        }
        
        let textfieldController = MDCTextInputControllerOutlined(textInput: textInput)
        textfieldController.isFloatingEnabled = true
        textfieldController.activeColor = UIColor.annisaBrown
        textfieldController.normalColor = UIColor.brownGrey
        textfieldController.inlinePlaceholderColor = UIColor.brownGrey
        textfieldController.floatingPlaceholderNormalColor = UIColor.annisaBrown
        textfieldController.floatingPlaceholderActiveColor = UIColor.annisaBrown
        textfieldController.leadingUnderlineLabelTextColor = UIColor.annisaBrown
        
        return textfieldController
    }
    
    func textfieldSetup_disabled(textInput: (UIView & MDCTextInput)?) -> MDCTextInputControllerOutlined {
        if let textField = textInput as? UITextField {
            textField.autocorrectionType = .no
            textField.textColor = UIColor.veryLightPink
            textField.clearButtonMode = .never
            textField.isEnabled = false
        }
        
        let textfieldController = MDCTextInputControllerOutlined(textInput: textInput)
        textfieldController.isFloatingEnabled = true
        textfieldController.activeColor = UIColor.veryLightPink
        textfieldController.normalColor = UIColor.veryLightPink
        textfieldController.inlinePlaceholderColor = UIColor.veryLightPink
        textfieldController.floatingPlaceholderNormalColor = UIColor.veryLightPink
        textfieldController.floatingPlaceholderActiveColor = UIColor.veryLightPink
        textfieldController.leadingUnderlineLabelTextColor = UIColor.veryLightPink
        
        return textfieldController
    }
    
}
