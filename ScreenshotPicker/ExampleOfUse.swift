//
//  ViewController.swift
//  ScreenshotPicker
//
//  Created by Yevgeniy Vasylenko on 7/5/17.
//  Copyright © 2017 Yevgeniy Vasylenko. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScreenShotPickerControllerDelegate {



    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var button: UIButton!
    var image = UIImage.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    @IBAction func buttonPress(_ sender: Any) {
        let screenShotPicker = UIScreenShotPickerController()
        screenShotPicker.delegate = self
        self.present(screenShotPicker, animated: true, completion: nil)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imgView.image = image
        picker.dismiss(animated: true, completion: nil)
    }
    
    func screenShotPickerController(_ picker: UIScreenShotPickerController, didFinishPickingImage image: UIImage) {
        imgView.image = image
        picker.dismiss(animated: true, completion: nil)
    }
    
    func screenShotPickerControllerDidCancel(_ picker: UIScreenShotPickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}

