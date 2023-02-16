//
//  TabBarController.swift
//  RedBooklet
//
//  Created by L on 2023/1/10.
//

import UIKit
import YPImagePicker

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self
    }
}

extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController is PostVC {
            
            // TODO: 判斷是否登入
            
            var config = YPImagePickerConfiguration()
            // MARK: 通用配置
            config.isScrollToChangeModesEnabled = false // 取消滑動切換，防止編輯相片時手勢衝突
            config.onlySquareImagesFromCamera = false // 是否只拍攝正方形照片
            config.albumName = Bundle.main.appName // 存圖片進App裡"我的相簿"裡的文件夾名稱
//            config.albumName = "DefaultYPImagePickerAlbumName"
            
            config.startOnScreen = .library // 一打開就展示相簿
            config.screens = [.library, .video, .photo] // 依序展示相簿、錄影、拍照頁面
            config.maxCameraZoomFactor = kMaxCameraZoomFactor // 最大幾倍變焦
            
            // MARK: Library
            config.library.defaultMultipleSelection = true // 可否多選
            config.library.maxNumberOfItems = kMaxPhotoCount // 最多可選幾項
            config.library.minNumberOfItems = 1
            config.library.numberOfItemsInRow = 4
            config.library.spacingBetweenItems = kSpacingBetweenItems // 照片間的間距
            config.library.preSelectItemOnMultipleSelection = false // 是否選擇最新的照片
            config.gallery.hidesRemoveButton = false
            
            let picker = YPImagePicker(configuration: config)
            // MARL: 選完或按取消後的處理
            picker.didFinishPicking { [unowned picker] items, cancelled in
                
                if cancelled {
                    
                }
                
                for item in items {
                    switch item {
                    case let .photo(photo):
                        break
                    case let .video(video):
                        break
                    }
                }
                
                picker.dismiss(animated: true, completion: nil)
            }
            present(picker, animated: true, completion: nil)
            
            return false
        } else {
            return true
        }
    }
}
