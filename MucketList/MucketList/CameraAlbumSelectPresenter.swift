//
//  CameraAlbumSelectPresenter.swift
//  MucketList
//
//  Created by HanYoungsoo on 2017. 5. 4..
//  Copyright © 2017년 YoungsooHan. All rights reserved.
//

import Foundation
import UIKit

class CameraAlbumSelectPresenter: NSObject, CameraAlbumSelectDelegate  {
    
    unowned let view: CameraAlbumView
    
    required init(view:CameraAlbumView){
        self.view = view
    }

}


extension CameraAlbumSelectPresenter: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func cameraFunction(){
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
            
            let imgPicker = UIImagePickerController()
            imgPicker.delegate = self
            imgPicker.sourceType = UIImagePickerControllerSourceType.camera
            imgPicker.allowsEditing = true
            view.present(imgPicker, animated: true, completion: nil)
        }
        
    }
    
    func albumFunction(){
        print("앨범 액션!")
    }

}

