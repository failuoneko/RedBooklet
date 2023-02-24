//
//  Extensions.swift
//  RedBooklet
//
//  Created by L on 2023/1/12.
//

import UIKit

extension UITextField {
    var unwrappedText: String { text ?? "" }
}

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
    func showTextHUD(_ title: String, _ subtitle: String? = nil) {
        let hub = MBProgressHUD.showAdded(to: view, animated: true)
        hub.mode = .text
        hub.label.text = title
        hub.detailsLabel.text = subtitle
        hub.hide(animated: true, afterDelay: 2)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
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
    
    static func loadView<T>(fromNib name: String, with type: T.Type) -> T{
        if let view = Bundle.main.loadNibNamed(name, owner: nil, options: nil)?.first as? T{
            return view
        }
        fatalError("加載\(type)類型的view失敗")
    }
}
