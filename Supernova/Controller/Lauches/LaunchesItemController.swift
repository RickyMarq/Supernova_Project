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
        self.lauchesScreen?.delegate(delegate: self)
        self.lauchesScreen?.launchNameLabel.text = lauches?.name
        self.lauchesScreen?.idLabel.text = "#\(lauches?.rocket?.id ?? 0)"
        self.lauchesScreen?.rocketDescriptionLabel.text = lauches?.mission?.description
        self.lauchesScreen?.rocketImageView.sd_setImage(with: URL(string: lauches?.image ?? ""))
        
        self.lauchesScreen?.labelRocketNameLabel.text = lauches?.rocket?.configuration.name
        
        
        self.lauchesScreen?.totalLaunchesIntLabel.text = "\(lauches?.orbitalLaunchAttemptCount ?? 0)"
        self.lauchesScreen?.successLaunchesIntLabel.text = "\(lauches?.padLaunchAttemptCount ?? 0)"
        self.lauchesScreen?.failedLaunchesIntLabel.text = "\(lauches?.locationLaunchAttemptCount ?? 0)"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
}

extension LaunchesItemController: LaunchesItemScreenProtocols {
    
    func rocketButtonAction() {
        guard let rocket = lauches?.rocket else {return}
        let vc = RocketItem(rocket: rocket)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
