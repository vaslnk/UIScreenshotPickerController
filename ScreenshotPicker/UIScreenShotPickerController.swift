//
//  UIScreenShotPicker.swift
//  ScreenshotPicker
//
//  Created by Yevgeniy Vasylenko on 7/6/17.
//  Copyright © 2017 Yevgeniy Vasylenko. All rights reserved.
//

import UIKit
import Photos

protocol UIScreenShotPickerControllerDelegate: NSObjectProtocol {
    func screenShotPickerController(_ picker: UIScreenShotPickerController, didFinishPickingImage info: UIImage)
    func screenShotPickerControllerDidCancel(_ picker: UIScreenShotPickerController)
}

class UIScreenShotPickerController: UINavigationController {
    
    weak var myDelegate: UIScreenShotPickerControllerDelegate?
    override var delegate: UINavigationControllerDelegate? {
        didSet { myDelegate = delegate as? UIScreenShotPickerControllerDelegate }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let allScreenShotsVC = AllScreenShotsCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        self.pushViewController(allScreenShotsVC, animated: false)
    }
    
}
