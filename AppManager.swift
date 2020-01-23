//
//  AppManager.swift
//  DealersWorld
//



import UIKit

class AppManager: NSObject {

    /*
     This function will get presented ViewController
     */
    static func getPresentedViewController()->UIViewController?{
        
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        return nil
    }
    
    /*
     This function will convert json to jsonString
     */
    static func convertJsonToJsonString(json:[String:Any])->String{
        
        let jsonData = try! JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted)
        let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
        return jsonString
        
    }
    
    /// This function is used to get size of string
    ///
    /// - Parameters:
    ///   - text: get string to calculate size
    ///   - padding: add padding from left/right
    /// - Returns: this returns CGRect of text.
    static func estimateFrameForText(text: String, padding: CGFloat) -> CGRect {
        
        let size = CGSize(width: 400, height: 34)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let attributes = [NSAttributedString.Key.font: R.font.proximaNovaBold(size: 17.0)]
        
        var frame = NSString(string: text).boundingRect(with: size, options: options, attributes: attributes as [NSAttributedString.Key : Any], context: nil)
        frame.size.width = frame.size.width + padding
        return frame
    }
//    ProximaNova-Bold 16.0
    
    /// This function is used to save filters in userdefaults
    ///
    /// - Parameters:
    ///   - filtersDict: receiver filters in dictionary
    ///   - productType: product list type to save filters
    static func saveFilters(filtersDict:[String:Any],productType:ProductType){
        
        switch productType {
        case .Buy:
            UserDefaultManager.buyFilters = filtersDict
            break
        case .Sale:
            UserDefaultManager.saleFilters = filtersDict
            break
        }
    }
    
    static func getFilters(productType:ProductType)->[String:Any]?{
        
        switch productType {
        case .Buy:
            return UserDefaultManager.buyFilters
            
        case .Sale:
            return UserDefaultManager.saleFilters
        }
    }
}
