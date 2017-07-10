//
//  ThumbnailCell.swift
//  ScreenshotPicker
//
//  Created by Yevgeniy Vasylenko on 7/7/17.
//  Copyright © 2017 Yevgeniy Vasylenko. All rights reserved.
//

import UIKit

class ThumbnailCell: UICollectionViewCell {
    
    var imgView = UIImageView()
    
    var thumbnailImage: UIImage! {
        didSet {
            imgView.image = thumbnailImage
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imgView.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        imgView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        self.addSubview(imgView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

