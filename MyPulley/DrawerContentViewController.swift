//
//  DrawerContentViewController.swift
//  MyPulley
//
//  Created by Елена Озерова on 13/11/2017.
//  Copyright © 2017 Елена Озерова. All rights reserved.
//

import UIKit
import Pulley

class DrawerContentViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var gripperView: UIView!
    
    @IBOutlet weak var headerSectionHeightConstraint: NSLayoutConstraint!
    
    fileprivate var drawerBottomSaveArea: CGFloat = 0.0 {
        didSet {
            self.loadViewIfNeeded()
            
            tableView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: drawerBottomSaveArea, right: 0.0)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        gripperView.layer.cornerRadius = 2.5
    }
}

extension DrawerContentViewController: PulleyDrawerViewControllerDelegate {
    func collapsedDrawerHeight(bottomSafeArea: CGFloat) -> CGFloat {
        return 17.0 + bottomSafeArea
    }
    
    func partialRevealDrawerHeight(bottomSafeArea: CGFloat) -> CGFloat {
        return 264.0 + drawerBottomSaveArea
    }
    
    func supportedDrawerPositions() -> [PulleyPosition] {
        return PulleyPosition.all
    }
    
    func drawerPositionDidChange(drawer: PulleyViewController, bottomSafeArea: CGFloat) {
        
        drawerBottomSaveArea = bottomSafeArea
        
        if drawer.drawerPosition == .collapsed {
            headerSectionHeightConstraint.constant = 17.0 + drawerBottomSaveArea
        } else {
            headerSectionHeightConstraint.constant = 17.0
        }
        
        tableView.isScrollEnabled = drawer.drawerPosition == .open
    }
}

extension DrawerContentViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 23
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "SampleCell", for: indexPath)
    }
}

extension DrawerContentViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 81.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        print("Did select at row: \(indexPath.row)")
//        if let drawer = self.parent as? PulleyViewController {
//            let primaryContent = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: <#T##String#>)
//        }
    }
}














