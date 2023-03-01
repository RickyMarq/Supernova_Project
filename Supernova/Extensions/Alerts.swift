//
//  Alerts.swift
//  IDNW
//
//  Created by Henrique Marques on 28/07/22.
//

import UIKit

class Alerts: NSObject {
    
    // 1 controller / init
    
    var controller: UIViewController
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    // 2
    
    func getAlert(title: String?, message: String, buttonMessage: String, completion:(() -> Void)? = nil) {
        // 3 alertcontroller
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        // 4 cancel
        let cancel = UIAlertAction(title: buttonMessage, style: .default)
        alert.addAction(cancel)
        self.controller.present(alert, animated: true)
    }
    

}
