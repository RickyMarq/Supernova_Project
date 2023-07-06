//
//  RocketSupernovaController.swift
//  Supernova
//
//  Created by Henrique Marques on 22/06/23.
//

import UIKit

class RocketSupernovaController: UIViewController {
    
    var rocketControllerData: SupernovaRocketModel
    var rocketSupernovaScreen: RocketSupernovaScreen?
    
    override func loadView() {
        self.rocketSupernovaScreen = RocketSupernovaScreen()
        self.view = rocketSupernovaScreen
    }
    
    init(rocketControllerData: SupernovaRocketModel) {
        self.rocketControllerData = rocketControllerData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setUpViewData()
    }
    
    private func setUpViewData() {
        self.rocketSupernovaScreen?.rocketImageView.sd_setImage(with: URL(string: rocketControllerData.image ?? ""))
        self.rocketSupernovaScreen?.rocketNameLabel.text = rocketControllerData.name
        self.rocketSupernovaScreen?.rocketManufactureLabel.text = "Manufacture: \(rocketControllerData.company ?? "")"
        
        self.rocketSupernovaScreen?.rocketDiameterLabel.text = "Diameter: \(rocketControllerData.diameter ?? "")"
        self.rocketSupernovaScreen?.rocketMassLabel.text = "Mass: \(rocketControllerData.mass ?? "")"
    }
    

}
