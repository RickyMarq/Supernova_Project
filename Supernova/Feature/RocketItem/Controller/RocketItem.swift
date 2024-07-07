//
//  RocketItemController.swift
//  Supernova
//
//  Created by Henrique Marques on 15/03/23.
//

import UIKit

class RocketItem: UIViewController {
    
    var alerts: Alerts?
    var rocket: Rocket?
    var rocketScreen: RocketScreen?
    var rocketObjc: RocketModel?
    var viewModel: RocketItemViewModel?
    
    init(viewModel: RocketItemViewModel, rocket: Rocket) {
        self.viewModel = viewModel
        self.rocket = rocket
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        self.rocketScreen = RocketScreen()
        self.view = rocketScreen
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let rocket = rocket else {return}
        self.viewModel = RocketItemViewModel(services: RocketServices(), rocket: rocket)
        self.alerts = Alerts(controller: self)
        self.viewModel?.delegate(delegate: self)
        self.rocketScreen?.delegate(delegate: self)
        self.title = rocket.configuration.name
        guard rocket.configuration.url != nil else {return}
        self.viewModel?.getRocket(url: self.viewModel?.rocketURL ?? "")
    }
    
    func showSkeleton() {
        self.rocketScreen?.rocketNameLabel.showSkeleton()
        self.rocketScreen?.rocketDescriptionLabel.showSkeleton()
    }
    
    func setUpView() {
        self.rocketScreen?.rocketNameLabel.text = self.viewModel?.rocketName
        self.rocketScreen?.rocketDescriptionLabel.text = self.viewModel?.rocketDescription
        self.rocketScreen?.labelCompanyNameLabel.text = self.viewModel?.rocketCompanyName
        self.rocketScreen?.totalLaunchesIntLabel.text = "\(self.viewModel?.totalLaunch ?? 0)"
        self.rocketScreen?.successLaunchesIntLabel.text = "\(self.viewModel?.successfulLaunch ?? 0)"
        self.rocketScreen?.failedLaunchesIntLabel.text = "\(self.viewModel?.failedLaunch ?? 0)"
        
        
        if self.viewModel?.image == "" {
            self.rocketScreen?.rocketImageView.removeFromSuperview()
            self.rocketScreen?.rocketImageView.isHidden = true
        } else {
            self.rocketScreen?.rocketImageView.sd_setImage(with: URL(string: self.viewModel?.image ?? ""))
        }
    }
}

extension RocketItem: RocketItemViewModelProtocol {
    
    func success() {
        self.setUpView()
    }
    
    func failure(error: String) {
        alerts?.getAlert(title: "Error occurred", message: "\(error)", buttonMessage: "Cancel")
    }
}

extension RocketItem: RocketScreenProtocols {
    
    func companyButtonAction() {
        guard let item = self.viewModel?.rocketManufacturer else {return}
        let vc = CompanyItem(viewModel: CompanyItemViewModel(data: item))
        self.present(vc, animated: true)
    }
    
    func wikiButtonAction() {
        print("DEBUG MODE: ACTION")
        self.openSafariPageWith(url: self.viewModel?.wikiURL ?? "")
    }
    
}
