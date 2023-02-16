//
//  PhotoFooter.swift
//  RedBooklet
//
//  Created by L on 2023/2/12.
//

import UIKit

class PhotoFooter: UICollectionReusableView {
        
    @IBOutlet weak var addPhotoButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addPhotoButton.layer.borderWidth = 1
        addPhotoButton.layer.borderColor = UIColor.quaternaryLabel.cgColor
    }
}
