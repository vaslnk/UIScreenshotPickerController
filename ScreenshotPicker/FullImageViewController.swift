//
//  FullImageViewController.swift
//  ScreenshotPicker
//
//  Created by Yevgeniy Vasylenko on 7/7/17.
//  Copyright © 2017 Yevgeniy Vasylenko. All rights reserved.
//

import UIKit
import Photos

class FullImageViewController: UIViewController {

    var fetchObject: PHAsset
    let imageView = UIImageView()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false
        
        self.view.addSubview(imageView)
        imageView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        imageView.contentMode = .scaleAspectFit
        self.edgesForExtendedLayout = []

        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true
        requestOptions.deliveryMode = .highQualityFormat

        
        PHImageManager.default().requestImage(for: fetchObject,
                                              targetSize: PHImageManagerMaximumSize,
                                              contentMode: PHImageContentMode.aspectFit,
                                              options: requestOptions,
                                              resultHandler: { (image, _) in
                                                self.imageView.image = image
        })
        
        let rightButtonItem = UIBarButtonItem(
            title: NSLocalizedString("Done", comment: "button"),
            style: .plain,
            target: self,
            action: #selector(rightButtonAction(sender:))
        )
        
        self.navigationItem.rightBarButtonItem = rightButtonItem

    }
    
    
    @objc func rightButtonAction(sender: UIBarButtonItem) {
        let myNC = self.navigationController as! UIScreenShotPickerController
        (myNC.delegate as! UIScreenShotPickerControllerDelegate).screenShotPickerController(myNC, didFinishPickingImage: self.imageView.image!)
    }

    
    init(fetchObject: PHAsset) {
        self.fetchObject = fetchObject
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
