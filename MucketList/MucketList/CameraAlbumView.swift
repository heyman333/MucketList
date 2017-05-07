//
//  ViewController.swift
//  MucketList
//
//  Created by HanYoungsoo on 2017. 5. 4..
//  Copyright © 2017년 YoungsooHan. All rights reserved.
//

import UIKit

protocol PresenterProtocol {
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

extension CameraAlbumView: ViewProtocol {
    
    func showContentsView(with model: PhotoInfo) {
        print("perform")
        self.performSegue(withIdentifier: "showContentsSegue", sender: model)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let contentsView = segue.destination as! ContentsViewController
        contentsView.photoInfo = sender as? PhotoInfo
    }
}
