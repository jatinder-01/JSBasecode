//
//  UserDefaultManager.swift
//  DealersWorld
//


import UIKit

/*
 This class is used to save and get values to/from Userdefaults
 */
class UserDefaultManager: NSObject {

    //User id
    static var userId:Int{
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.kToken)
        }
        get{
            return UserDefaults.standard.value(forKey: Keys.kToken) as? Int ?? 0
        }
    }
    
    //User authentication token
    static var token:String{
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.kToken)
        }
        get{
            return UserDefaults.standard.value(forKey: Keys.kToken) as? String ?? ""
        }
    }
    
    //sale filters
    static var saleFilters:[String:Any]?{
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.kSaleFilters)
        }
        get{
            return UserDefaults.standard.value(forKey: Keys.kSaleFilters) as? [String:Any]
        }
    }
    
    //buy filters
    static var buyFilters:[String:Any]?{
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.kBuyFilters)
        }
        get{
            return UserDefaults.standard.value(forKey: Keys.kBuyFilters) as? [String:Any]
        }
    }
    
}
