//
//  Alerts.swift
//  IDNW
//
//  Created by Henrique Marques on 28/07/22.
//

import UIKit

class Alerts: NSObject {
    
    var controller: UIViewController
    
    init(controller: UIViewController) {
        self.controller = controller
    }
        
    func getAlert(title: String?, message: String, buttonMessage: String, completion:(() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: buttonMessage, style: .default)
        alert.addAction(cancel)
        self.controller.present(alert, animated: true)
    }
}
