//
//  Extensions.swift
//  DealersWorld
//


import UIKit

extension UIColor
{
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

extension UIView{
    
    func setBorder(radius:CGFloat, color:UIColor = UIColor.clear){
        self.layer.cornerRadius = CGFloat(radius)
        self.layer.borderWidth = 1
        self.layer.borderColor = color.cgColor
        self.clipsToBounds = true
    }
}

extension String{
    /*
     This function will remove whitespace
     */
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
    
    /*
     This function will check that the email id is valid or not
     */
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }

}

extension UITextField {
    
    enum PaddingSide {
        case left(CGFloat)
        case right(CGFloat)
        case both(CGFloat)
    }
    
    func addPadding(_ padding: PaddingSide) {
        
        self.leftViewMode = .always
        self.layer.masksToBounds = true
        
        
        switch padding {
            
        case .left(let spacing):
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            self.leftView = paddingView
            self.rightViewMode = .always
            
        case .right(let spacing):
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            self.rightView = paddingView
            self.rightViewMode = .always
            
        case .both(let spacing):
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            // left
            self.leftView = paddingView
            self.leftViewMode = .always
            // right
            self.rightView = paddingView
            self.rightViewMode = .always
        }
    }
    
    func setLeftImage(image: UIImage)  {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let imageView = UIImageView(frame: CGRect(x: 5, y: 5, width: 20, height: 20))
        imageView.image = image
        view.addSubview(imageView)
        self.leftView = view
        self.leftViewMode = .always

    }
    
}

extension UINavigationController{
    
    /*
     This function will change navigation bar color
     */
    func setBackgroundColor(barColor:UIColor,textColor:UIColor) {
        self.navigationBar.isTranslucent = false
        self.navigationBar.barTintColor = barColor
        self.navigationBar.titleTextAttributes = [.foregroundColor: textColor]
    }
    
    /*
     This function will make navigation bar transparent
     */
    func makeBarTransparent(){
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = true
        self.view.backgroundColor = .clear
    }
    
    func setNavigationTitle(withTitle title : String ,withLeftButton show : Bool, onController controller : UIViewController)
    {
        var leftBarItem : UIButton!
        if show
        {
            leftBarItem = UIButton(type: .custom)
            leftBarItem.setImage(R.image.arrowBack(), for: .normal)
            leftBarItem.frame = CGRect(x: 0, y: 0, width: 30, height: 40)
            leftBarItem.imageView?.contentMode = .scaleAspectFit
            leftBarItem.addTarget(controller, action: Selector(("backBtnAction")), for: .touchUpInside)
            leftBarItem.sizeToFit()
        
            controller.navigationItem.leftBarButtonItems = [UIBarButtonItem(customView: leftBarItem)]

        }else{
            controller.navigationItem.hidesBackButton = true
        }
        controller.navigationItem.title = title
    }
    
}

extension Array where Element: Equatable {
    
    // Remove first collection element that is equal to the given `object`:
    mutating func remove(object: Element) {
        guard let index = index(of: object) else {return}
        remove(at: index)
    }
    
}


extension UIImage {
    
    class func imageWithColor(color: UIColor, size: CGSize) -> UIImage {
        let rect: CGRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}

