//
//  ImageInfo.swift
//  FinalProject
//
//  Created by Xinyi Zhang on 4/22/23.
//

import Foundation
import RealmSwift

class ImageInfo: Object {


    @objc dynamic var title: String = ""
    @objc dynamic var image: Data?
    @objc dynamic var location: String = ""
    
    //make symbol as primary key
    override static func primaryKey() -> String? {
        return "title"
    }
    
    
}
