//
//  ViewController.swift
//  RedBooklet
//
//  Created by L on 2023/1/2.
//

import UIKit
import XLPagerTabStrip

class HomeVC: ButtonBarPagerTabStripViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let followVC = storyboard?.instantiateViewController(identifier: kFollowVCID)
        let nearByVC = storyboard?.instantiateViewController(identifier: kNearByVCID)
        let discoveryVC = storyboard?.instantiateViewController(identifier: kDiscoveryVCID)
    }

}

