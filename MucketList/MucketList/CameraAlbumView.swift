//
//  ViewController.swift
//  MucketList
//
//  Created by HanYoungsoo on 2017. 5. 4..
//  Copyright © 2017년 YoungsooHan. All rights reserved.
//

import UIKit

protocol MainPresenterProtocol {
    init(view:CameraAlbumView)
    func cameraFunction()
    func albumFunction()
    func loadAllData()
}

class CameraAlbumView: UIViewController {
    
    fileprivate var presenter: CameraAlbumSelectPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = CameraAlbumSelectPresenter(view:self)
    }
    
    @IBAction func cameraBtnClicked(_ sender: UIButton) {
        self.presenter?.cameraFunction()

    }
    @IBAction func albumBtnClicked(_ sender: UIButton) {
        self.presenter?.albumFunction()
    }
    
    @IBAction func showSavedData(_ sender: UIButton) {
        self.presenter?.loadAllData()
    }
   
}

extension CameraAlbumView: MainViewProtocol {
    
    func showContentsView(with model: PhotoInfo) {
        print("perform")
        self.performSegue(withIdentifier: "ShowContentsSegue", sender: model)
    }
    
    func showCollectionView(with model: Array<PhotoInfo>){
        self.performSegue(withIdentifier: "ShowAlbumSegue", sender: model)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowContentsSegue" {
            let contentsView = segue.destination as! ContentsViewController
            contentsView.photoInfo = sender as? PhotoInfo
        } else {
            let collectionView = segue.destination as! AlbumCollectionViewController
            collectionView.photoInfoArr = sender as! Array<PhotoInfo>
        }
    }
}
