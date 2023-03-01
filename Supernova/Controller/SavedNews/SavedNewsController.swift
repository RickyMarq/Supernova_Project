//
//  SavedNewsController.swift
//  Supernova
//
//  Created by Henrique Marques on 02/02/23.
//

import UIKit

class SavedNewsController: UIViewController {
    
    var savedNewsScreen: SavedNewsScreen?
    
    override func loadView() {
        self.savedNewsScreen = SavedNewsScreen()
        self.view = savedNewsScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configNavigationController()
    }
    
    func configNavigationController() {
        self.title = "Saved News"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    

}
