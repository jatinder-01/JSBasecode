//
//  AppColors.swift
//  DealersWorld
//


import UIKit

//MARK: - - Alert Messages Strings 
class AlertMessages{
    
    static let kEnterEmail = "Please Enter Email."
    static let kEnterValidEmailAddress = "Please Enter Valid Email."
    static let kEnterPassword = "Please Enter Password."
    static let kCheckPasswordLength = "Please Enter Minimum 8 Character of Password."
    static let kEnterConfirmPassword = "Please Enter Confirm Password."
    static let kPasswordNotMatch = "Password And Confirm Password Doesn't Match."
    static let kEnterInvitationCode = "Please Enter Invitation Code."
    static let kAgreeWithTermsPolicies = "Please Agree With Terms & Policies."
    static let kMinPriceIsGreaterThenMax = "Maximum Price Should be Greater Then Minimum Price."
    static let kEnterMinPrice = "Please Enter Min Price."
    static let kEnterMaxPrice = "Please Enter Max Price."
    static let kEnterBrand = "Please Enter Brand."
    static let kEnterModel = "Please Enter Model."
    static let kEnterYear = "Please Enter Year."
    static let kEnterLocation = "Please Enter Location."
    static let kEChooseCondition = "Please Choose Condition."
    static let kEnterProductDescription = "Please Enter Product Description."
    static let kEnterAskingPrice = "Please Enter Asking Price."
    static let kEnterRetailPrice = "Please Enter Retail Price."
    static let kChooseProductImages = "Please Choose Product Images."
    static let kReferenceNum = "Please Enter Reference No"
}

class AppStringConstants {
    static let kUploadPhoto = "Upload Photo"
    static let kSearch = "Search"
    static let kOffer = "Offer"
    static let kAddProduct = "Add Product"
    static let kDashBoard = "DashBoard"
    static let kMore = "More"
    static let kSponsored = "Sponsored"
    static let kOnHold = "On Hold"
    static let kSale = "Sale"
    static let kWTB = "WTB"
    static let kReferenceNo = "Reference No."
    static let kReviews = "Reviews"
    static let kRetailPrice = "Retail Price"
    static let kAskingPrice = "Asking Price"
    static let kMin = "Min"
    static let kMax = "Max"
    static let kLocation = "Location"
    static let kYear = "Year"
    static let kIncludes = "Includes"
    static let kCondition = "Condition"
    static let kModel = "Model"
    static let kTypeYourMessage = "Type Your Message"
    static let kDescription = "Description"
    static let kReset = "Reset"
    static let kPost = "Post"
    static let kPostForSale = "Post For Sale"
    static let kPostBuyRequest = "Post Buy Request"
    static let kMinimumRange = "Minimum Range"
    static let kPrice = "Price"
    static let kBox = "Box"
    static let kPapers = "Papers"
    static let kStickers = "Stickers"
    static let kHangTags = "Hang tags"
    static let kBrand = "Brand"
    static let kPostANewItem = "Post A New Item"
    static let kBrowse = "Browse"

    

}


class AppColors{
    
    static let primaryColor = UIColor(hexString:"d0ad61") // Primary Color medium brown color
    static let linkedText = UIColor(hexString:"c39052") // Dark brown color
    static let textColor = UIColor(hexString:"040404") // Black text color
    static let lightTextColor = UIColor(hexString:"040404") // Light text color
    static let borderColor = UIColor(hexString:"e1e1e1") // Light gray border color
    static let steelColor = UIColor(hexString:"80868b") // Dark gray color
    static let buttonTextColor = UIColor.white // White button title color
    static let greenColor = UIColor(hexString:"2E7D32") // Green color
    static let redColor = UIColor(hexString:"FF0000") // Red color

}

enum APIStatusCode:Int{
    
    case success      = 200
    case unAuthorized = 401
    case pageNotFound = 404
    case unexpected   = 500
}

enum APIHeaders{
    
    case accept
    case contentType
    case authorization
    case apiKey
}

enum ProductType: Int {
    case Sale       = 0
    case Buy        = 1
}

enum PickerSourceType {
    case Photos
    case Camera
}

enum LikeStatus: Int {
    case NoStatus    = 0
    case Like        = 1
    case DisLike     = 2
}

