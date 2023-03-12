//
//  LauchesController.swift
//  Supernova
//
//  Created by Henrique Marques on 12/02/23.
//

import UIKit

class LaunchesItemController: UIViewController {
    
    var lauches: ResultedModel?
    var lauchesScreen: LaunchesItemScreen?
    
    override func loadView() {
        self.lauchesScreen = LaunchesItemScreen()
        self.view = lauchesScreen
    }
    
    init(lauches: ResultedModel) {
        self.lauches = lauches
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = lauches?.name
        self.lauchesScreen?.launchNameLabel.text = lauches?.name
    }
}
