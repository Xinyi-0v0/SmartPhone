//
//  ImageRealmFunctions.swift
//  FinalProject
//
//  Created by Xinyi Zhang on 4/22/23.
//

import Foundation
import RealmSwift


extension  UploadImagesViewController {
    
    func addDataToReamlmDB(ImageInfo : ImageInfo) {
        do {
            try realm.write{
                realm.add(ImageInfo, update: .modified )
            }
        } catch let err as NSError{
            print("unable to add value to the DB \(err)")
        }
    }
    

}



