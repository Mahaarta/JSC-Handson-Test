//
//  ApiHelper.swift
//  JSCHandsOnTest
//
//  Created by Minata Mahaarta on 26/01/21.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwifterSwift
import Kingfisher

class ErrorObject: NSObject {
    var errorCode: String?
    var message: String
    var errorHandlerType: ErrorHandlerType
    
    init(errorCode: String?, message: String, errorHandlerType: ErrorHandlerType) {
        self.errorCode = errorCode
        self.message = message
        self.errorHandlerType = errorHandlerType
    }
}

enum ErrorHandlerType {
    case doNothing
    case showSnackbarOnly
    case backToPreviousPage
    case backToProductHomePage
    case backToRootPage
}

protocol ApiInterfaceDelegate: class {
    func onSuccess(interface: ApiInterface?, object: Any)
    func onFailed(interface: ApiInterface?, errorCode: String?, message: String, errorHandlerType: ErrorHandlerType)
}

protocol ApiInterface: class {
    var method: HTTPMethod? { get set }
    var url: URLConvertible { get set }
    var headers: HTTPHeaders? { get set }
    var parameters: Parameters? { get set }
    //var dataCustomId: Int? { get set }
    var encoding: ParameterEncoding? { get set }
    
    func start()
    func success(_ value: JSON)
    func failed(_ value: JSON?)
    func createObject(_ value: Any)
}

class ApiHelper {
    
    static let shared = ApiHelper()
    static var manager = setupSessionManager()
    
    func plainJsonHeader() -> HTTPHeaders {
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        return headers
    }
    
    static func setupSessionManager(timeoutForRequest: Double = 300, timeoutForResource: Double = 300) -> SessionManager {
        let configuration = URLSessionConfiguration.default
        
        // Set Timeout
        configuration.timeoutIntervalForRequest = timeoutForRequest
        configuration.timeoutIntervalForResource = timeoutForResource
        
        return Alamofire.SessionManager(configuration: configuration)
    }
    
    static func setupDefaultHeader(headers: HTTPHeaders) -> HTTPHeaders {
        // Insert your common headers here, for example, authorization token or accept.
        var commonHeaders: [String: String] = [:]
        
        commonHeaders["Accept"] = "application/json, text/plain"
        //commonHeaders["Authorization"] = "Bearer \(UserDefaults.standard.string(forKey: UD.accessToken.key) ?? "")"
        //        commonHeaders["Accept-Encoding"] = "gzip, deflate"
        //        commonHeaders["Accept-Language"] = "en;q=1"
        //        commonHeaders["Content-Type"] = "application/json"
//        commonHeaders["User-Agent"] = "PegiPegi/\(SwifterSwift.appVersion ?? "") (iPhone; iOS \(SwifterSwift.systemVersion); Scale/2.00)"
        
//        commonHeaders["X-Auth-UserId"] = "pepe123"
//        commonHeaders["X-Auth-Token"] = "db3255146c31"
        
        // Replace old value with new value
        commonHeaders.merge(headers) { (_, new) in new }
        
        return commonHeaders
    }
    
    static func apiRequest(api: ApiInterface) {
        // Insert your common headers here, for example, authorization token or accept.
        let allHeaders = ApiHelper.setupDefaultHeader(headers: api.headers ?? [:])
        
        if CommonHelper.shared.isConnectedToInternet() {
            
            //print("API HELPER \(api.parameters)")
            
            //if api.dataCustomId != nil {
            //    print("data dataCustomId ada")
            //} else {
            //    print("data dataCustomId GAada")
            //}
            
            
            ApiHelper.manager
                .requestWithoutCache(api.url, method: api.method ?? .get, parameters: api.parameters, encoding: api.encoding ?? URLEncoding.default, headers: allHeaders)?
                .validate(statusCode: 200..<600)
                .responseJSON(completionHandler: { (response) in
                    switch response.result {
                    case .success(let result):

                        let request = response.request
                        let header = response.request?.allHTTPHeaderFields
                        let params = api.parameters
                        
                        //TODO: Uncomment if you want to see json response
                        #if !IS_PRODUCTION
                        print("statusCode: success \(response.response?.statusCode ?? -1)")
                        print(request ?? "")
                        print(JSON(header ?? [:]))
                        print(JSON(params ?? [:]))
                        print(response.result.value ?? JSON([:]))
                        #endif
                        
                        // Valid JSON Response
                        guard let value = response.result.value else {
                            // No Response Value
                            print("Default Error Message")
                            api.failed(nil)
                            return
                        }
                        
                        // Valid Success Response
                        api.success(JSON(value))
                    case .failure(let error):

                        let request = response.request
                        let header = response.request?.allHTTPHeaderFields
                        let params = api.parameters
                        
                        //TODO: Uncomment if you want to see json response
                        #if !IS_PRODUCTION
                        print("statusCode: failed \(response.response?.statusCode ?? -1)")
                        print(request ?? "")
                        print(JSON(header ?? [:]))
                        print(JSON(params ?? [:]))
                        print(response.result.value ?? JSON([:]))
                        print("StatusCode: \(response.response?.statusCode ?? 0)")
                        print("Error: \(error)")
                        #endif
                        
                        if response.response?.statusCode == 500 || response.response?.statusCode == 503 {
                            // Internet Lost, Service Unavailable, Internal Server Error
                            print("Internet Lost, Service Unavailable, Internal Server Error")
                            api.failed(nil)
                        } else if error._code == NSURLErrorTimedOut || response.response?.statusCode == 408 {
                            // RTO
                            print("Request Time Out")
                            api.failed(nil)
                        } else if error._code == NSURLErrorCancelled {
                            // Cancelled
                            print("Cancelled")
                            api.failed(["network_error": NSURLErrorCancelled])
                        } else {
                            // Valid JSON Response
                            guard let value = response.result.value else {
                                // No Response Value
                                print("Default Error Message")
                                api.failed(nil)
                                return
                            }
                            
                            // Valid Failed Response
                            api.failed(JSON(value))
                        }
                    }
                })
        } else {
            // Internet Lost, Service Unavailable, Internal Server Error
            print("Internet Lost, Service Unavailable, Internal Server Error")
            api.failed(nil)
        }
    }
    
    // custom id
    static func apiRequestCustom(api: ApiInterface, id: Int) {
        // Insert your common headers here, for example, authorization token or accept.
        let allHeaders = ApiHelper.setupDefaultHeader(headers: api.headers ?? [:])
        
        if CommonHelper.shared.isConnectedToInternet() {
            ApiHelper.manager
                .requestWithoutCache("\(api.url)/\(id)", method: api.method ?? .get, parameters: api.parameters, encoding: api.encoding ?? URLEncoding.default, headers: allHeaders)?
                .validate(statusCode: 200..<600)
                .responseJSON(completionHandler: { (response) in
                    switch response.result {
                    case .success(let result):

                        let request = response.request
                        let header = response.request?.allHTTPHeaderFields
                        let params = api.parameters
                        
                        //TODO: Uncomment if you want to see json response
                        #if !IS_PRODUCTION
                        print("statusCode: success \(response.response?.statusCode ?? -1)")
                        print(request ?? "")
                        print(JSON(header ?? [:]))
                        print(JSON(params ?? [:]))
                        print(response.result.value ?? JSON([:]))
                        #endif
                        
                        // Valid JSON Response
                        guard let value = response.result.value else {
                            // No Response Value
                            print("Default Error Message")
                            api.failed(nil)
                            return
                        }
                        
                        // Valid Success Response
                        api.success(JSON(value))
                    case .failure(let error):

                        let request = response.request
                        let header = response.request?.allHTTPHeaderFields
                        let params = api.parameters
                        
                        //TODO: Uncomment if you want to see json response
                        #if !IS_PRODUCTION
                        print("statusCode: failed \(response.response?.statusCode ?? -1)")
                        print(request ?? "")
                        print(JSON(header ?? [:]))
                        print(JSON(params ?? [:]))
                        print(response.result.value ?? JSON([:]))
                        print("StatusCode: \(response.response?.statusCode ?? 0)")
                        print("Error: \(error)")
                        #endif
                        
                        if response.response?.statusCode == 500 || response.response?.statusCode == 503 {
                            // Internet Lost, Service Unavailable, Internal Server Error
                            print("Internet Lost, Service Unavailable, Internal Server Error")
                            api.failed(nil)
                        } else if error._code == NSURLErrorTimedOut || response.response?.statusCode == 408 {
                            // RTO
                            print("Request Time Out")
                            api.failed(nil)
                        } else if error._code == NSURLErrorCancelled {
                            // Cancelled
                            print("Cancelled")
                            api.failed(["network_error": NSURLErrorCancelled])
                        } else {
                            // Valid JSON Response
                            guard let value = response.result.value else {
                                // No Response Value
                                print("Default Error Message")
                                api.failed(nil)
                                return
                            }
                            
                            // Valid Failed Response
                            api.failed(JSON(value))
                        }
                    }
                })
        } else {
            // Internet Lost, Service Unavailable, Internal Server Error
            print("Internet Lost, Service Unavailable, Internal Server Error")
            api.failed(nil)
        }
    }
    
    static func apiRequestUploadImage(api: ApiInterface) {
        // Insert your common headers here, for example, authorization token or accept.
        let allHeaders = ApiHelper.setupDefaultHeader(headers: api.headers ?? [:])
        
        guard let params = api.parameters else { return }
        
        ApiHelper.manager
            .upload(multipartFormData: { (multipartFormData) in
                for (key, val) in params {
                    if let str = val as? String, let strData = str.data(using: .utf8) {
                        multipartFormData.append(strData, withName: key)
                    } else if let image = val as? UIImage {
                        if let imageData = image.kf.pngRepresentation() {
                            multipartFormData.append(imageData, withName: key, fileName: "image.png", mimeType: "image/png")
                        }
                    }
                }
            }, usingThreshold: UInt64.init(), to: api.url, method: api.method ?? .get, headers: allHeaders) { (encodingResult) in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.uploadProgress(closure: { (progress) in
                        print("Upload Progress: \(progress.fractionCompleted)")
                    })
                    
                    upload.validate().responseJSON(completionHandler: { (response) in
                        switch response.result {
                        case .success(let result):
                            let request = response.request
                            let header = response.request?.allHTTPHeaderFields
                            let params = api.parameters
                            
                            //TODO: Uncomment if you want to see json response
                            #if !IS_PRODUCTION
                            print(request ?? "")
                            print(JSON(header ?? [:]))
                            print(JSON(params ?? [:]))
                            print(response.result.value ?? JSON([:]))
                            #endif
                            
                            // Valid JSON Response
                            guard let value = response.result.value else {
                                // No Response Value
                                print("Default Error Message")
                                api.failed(nil)
                                return
                            }
                            
                            // Valid Success Response
                            api.success(JSON(value))
                        case .failure(let error):
                            let request = response.request
                            let header = response.request?.allHTTPHeaderFields
                            let params = api.parameters
                            
                            //TODO: Uncomment if you want to see json response
                            #if !IS_PRODUCTION
                            print(request ?? "")
                            print(JSON(header ?? [:]))
                            print(JSON(params ?? [:]))
                            print(response.result.value ?? JSON([:]))
                            print("StatusCode: \(response.response?.statusCode ?? 0)")
                            print("Error: \(error)")
                            #endif
                            
                            if response.response?.statusCode == 500 || response.response?.statusCode == 503 {
                                // Internet Lost, Service Unavailable, Internal Server Error
                                print("Internet Lost, Service Unavailable, Internal Server Error")
                                api.failed(nil)
                            } else if error._code == NSURLErrorTimedOut || response.response?.statusCode == 408 {
                                // RTO
                                print("Request Time Out")
                                api.failed(nil)
                            } else {
                                // Valid JSON Response
                                guard let value = response.result.value else {
                                    // No Response Value
                                    print("Default Error Message")
                                    api.failed(nil)
                                    return
                                }
                                
                                // Valid Failed Response
                                api.failed(JSON(value))
                            }
                        }
                    })
                case .failure(let encodingError):
                    print(encodingError)
                }
        }
    }
}

extension Alamofire.SessionManager {
    
    @discardableResult
    open func requestWithoutCache(
        _ url: URLConvertible,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil) // also you can add URLRequest.CachePolicy here as parameter
        -> DataRequest? {
            do {
                var urlRequest = try URLRequest(url: url, method: method, headers: headers)
                urlRequest.cachePolicy = .reloadIgnoringCacheData // <<== Cache disabled
                let encodedURLRequest = try encoding.encode(urlRequest, with: parameters)
                return request(encodedURLRequest)
            } catch {
                // TODO: find a better way to handle error
                print(error)
                
                guard let url = "http://example.com/wrong_request".url else { return nil }
                return request(URLRequest(url: url))
            }
    }
    
}
