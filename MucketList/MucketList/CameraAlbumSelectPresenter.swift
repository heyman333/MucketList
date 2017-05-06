//
//  CameraAlbumSelectPresenter.swift
//  MucketList
//
//  Created by HanYoungsoo on 2017. 5. 4..
//  Copyright © 2017년 YoungsooHan. All rights reserved.
//

import Foundation
import UIKit
import Photos
import AssetsLibrary

class CameraAlbumSelectPresenter: NSObject, CameraAlbumSelectDelegate  {
    
    unowned let view: CameraAlbumView
    let locationManager = CLLocationManager()
    
    required init(view:CameraAlbumView){
        self.view = view
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }
}

extension CameraAlbumSelectPresenter: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus){
        switch status {
        case CLAuthorizationStatus.authorizedWhenInUse:
            manager.startUpdatingLocation()
        default:
            print("사용자가 동의하지 않았을때 처리")
        }
    }
}

extension CameraAlbumSelectPresenter: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        view.dismiss(animated: true, completion: nil)
    }
    
    func cameraFunction(){
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
            
            let imgPicker = UIImagePickerController()
            imgPicker.delegate = self
            imgPicker.sourceType = UIImagePickerControllerSourceType.camera
            imgPicker.allowsEditing = true
            view.present(imgPicker, animated: true, completion: nil)
            
        } else {
            print("Camara not Suppoted")
        }
        
    }
    
    func albumFunction(){
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary){
            
            let imgPicker = UIImagePickerController()
            imgPicker.delegate = self
            imgPicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            imgPicker.allowsEditing = true
            view.present(imgPicker, animated: true, completion: nil)
            
        } else {
            print("Album not Suppoted")
            
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        
        if picker.sourceType == .camera {

            addAsset(image: info["UIImagePickerControllerEditedImage"] as! UIImage, location: locationManager.location)
            
        } else {
            if let URL = info[UIImagePickerControllerReferenceURL] as? URL {
                let opts = PHFetchOptions()
                opts.fetchLimit = 1
                let assets = PHAsset.fetchAssets(withALAssetURLs: [URL], options: opts)
                let asset = assets.firstObject
                
                if let asset = asset{
                    
                    let photoInfo = PhotoInfo(image: info["UIImagePickerControllerEditedImage"] as! UIImage, date: asset.creationDate!, location: asset.location)
                    
                    view.dismiss(animated: true, completion:{ [unowned self] () -> Void in
                        self.view.showContentsView(with: photoInfo)
                        
                    })
                }
            }
        }
    }
    
    
    func addAsset(image: UIImage, location: CLLocation? = nil) {
        PHPhotoLibrary.shared().performChanges({
            // Request creating an asset from the image.
            let creationRequest = PHAssetChangeRequest.creationRequestForAsset(from: image)
            // Set metadata location
            if let location = location {
                creationRequest.location = location
            }
            
        }, completionHandler: { [unowned self] success, error in
            if !success { NSLog("error creating asset: \(String(describing: error))")
            } else {
                DispatchQueue.main.async {
                    self.view.dismiss(animated: true, completion: {
                        self.fetchLastImage(completion: { [unowned self] (asset) in
                            if let asset = asset{
                                let photoInfo = PhotoInfo(image: image, date: asset.creationDate!, location: asset.location)
                                    self.view.showContentsView(with: photoInfo)
                                }
                        })
                    })
                }
            }
        })
    }
    
    func fetchLastImage(completion: (_ lastImageAsset: PHAsset?) -> Void) {
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        fetchOptions.fetchLimit = 1
        
        let fetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        if (fetchResult.firstObject != nil)
        {
            let lastImageAsset: PHAsset = fetchResult.firstObject!
            completion(lastImageAsset)
        } else {
            completion(nil)
        }
    }
}

