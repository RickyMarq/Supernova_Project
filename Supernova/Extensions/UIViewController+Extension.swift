//
//  UIViewController+Extension.swift
//  Supernova
//
//  Created by Henrique Marques on 10/02/23.
//

import Foundation
import UIKit
import SafariServices

extension UIViewController {
    
    func openSafariPageWith(url: String) {
        let vc = SFSafariViewController(url: URL(string: url)!)
        vc.preferredControlTintColor = .primaryColour
        self.present(vc, animated: true)
    }
    
    func getSoftFeedbackGenerator() {
        let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .soft)
        impactFeedbackgenerator.prepare()
        impactFeedbackgenerator.impactOccurred()
    }
    
}

