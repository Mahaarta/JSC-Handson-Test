//
//  DataContactRequest.swift
//  JSCHandsOnTest
//
//  Created by Minata Mahaarta on 26/01/21.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol DataContactRequestDelegate: class {
    func DataContactRequestSuccess(_ dataContactList: DataContactList)
    func DataContactRequestFailed(_ message: String)
}

class DataContactRequest: ApiInterface {
    var method: HTTPMethod?
    
    var url: URLConvertible
    
    var headers: HTTPHeaders?
    
    var parameters: Parameters?
    
    var encoding: ParameterEncoding?
    
    var requestHandler: DataContactRequestDelegate?
    
    // MARK: Inits
    required init() {
        method = .get
        url = Endpoints.Guest.dataContact.url
    }
    
    func start() {
        ApiHelper.apiRequest(api: self)
    }
    
    func prepare(
        requestHandler: DataContactRequestDelegate) {
        self.requestHandler = requestHandler
        
        parameters = [
            "results": 5,
            "exc": "login,registered,i%20d,nat",
            "nat": "us",
            "noinfo": ""
        ]
        print("DataContactRequestDelegate param  \(parameters ?? [:])")
    }
    
    func success(_ value: JSON) {
        print("DataContactRequestDelegate value \(value)")
        createObject(value)
    }
    
    func failed(_ value: JSON?) {
        requestHandler?.DataContactRequestFailed(value?["message"].stringValue ?? Constants.defaultErrorMessage)
    }
    
    func createObject(_ value: Any) {
        guard let json = value as? JSON else { return }
        if let dict = json.dictionaryObject, let response = DataContactList(JSON: dict) {
            requestHandler?.DataContactRequestSuccess(response)
        } else {
            failed(nil)
        }
    }
}
