//
//  AlbumCollectionViewController.swift
//  MucketList
//
//  Created by HanYoungsoo on 2017. 5. 8..
//  Copyright © 2017년 YoungsooHan. All rights reserved.
//

import UIKit

class AlbumCollectionViewController: UIViewController {
    
    var photoInfoArr: Array<PhotoInfo>!
    
    @IBOutlet weak var photoAlbumCollectionView: UICollectionView!
    @IBOutlet weak var photoAlbumCollectionViewLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var toolBar: UIToolbar!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.layoutIfNeeded()
    
        print(photoAlbumCollectionView.frame.size.width)
        let itemSize = (photoAlbumCollectionView.frame.size.width - 10) / 2.0
        photoAlbumCollectionViewLayout.itemSize = CGSize(width: itemSize, height: itemSize)

        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x: 0.0, y: toolBar.frame.height-0.5, width: toolBar.frame.width, height: 0.5)
        bottomBorder.backgroundColor = UIColor.gray.cgColor
        toolBar.layer.addSublayer(bottomBorder)
        navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
    }
    

}

extension AlbumCollectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoInfoArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlbumCollectionCell", for: indexPath) as! AlbumCollectionViewCell
        
        if let cellImg = photoInfoArr[indexPath.row].image, let date = photoInfoArr[indexPath.row].date {
            
            cell.takenImgView.image = UIImage(data: cellImg)
            cell.takenDate.text = date.description(with: Locale.current)
            print(date.description(with: Locale.current))
            
        } else {
            
            cell.takenImgView.image = UIImage(named:"Steve")
            cell.takenDate.text = "로딩실패"
            
        }
        
        return cell
    }
}

extension AlbumCollectionViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "AlbumCollectionToContentsSegue", sender: photoInfoArr[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let contentsView = segue.destination as! ContentsViewController
        contentsView.photoInfo = sender as? PhotoInfo
    }

}

