//
//  AllScreenShotsCollectionViewController.swift
//  ScreenshotPicker
//
//  Created by Yevgeniy Vasylenko on 7/6/17.
//  Copyright © 2017 Yevgeniy Vasylenko. All rights reserved.
//

import UIKit
import Photos

private let reuseIdentifier = "Thumbnail Cell Identifier"

class AllScreenShotsCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var requestOptions = PHImageRequestOptions()
    let imgManager = PHImageManager.default()
    var fetchResult: PHFetchResult<AnyObject>?
    var thumbnailSize: CGSize?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewWidth = view.bounds.size.width
        let desiredItemWidth: CGFloat = 100
        let columns: CGFloat = max(floor(viewWidth / desiredItemWidth), 4)
        let padding: CGFloat = 1
        let itemWidth = floor((viewWidth - (columns - 1) * padding) / columns)
        let itemSize = CGSize(width: itemWidth, height: itemWidth)
        let scale = UIScreen.main.scale
        
        thumbnailSize = CGSize(width: itemSize.width * scale, height: itemSize.height * scale)
    
        self.collectionView!.register(ThumbnailCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView!.backgroundColor = UIColor.white
        
        self.requestOptions.isSynchronous = true
        self.requestOptions.deliveryMode = .highQualityFormat
        
        self.navigationItem.title = NSLocalizedString("Pick Screenshot", comment: "title")
        let leftButtonItem = UIBarButtonItem(
            title: NSLocalizedString("Cancel", comment: "button"),
            style: .plain,
            target: self,
            action: #selector(leftButtonAction(sender:))
        )
        self.navigationItem.leftBarButtonItem = leftButtonItem
        checkStatus()
    }
    
    
    @objc func leftButtonAction(sender: UIBarButtonItem) {
        let picker = self.navigationController as! UIScreenShotPickerController
        (picker.delegate as! UIScreenShotPickerControllerDelegate).screenShotPickerControllerDidCancel(picker)
    }
    
    func checkStatus() {
        let status = PHPhotoLibrary.authorizationStatus()
        if status == PHAuthorizationStatus.authorized {
            loadPhotos()
        } else {
            PHPhotoLibrary.requestAuthorization({ (newStatus) in
                DispatchQueue.main.async {
                    if (newStatus == PHAuthorizationStatus.authorized) {
                        self.loadPhotos()
                    } else {
                        self.checkStatus()
                    }
                }
            })
        }
    }
    
    func loadPhotos() {
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        if Platform.isSimulator {
            fetchResult = PHAsset.fetchAssets(with: fetchOptions) as? PHFetchResult<AnyObject>
        } else {
            let collections = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumScreenshots, options: nil)
            let screenshots = collections.lastObject
            if let screenshots = screenshots {
                fetchResult = PHAsset.fetchAssets(in: screenshots, options: fetchOptions) as? PHFetchResult<AnyObject>
                self.collectionView?.reloadData()
            }
        }
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let fetchResult = fetchResult {
            return fetchResult.count
        } else {
            return 0
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ThumbnailCell
        imgManager.requestImage(for: fetchResult?.object(at: indexPath.row) as! PHAsset,
                                            targetSize: thumbnailSize!,
                                            contentMode: PHImageContentMode.aspectFill,
                                            options: requestOptions,
                                            resultHandler: { (image, _) in
                                                cell.thumbnailImage = image
                    })
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let fullPicture = FullImageViewController(fetchObject: self.fetchResult?.object(at: indexPath.row) as! PHAsset)
        self.navigationController?.pushViewController(fullPicture, animated: true)

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 4 - 1
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
}


