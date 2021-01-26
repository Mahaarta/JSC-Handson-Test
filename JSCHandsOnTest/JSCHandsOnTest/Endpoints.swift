//
//  Endpoints.swift
//  JSCHandsOnTest
//
//  Created by Minata Mahaarta on 26/01/21.
//

import Foundation

private protocol Endpoint {
    var url: String { get }
}

private struct Api {
    static let baseUrlProd = "https://randomuser.me/api"
    static let baseUrlPre = "https://randomuser.me/api"
    static let baseUrlDev = "https://randomuser.me/api"
    
    #if IS_PRODUCTION
    static let baseUrl = baseUrlProd
    #elseif IS_PRE
    static let baseUrl = baseUrlPre
    #else
    static let baseUrl = baseUrlDev
    #endif
}

enum Endpoints {
    
    enum Guest: Endpoint {
        case dataContact
    
        public var url: String{
            switch self{
                case .dataContact: return "\(Api.baseUrl)"
            }
        }
    }
}
