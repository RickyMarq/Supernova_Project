//
//  RocketItemController.swift
//  Supernova
//
//  Created by Henrique Marques on 15/03/23.
//

import UIKit

class RocketItem: UIViewController {
    
    var rocket: Rocket?
    var rocketScreen: RocketScreen?
    var rocketObjc: RocketModel?
    
    init(rocket: Rocket) {
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
 //       self.showSkeleton()
        self.rocketScreen?.delegate(delegate: self)
        self.title = rocket?.configuration.name
        guard let url = rocket?.configuration.url else {return}
        self.getRocket(url: url)
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
    }
    
    func showSkeleton() {
        self.rocketScreen?.rocketNameLabel.showSkeleton()
        self.rocketScreen?.rocketDescriptionLabel.showSkeleton()
    }
    
    func getRocket(url: String) {
        SpaceDevsInternetServices.sharedObjc.getRocket(url: url) { data in
            
            switch data {
                
            case .success(let model):
                self.rocketObjc = model
                
                DispatchQueue.main.async {
//                    self.rocketScreen?.rocketNameLabel.hideSkeleton()
                    self.rocketScreen?.rocketNameLabel.text = self.rocketObjc?.name
 //                   self.rocketScreen?.rocketDescriptionLabel.hideSkeleton()
                    self.rocketScreen?.rocketDescriptionLabel.text = self.rocketObjc?.description
                    self.rocketScreen?.labelCompanyNameLabel.text = self.rocketObjc?.manufacturer.name
                    self.rocketScreen?.totalLaunchesIntLabel.text = "\(self.rocketObjc?.total_launch_count ?? 0)"
                    self.rocketScreen?.successLaunchesIntLabel.text = "\(self.rocketObjc?.successful_launches ?? 0)"
                    self.rocketScreen?.failedLaunchesIntLabel.text = "\(self.rocketObjc?.failed_launches ?? 0)"
                    
                    
                    guard let imageToPresent = self.rocketObjc?.manufacturer.imageURL else {
                        self.rocketScreen?.rocketImageView.isHidden = true

                        return}
                    self.rocketScreen?.rocketImageView.sd_setImage(with: URL(string: imageToPresent))
                        
                    
                            
                            
//                    self.rocketScreen?.rocketImageView.sd_setImage(with: URL(string: self.rocketObjc?.manufacturer.imageURL ?? ""))
//
                    
             
                }
                
                
            case .failure(_):
                print("Failure")
            }
        }
        
    }
}

extension RocketItem: RocketScreenProtocols {
    
    func companyButtonAction() {
        guard let item = self.rocketObjc?.manufacturer else {return}
        let vc = CompanyItem(item: item)
        self.present(vc, animated: true)
    }
    
    func wikiButtonAction() {
        print("DEBUG MODE: ACTION")
        self.openSafariPageWith(url: self.rocketObjc?.wiki_url ?? "")
    }
    
}
