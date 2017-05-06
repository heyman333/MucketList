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

class PhotoInfo {
   dynamic let image: Data?
   dynamic let date: Date?
   dynamic let location: CLLocation?
    
    init() {
        image = nil
        date = nil
        location = nil
    }
    
    init(image: Data?, date: Date?, location: CLLocation?) {
        self.image = image
        self.date = date
        self.location = location
    }


}

