//
//  TabBarViewController.swift
//  FinalProject
//
//  Created by Xinyi Zhang on 4/22/23.
//

import UIKit
import RealmSwift

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
   
        let homeViewController = viewControllers?[0] as! HomeViewController
        let uploadPicVC = viewControllers?[1] as! UploadImagesViewController
        uploadPicVC.setImagesDelegate = homeViewController
    }
    
    
    



}
