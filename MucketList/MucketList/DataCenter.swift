//
//  DataCenter.swift
//  MucketList
//
//  Created by HanYoungsoo on 2017. 5. 7..
//  Copyright © 2017년 YoungsooHan. All rights reserved.
//

import Foundation
import RealmSwift


final class DataCenter {
    
    private var realm: Realm?
    
    static let shared = DataCenter()
    
    init() {
        self.realm = try! Realm()
    }
    
    func savePhotoInfo(with photoInfo: PhotoInfo) {
        if let realm = realm {
            try! realm.write {
                realm.add(photoInfo)
            }
        }
    }
    
    func getAllDatas() -> Array<PhotoInfo>? {
        
        if let realm = realm {
            let allDatas = realm.objects(PhotoInfo.self)
            return Array(allDatas)
        } else {
            print("realm객체가 생성되지 않았습니다.")
            return nil
        }
    }
    
    
}
