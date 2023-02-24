//
//  TextViewInputAccessoryView.swift
//  RedBooklet
//
//  Created by L on 2023/2/21.
//

import UIKit

class TextViewInputAccessoryView: UIView {

    @IBOutlet weak var textCountStackView: UIStackView!
    @IBOutlet weak var textCountLabel: UILabel!
    @IBOutlet weak var maxTextCountLabel: UILabel!
    @IBOutlet weak var downButton: UIButton!

    var currentTextCount = 0 {
        didSet {
            if currentTextCount <= kMaxNoteTextCount {
                downButton.isHidden = false
                textCountStackView.isHidden = true
            } else {
                downButton.isHidden = true
                textCountStackView.isHidden = false
                textCountLabel.text = "\(currentTextCount)"
            }
        }
    }
    
}
