//
//  ApiManager.swift
//  DealersWorld
//


import Foundation
import UIKit
import Alamofire
import SVProgressHUD

typealias success = ([String: Any]) -> ()
typealias failure = (Error) -> ()

class ApiManager: NSObject {
    
    static let shared = ApiManager()
    private var alamofireSessionManager:SessionManager?
    
    private override init() {
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60 // seconds
        configuration.timeoutIntervalForResource = 60
        self.alamofireSessionManager = Alamofire.SessionManager(configuration: configuration)
//        self.alamofireSessionManager?.session.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
    }
    
    /*Get Method
     This is GET Method to Hit API's Of GET Method.
     */
    func getRequest(parameters:[String:Any],headers:[APIHeaders],apiEndPoint:String, completion: @escaping success){
        
        let URL = ApiConstants.baseUrl + apiEndPoint
        let headers: HTTPHeaders? = self.appendHeaders(headerTypes:headers)
        
        
        
        //alamofireSessionManager?.request(<#T##url: URLConvertible##URLConvertible#>, method: <#T##HTTPMethod#>, parameters: <#T##Parameters?#>, encoding: , headers: <#T##HTTPHeaders?#>)
        
        alamofireSessionManager!.request(URL,
                                         method:.get,
                                         parameters: parameters,
                                         encoding: URLEncoding.default,
                                         headers: headers)
            .responseJSON(completionHandler: { (response) in
                guard response.result.isSuccess else {
                    SVProgressHUD.dismiss()
                     AlertViewManager.showAlert(message: (response.result.error?.localizedDescription)!, alertButtonTypes: [.Okay])
                    return
                }
                guard let value = response.result.value,
                    let data = value as? [String: Any] else {
                        SVProgressHUD.dismiss()
                         AlertViewManager.showAlert(message: (response.result.error?.localizedDescription)!, alertButtonTypes: [.Okay])
                        return
                }
                completion(data)
            })
    }
    
    /*Post Method
     This is POST Method to Hit API's Of POST Method.
     */
    func postRequest(parameters:[String:Any],headers:[APIHeaders],apiEndPoint:String, completion: @escaping success){
        
        let URL = ApiConstants.baseUrl + apiEndPoint
        let headers: HTTPHeaders? = self.appendHeaders(headerTypes:headers) ?? nil
        
        alamofireSessionManager!.request(URL,
                                         method:.post,
                                         parameters: parameters,
                                         encoding: URLEncoding.default,
                                         headers: headers)
            .responseJSON(completionHandler: { (response) in
                
                guard response.result.isSuccess else {
                    SVProgressHUD.dismiss()
                    AlertViewManager.showAlert(message: (response.result.error?.localizedDescription)!, alertButtonTypes: [.Okay])
                    return
                }
                
                guard let value = response.result.value,
                    let data = value as? [String: Any] else {
                        SVProgressHUD.dismiss()
                        AlertViewManager.showAlert(message: (response.result.error?.localizedDescription)!, alertButtonTypes: [.Okay])
                        return
                }
                let statusCode = response.response?.statusCode
                if  statusCode == APIStatusCode.success.rawValue{//Return success data
                    completion(data)
                }else{// Handles Errors
                    self.handleErrorUsingStatusCode(statusCode: APIStatusCode(rawValue: statusCode!)!, errorMessage: (response.result.error?.localizedDescription)!)
                }
        })
    }
    
    /*Multipart Method
     This is MULTIPART Method to Hit API's Of MULTIPART Method.
     */
    func multipartRequest(parameters:[String:Any],fileName:String,images:[UIImage], apiEndPoint:String, completion: @escaping success){
        
        let URL = ApiConstants.baseUrl + apiEndPoint
        let headers: HTTPHeaders? = self.appendHeaders(headerTypes:[.apiKey,.authorization])
    
        alamofireSessionManager!.upload(multipartFormData: { multipartFormData in
            // import image to request
            for imageData in images {
                
                let data = imageData.pngData()//UIImage.jpegData(imageData)
                multipartFormData.append(data!, withName: "\(Date().timeIntervalSince1970).jpeg", fileName: fileName,mimeType: "image/jpeg")
            }
            
            for (key, value) in parameters {
                let data = (value as! String).data(using: String.Encoding.utf8)!
                multipartFormData.append(data, withName: key)
            }
            
        }, to: URL,
           method:.post,
           headers:headers,
           encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    let data = response.result.value
                    completion((data as? [String : Any])!)
                }
            case .failure(let error):
                SVProgressHUD.dismiss()
                AlertViewManager.showAlert(message: error.localizedDescription, alertButtonTypes: [.Okay])
            }
        })
    }
    
    /*
     This function will return headers
     */
    private func appendHeaders(headerTypes:[APIHeaders]?) -> [String:String]? {
        
        let headers = NSMutableDictionary()
        if headerTypes != nil {
            for header in headerTypes!{
                
                switch header {
                case .accept:
                    headers["Accept"] = "application/json"
                    break
                case .contentType:
                    headers["Content-Type"] = "application/json"
                    break
                case .authorization:
                    headers["Authorization"] = "Bearer \(UserDefaultManager.token)"
                    break
                case .apiKey:
                    headers["App-Key"] = "AWSCECDR3F4F54DFR"
                    break
                }
            }
        }
        return headers.count < 0 ? nil:headers as? [String:String]
    }
    
    /*
     This function will handle errors according to status code
     */
    private func handleErrorUsingStatusCode(statusCode:APIStatusCode,errorMessage:String){
     SVProgressHUD.dismiss()
        switch statusCode {
        case .unAuthorized:
            AlertViewManager.showAlert(message: errorMessage, alertButtonTypes: [.Okay])
            break
        case .pageNotFound:
            AlertViewManager.showAlert(message: errorMessage, alertButtonTypes: [.Okay])
            break
        case .unexpected:
            AlertViewManager.showAlert(message: errorMessage, alertButtonTypes: [.Okay])
            break
        default:
            break
        }
    }
}
