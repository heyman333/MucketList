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
    dynamic var image: Data?
    dynamic var date: Date?
    dynamic var latitude: Double = 0.0
    dynamic var longitude: Double = 0.0
    
    convenience init(_ data:(Data, Date, CLLocation?)) {
        self.init()
        self.image = data.0
        self.date = data.1
        self.latitude = (data.2?.coordinate.latitude) != nil ? (data.2?.coordinate.latitude)! : 0.0
        self.longitude = (data.2?.coordinate.longitude) != nil ? (data.2?.coordinate.longitude)! : 0.0

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

