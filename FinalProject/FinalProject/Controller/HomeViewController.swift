//
//  HomeViewController.swift
//  FinalProject
//
//  Created by Xinyi Zhang on 4/22/23.
//

import UIKit
import RealmSwift

class HomeViewController: UIViewController,UITableViewDelegate, UITableViewDataSource, SetImagesDelegate {
    
    let realm = try! Realm()
    
    var images : [UIImage] = [UIImage]()
    var locations = [String]()
    var imgTitle = [String]()
    
    
    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if(images.count == 0) {
            getAllValuesFromDB()
        }
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        imgTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("TableViewCell", owner: self)?.first as! TableViewCell
        cell.imgContainer.image = images[indexPath.row]
        cell.lblTitle.text = imgTitle[indexPath.row]
        cell.lblLocation.text = locations[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    
    func uploadedImageDelegate(img: UIImage, locationImg: String, titleImg: String) {
        images.append(img)
        imgTitle.append(titleImg)
        locations.append(locationImg)
        print(images.count)
        print(imgTitle.count)
        print(locations.count)
        tblView.reloadData()
    }
    
    func getAllValuesFromDB() {
        
    
        
        let imageInfos = realm.objects(ImageInfo.self)
        
        
        for imageInfo in imageInfos {
            guard let img = UIImage(data: imageInfo.image!) else { return }
            let title = imageInfo.title
            let location = imageInfo.location
            images.append(img)
            imgTitle.append(title)
            locations.append(location)
        }
        tblView.reloadData()
        
        
    }
    
}
