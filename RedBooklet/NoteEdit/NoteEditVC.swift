//
//  NoteEditVC.swift
//  RedBooklet
//
//  Created by L on 2023/2/8.
//

import UIKit
import YPImagePicker
import MBProgressHUD
import SKPhotoBrowser
import AVKit

class NoteEditVC: UIViewController {
    
    var photos = [UIImage(named: "1")!, UIImage(named: "2")!, UIImage(named: "3")!]
//    var videoURL: URL = Bundle.main.url(forResource: "testVideo", withExtension: "mp4")!
    var videoURL: URL?
    
    var photosCount: Int { photos.count }
    var isVideo: Bool { videoURL != nil }

    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
        photoCollectionView.dragDelegate = self
        photoCollectionView.dropDelegate = self
        
        photoCollectionView.dragInteractionEnabled = true // 開啟拖放功能
    }

}

extension NoteEditVC: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosCount
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPhotoCellID, for: indexPath) as! PhotoCell
        cell.imageView.image = photos[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionFooter:
            let photoFooter = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kPhotoFooterID, for: indexPath) as! PhotoFooter
            photoFooter.addPhotoButton.addTarget(self, action: #selector(addPhoto), for: .touchUpInside)
            return photoFooter
        default:
            fatalError("collectionView footer error")
        }
    }
}

extension NoteEditVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if isVideo {
            let playerVC = AVPlayerViewController()
            playerVC.player = AVPlayer(url: videoURL!)
            present(playerVC, animated: true) {
                playerVC.player?.play()
            }
        } else {
            // 1. create SKPhoto Array from UIImage
            var images: [SKPhoto] = []
            for photo in photos {
                images.append(SKPhoto.photoWithImage(photo))
            }

            // 選擇的預覽照片
            let browser = SKPhotoBrowser(photos: images, initialPageIndex: indexPath.item)
            browser.delegate = self
            SKPhotoBrowserOptions.displayAction = false // 不顯示分享按鈕
            SKPhotoBrowserOptions.displayDeleteButton = true // 顯示刪除按鈕
            present(browser, animated: true)
        }
    }
}

// MARK: - SKPhotoBrowserDelegate
extension NoteEditVC: SKPhotoBrowserDelegate {
    func removePhoto(_ browser: SKPhotoBrowser, index: Int, reload: @escaping (() -> Void)) {
        photos.remove(at: index)
        photoCollectionView.reloadData()
        reload()
    }
}

extension NoteEditVC {
    @objc private func addPhoto(sender: UIButton) {
        if photosCount < kMaxPhotoCount {
            var config = YPImagePickerConfiguration()
            // MARK: 通用配置
            config.albumName = Bundle.main.appName // 存圖片進App裡"我的相簿"裡的文件夾名稱
            config.screens = [.library] // 依序展示相簿、錄影、拍照頁面
            
            // MARK: Library
            config.library.defaultMultipleSelection = true // 可否多選
            config.library.maxNumberOfItems = kMaxPhotoCount - photosCount // 最多可選幾項
            config.library.minNumberOfItems = 1
            config.library.numberOfItemsInRow = 4
            config.library.spacingBetweenItems = kSpacingBetweenItems // 照片間的間距
            config.library.preSelectItemOnMultipleSelection = true // 是否選擇最新的照片
            config.gallery.hidesRemoveButton = false // 每個照片上方是否有刪除按鈕
            
            let picker = YPImagePicker(configuration: config)
            // MARL: 選完或按取消後的處理
            picker.didFinishPicking { [unowned picker] items, _ in
                
                for item in items {
                    switch item {
                    case let .photo(photo):
                        self.photos.append(photo.image)
                    case .video(_):
                        break
                    }
                }
                
                self.photoCollectionView.reloadData()
                
                picker.dismiss(animated: true, completion: nil)
            }
            present(picker, animated: true, completion: nil)
        } else {
            
            showTextHub("最多只能選擇\(kMaxPhotoCount)張照片")
        }
    }
}

// MARK: - UICollectionViewDragDelegate
extension NoteEditVC: UICollectionViewDragDelegate {
    // 1.開始拖拽
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        
        let photo = photos[indexPath.item]
        let dragItem = UIDragItem(itemProvider: NSItemProvider(object: photo))
        dragItem.localObject = photo
        return [dragItem]
    }
    // 實現itemsForAddingTo可拖拽多個
    // 若要改變cell外觀，需實現dragPreviewParametersForItemAt方法
}

// MARK: - UICollectionViewDropDelegate
extension NoteEditVC: UICollectionViewDropDelegate {
    // 2.拖拽中
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        
        // 為有效拖拽時執行
        if collectionView.hasActiveDrag {
            return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
        
        // 拖曳到外面時中止
        return UICollectionViewDropProposal(operation: .forbidden)
    }
    
    // 3.拖拽後
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        // 放下圖片後更改數據、更新UI
        if coordinator.proposal.operation == .move,
           let item = coordinator.items.first,
           let sourceIndexPath = item.sourceIndexPath,
           let destinationIndexPath = coordinator.destinationIndexPath {
            
            // 批量更新，讓動畫更流暢
            collectionView.performBatchUpdates {
                photos.remove(at: sourceIndexPath.item)
                photos.insert(item.dragItem.localObject as! UIImage, at: destinationIndexPath.item)
                collectionView.moveItem(at: sourceIndexPath, to: destinationIndexPath)
            }
            coordinator.drop(item.dragItem, toItemAt: destinationIndexPath)
        }
        
    }
}
