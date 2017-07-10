
// OF THE WEB. NOT MINE 


////
////  ShowScreenShots.swift
////  ScreenshotPicker
////
////  Created by Yevgeniy Vasylenko on 7/6/17.
////  Copyright © 2017 Yevgeniy Vasylenko. All rights reserved.
////
//
//import UIKit
//import Photos
//
//
//class TestViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIImagePickerControllerDelegate {
//    
//    @IBOutlet weak var cameraRollCollectionView: UICollectionView!
//    
//    var assetCollection: PHAssetCollection!
//    var photosAsset: PHFetchResult<AnyObject>!
//    var assetThumbnailSize: CGSize!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        let fetchOptions = PHFetchOptions()
//        
//        let collection:PHFetchResult = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: fetchOptions)
//        
//        if let first_Obj:AnyObject = collection.firstObject{
//            //found the album
//            self.assetCollection = first_Obj as! PHAssetCollection
//        }
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        // Get size of the collectionView cell for thumbnail image
//        if let layout = self.cameraRollCollectionView!.collectionViewLayout as? UICollectionViewFlowLayout{
//            let cellSize = layout.itemSize
//            
//            self.assetThumbnailSize = CGSize(width: cellSize.width, height: cellSize.height)
//        }
//        
//        //fetch the photos from collection
//        self.photosAsset = (PHAsset.fetchAssets(in: self.assetCollection, options: nil) as AnyObject!) as! PHFetchResult<AnyObject>!
//        
//        
//        self.cameraRollCollectionView!.reloadData()
//        
//    }
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    
//    // MARK: UICollectionViewDataSource
//    
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
//    
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of items
//        var count: Int = 0
//        
//        if(self.photosAsset != nil){
//            count = self.photosAsset.count
//        }
//        
//        return count;
//    }
//    
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cameraCell", for: indexPath as IndexPath) as! UserImagesCollectionViewCell
//        
//        //Modify the cell
//        let asset: PHAsset = self.photosAsset[indexPath.item] as! PHAsset
//        
//        PHImageManager.default().requestImage(for: asset, targetSize: self.assetThumbnailSize, contentMode: .aspectFill, options: nil, resultHandler: {(result, info)in
//            if result != nil {
//                cell.userImage.image = result
//            }
//        })
//        
//        return cell
//    }
//    
//    // MARK: - UICollectionViewDelegateFlowLayout methods
//    func collectionView(collectinView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
//        return 4
//    }
//    
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
//        return 1
//    }
//    
//    // UIImagePickerControllerDelegate Methods
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
//        picker.dismiss(animated: true, completion: nil)
//    }
//    
//    
//}
