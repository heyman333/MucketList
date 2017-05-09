//
//  PhotoInfo.swift
//  MucketList
//
//  Created by HanYoungsoo on 2017. 5. 4..
//  Copyright © 2017년 YoungsooHan. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import RealmSwift
import Realm

class PhotoInfo: Object {
    dynamic var id: String = "default"
    dynamic var image: Data?
    dynamic var date: Date?
    dynamic var latitude: Double = 0.0
    dynamic var longitude: Double = 0.0
    
    convenience init(_ data:(String, Data, Date, CLLocation?)) {
        
        self.init()
        print(data.0)
        self.id = data.0
        self.image = data.1
        self.date = data.2
        self.latitude = (data.3?.coordinate.latitude) != nil ? (data.3?.coordinate.latitude)! : 0.0
        self.longitude = (data.3?.coordinate.longitude) != nil ? (data.3?.coordinate.longitude)! : 0.0

    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    required init() {
        super.init()
    }
    
}

