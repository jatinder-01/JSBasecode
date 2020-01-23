//
//  ImagePickerManager.swift
//  DealersWorld
//


import Foundation
import UIKit

protocol ImagePickerDelegate {
    
    func imagePickerDidFinish(image:UIImage)
}

class ImagePickerManager:UIViewController{
    
    static let shared = ImagePickerManager()
    private var imagePicker = UIImagePickerController()
    private var delegates:ImagePickerDelegate?
    private var presendtedView:UIViewController?
    
  
    //MARK: - - OpenImagePicker
    
    /// This function will open actionsheet for choosing camera or photos
    func openImagePicker(delegate:ImagePickerDelegate){
        
        self.presendtedView = AppManager.getPresentedViewController()
        self.delegates = delegate
        
        AlertViewManager.showAlert(title: AppStringConstants.kUploadPhoto, message: "", alertButtonTypes: [.Camera,.Photos,.Cancel], alertStyle: .actionSheet) { (action) in
           
            switch action {
            case .Photos:
                self.openImagePicker(picker: .Photos, pickerSourceType: UIImagePickerController.SourceType.photoLibrary)
                break
            case .Camera:
                self.openImagePicker(picker: .Camera, pickerSourceType: UIImagePickerController.SourceType.camera)
                break
            default:
                self.dismiss(animated: true, completion: nil)
                break
            }
        }
    }
    
    
    /// This function will open image picker according to selected type
    ///
    /// - Parameter pickerSourceType: Picker type is for defining type of source (camera/photos)
    private func openImagePicker(picker: PickerSourceType, pickerSourceType:UIImagePickerController.SourceType){
        
        if UIImagePickerController.isSourceTypeAvailable(pickerSourceType){
            
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = picker == .Photos ? .photoLibrary : .camera
            self.presendtedView!.present(imagePicker, animated: true, completion: nil)
        }
    }
}

extension ImagePickerManager: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let tempImage = info[UIImagePickerController.InfoKey.editedImage] as! UIImage

        self.delegates?.imagePickerDidFinish(image: tempImage)
        self.presendtedView!.dismiss(animated: true, completion: nil)
    }
}
