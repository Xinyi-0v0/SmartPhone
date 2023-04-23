//
//  UploadImagesViewController.swift
//  FinalProject
//
//  Created by Xinyi Zhang on 4/22/23.
//

import UIKit
import CoreLocation
import RealmSwift

class UploadImagesViewController: UIViewController,CLLocationManagerDelegate,UITabBarControllerDelegate,  UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    let realm = try! Realm()
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var textTitle: UITextField!
    @IBOutlet weak var imgView: UIImageView!
    
    
    var setImagesDelegate: SetImagesDelegate?
    let defaultImage = UIImage(systemName: "person")
    let locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        
        tabBarController?.delegate = self
        textTitle.delegate = self
        
        //get current location
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestLocation()
        
        
    }
    
    @IBAction func takeAPicAction(_ sender: Any) {
        let actionSheet = UIAlertController(title: "Take a picture", message: "Something", preferredStyle: .alert)
        let cameraAction = UIAlertAction(title: "Camera", style: .default){ action in
            print("User selected camera")
            let imagePicker = UIImagePickerController ()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true)
        }
        
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default){ action in
            print("User Photo Library")
            let imagePicker = UIImagePickerController ()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true)
        }
        
        let cancelyAction = UIAlertAction(title: "Cancel", style: .default){ action in
            print("Cancel")
        }
        
        actionSheet.addAction(cameraAction)
        actionSheet.addAction(photoLibraryAction)
        actionSheet.addAction(cancelyAction)
        
        self.present(actionSheet,animated: true)
    }
    
    @IBAction func uploadImgAction(_ sender: Any) {
        guard let img = imgView.image else {return}
        guard let location = lblLocation.text else {return}
        guard let title = textTitle.text else {return}
        if(img == defaultImage || location == "" || title == "")  {
            lblStatus.text = "Please offer all necessary information"
            lblStatus.isHidden = false
            return
        }
        setImagesDelegate?.uploadedImageDelegate(img: img, locationImg: location, titleImg: title)
        
        lblStatus.text = "Upload Successfully"
        lblStatus.isHidden = false
        
        
        let imageData: Data? = img.jpegData(compressionQuality: 0.5)
        let imgData: ImageInfo = ImageInfo()
        imgData.title = title
        imgData.location = location
        imgData.image = imageData
        addDataToReamlmDB(ImageInfo: imgData)
        
        self.tabBarController?.selectedIndex = 0
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return
        }
        imgView.image = image
        picker.dismiss(animated:true)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        let geoEncoder = CLGeocoder()
        geoEncoder.reverseGeocodeLocation(location) { placemarks, error in
            if error != nil {
                print(error as Any)
                return
            }
            
            var address = ""
            guard let place = placemarks?.first else {return}
            if place.name != nil {
                address += place.name! + ","
            }
            
            if place.locality != nil {
                address += place.locality!
            }
            if place.subLocality != nil {
                address += place.subLocality! + ","
            }
            
            self.lblLocation.text=address
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationManager.requestLocation()
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        textTitle.text = ""
        lblStatus.text = "status"
        imgView.image = defaultImage
        lblStatus.isHidden = true
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
}
