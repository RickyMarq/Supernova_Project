//
//  HomeExtension.swift
//  Supernova
//
//  Created by Henrique Marques on 07/07/24.
//

import Foundation
import UIKit

extension HomeController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let statusBarManager = view.window?.windowScene?.statusBarManager {
            let statusBarHeight = statusBarManager.statusBarFrame.height
            
            if scrollView.contentOffset.y > -scrollView.contentInset.top + 300 {
                UIView.animate(withDuration: 0.3) {
                    if #available(iOS 13.0, *) {
                        let newStatusBarView = UIView()
                        newStatusBarView.backgroundColor = UIColor.secondarySystemBackground
                        self.view.addSubview(newStatusBarView)
                        
                        newStatusBarView.translatesAutoresizingMaskIntoConstraints = false
                        newStatusBarView.heightAnchor.constraint(equalToConstant: statusBarHeight).isActive = true
                        newStatusBarView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1.0).isActive = true
                        newStatusBarView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
                        newStatusBarView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
                        self.statusbarView?.removeFromSuperview()
                        self.statusbarView = newStatusBarView
                        
                    } else {
                        let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
                        statusBar?.backgroundColor = UIColor.black
                    }
                }
            } else {
                UIView.animate(withDuration: 0.3) {
                    if #available(iOS 13.0, *) {
                        let newStatusBarView = UIView()
                        newStatusBarView.isOpaque = false
                        newStatusBarView.backgroundColor = .clear
                        self.view.addSubview(newStatusBarView)
                        
                        newStatusBarView.translatesAutoresizingMaskIntoConstraints = false
                        newStatusBarView.heightAnchor.constraint(equalToConstant: statusBarHeight).isActive = true
                        newStatusBarView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1.0).isActive = true
                        newStatusBarView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
                        newStatusBarView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
                        
                        self.statusbarView?.removeFromSuperview()
                        self.statusbarView = newStatusBarView
                    } else {
                        let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
                        statusBar?.backgroundColor = UIColor.clear
                    }
                }
            }
        }
    }
}

extension HomeController {
    
    func getCompositionalLayout() {
        let layout = UICollectionViewCompositionalLayout { (sectionNumber, env) in
            
            switch sectionNumber {
            case 0:
                return LayoutType.ImageViewer.getLayout()
            case 1:
                return LayoutType.largeButtonsLayout.getLayout()
            case 2:
                return LayoutType.NextLaunchSection.getLayout()
            case 3:
                return LayoutType.future.getLayout()
            case 4:
                return LayoutType.adView.getLayout()
            case 5:
                return LayoutType.LastLauchesLayout.getLayout()
            case 6:
                return LayoutType.tableLayout.getLayout()
            case 7:
                return LayoutType.tableLayout.getLayout()
            case 8:
                return LayoutType.pictureOfTheDay.getLayout()
            default:
                return LayoutType.tableLayout.getLayout()
            }
        }
        self.homeScreen?.homeCollectionView.setCollectionViewLayout(layout, animated: true)
    }
}
