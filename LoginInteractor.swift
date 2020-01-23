//
//  LoginInteractor.swift
//  DealersWorld
//

import UIKit
import ObjectMapper
import SVProgressHUD
class LoginInteractor: NSObject, LoginInteractorProtocols {
    
    //MARK: - - Variables
    var presenter:LoginPresenterProtocols?
    
    //MARK: - - Methods 
    /*
     This function will call login API for normal users
     */
    func callNormalLoginAPI(params: [String : Any]) {
        SVProgressHUD.show()
        ApiManager.shared.postRequest(parameters: params, headers: [.apiKey], apiEndPoint: ApiConstants.login) { (response) in
         
            let jsonString = AppManager.convertJsonToJsonString(json: response)
            let loginDataObjectMapper = Mapper<LoginDataObjectMapper>().map(JSONString: jsonString)
            let loginEntity = EntityManager.mapLoginResponseToEntity(loginBaseMapper: loginDataObjectMapper!)
            UserDefaultManager.userId = loginEntity.userId!
            UserDefaultManager.token = loginEntity.token!
            self.presenter?.loggedInUsingEmail(loginEntity: loginEntity)
            SVProgressHUD.dismiss()
        }
    }
    
    /*
     This function will call login/signup API for social media users
     */
    func callSocialLoginAPI(params: [String : Any]) {
        
    }
    
    /*
     This function will validate user using Facebook
     */
    func loginUsingFacebook() {
        
    }
    
    /*
     This function will validate user using Google
     */
    func loginUsingGoogle() {
        
    }
}
