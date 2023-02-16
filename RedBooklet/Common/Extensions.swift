//
//  Extensions.swift
//  RedBooklet
//
//  Created by L on 2023/1/12.
//

import UIKit

extension UIView {
    @IBInspectable
    var radius: CGFloat {
        get {
            layer.cornerRadius
        }
        
        set {
            layer.cornerRadius = newValue
        }
    }
}

extension UIViewController {
    
    /// 提示框 - 自動隱藏
    func showTextHub(_ title: String, _ subtitle: String? = nil) {
        let hub = MBProgressHUD.showAdded(to: view, animated: true)
        hub.mode = .text
        hub.label.text = title
        hub.detailsLabel.text = subtitle
        hub.hide(animated: true, afterDelay: 2)
    }
}

extension Bundle {
    var appName: String{
        if let appName = localizedInfoDictionary?["CFBundleDisplayName"] as? String {
            return appName
        } else {
            return infoDictionary!["CFBundleDisplayName"] as! String
        }
    }
}
