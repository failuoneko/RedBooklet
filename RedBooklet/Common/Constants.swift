//
//  Constants.swift
//  RedBooklet
//
//  Created by L on 2023/1/5.
//

import UIKit

// MARK: StoryBoardID
let kFollowVCID = "FollowVCID"
let kNearByVCID = "NearByVCID"
let kDiscoveryVCID = "DiscoveryVCID"
let kWaterfallVCID = "WaterfallVCID"
let kNoteEditVC = "NoteEditVC"
let kChannelTableVCID = "ChannelTableVCID"

// MARK: CellID
let kWaterfallCellID = "WaterfallCellID"
let kPhotoCellID = "PhotoCellID"
let kPhotoFooterID = "PhotoFooterID"
let kSubChannelCellID = "SubChannelCellID"

// MARK: - color
let mainColor = UIColor(named: "main")!
let blueColor = UIColor(named: "blue")!

// MARK: - 業務邏輯
// 瀑布流
let kWaterfallPadding: CGFloat = 4

let kChannels = ["推薦", "旅行", "娛樂", "才藝", "美妝", "白富美", "美食", "寵物"]

// YPImagePicker
let kMaxCameraZoomFactor: CGFloat = 5
let kMaxPhotoCount = 9
let kSpacingBetweenItems: CGFloat = 2

let kMaxNoteTitleCount = 20
let kMaxNoteTextCount = 5

// 話題
let kAllSubChannels = [
    ["穿神馬是神馬", "就快瘦到50斤啦", "花5個小時修的靚圖", "網紅店入坑記"],
    ["魔都名媛會會長", "爬行西藏", "無邊泳池只要9塊9"],
    ["小鮮肉的魔幻劇", "國產動畫雄起"],
    ["練舞20年", "還在玩小提琴嗎,我已經尤克里里了哦", "巴西柔術", "聽說拳擊能減肥", "乖乖交智商稅吧"],
    ["粉底沒有最厚,只有更厚", "最近很火的法屬xx島的面霜"],
    ["我是白富美你是嗎", "康一康瞧一瞧啦"],
    ["裝x西餐廳", "網紅店打卡"],
    ["我的貓兒子", "我的貓女兒", "我的兔兔"]
]
