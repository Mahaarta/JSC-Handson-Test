//
//  Constants.swift
//  JSCHandsOnTest
//
//  Created by Minata Mahaarta on 26/01/21.
//

import UIKit
import SwifterSwift

enum Constants {
    
    static var clientId = 57 // 57: MonkeyTree
    static var appId = 20 // 20: MonkeyTree
    static var typePublicationNews = "1"
    static var typePublicationPromo = "2"
    static var ovoChannelCode = "01"
    
    static var defaultErrorTitle = "Failed"
    static var defaultErrorMessage = "Error, please try again"
    static var defaultSuccessTitle = "Success"
    static var defaultSuccessMessage = "Success"

    static var errorEmptyField = "Field can't be empty"
}

enum UD: String {
    case isLoggedIn
    case employee_id
    case accessToken
    case userId
    case userPhoto
    case name
    case userName
    case isUserGuest
    case userEmail
    case userPhone
    case userGroupCode
    case client_id
    case selectedStudentCode
    case selectedStudentIndexPath
    
    public var key: String {
        return self.rawValue
    }
}

enum Sex: String, CaseIterable {
    case male
    case female
    
    public var charCode: String {
        switch self {
        case .male:
            return "L"
        default:
            return "P"
        }
    }
    
    public var desc: String {
        switch self {
        case .male:
            return "Male"
        default:
            return "Female"
        }
    }

}
