//
//  CompanyItem.swift
//  Supernova
//
//  Created by Henrique Marques on 17/03/23.
//

import UIKit

class CompanyItem: UIViewController {
    
    var companyScreen: CompanyItemScreen?
    var item: Manufacturer?
    
    init(item: Manufacturer) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func loadView() {
        self.companyScreen = CompanyItemScreen()
        self.view = companyScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.companyScreen?.delegate(delegate: self)
        self.populateView()
    }
    
    func populateView() {
        self.companyScreen?.companyLogoImageView.sd_setImage(with: URL(string: item?.logo_url ?? ""))
        self.companyScreen?.companyNameLabel.text = item?.name
        self.companyScreen?.companyDescriptionLabel.text = item?.description
        self.companyScreen?.totalLaunchesIntLabel.text = "\(item?.total_launch_count ?? 0)"
        self.companyScreen?.FoundingYearLabel.text = "Founding Year: \(item?.founding_year ?? "Not found")"
        
        self.companyScreen?.failedLaunchesIntLabel.text = "\(item?.failed_launches ?? 0)"
        
        self.companyScreen?.successLaunchesIntLabel.text = "\(item?.successful_launches ?? 0)"
    }
}

extension CompanyItem: CompanyItemScreenProtocols {
   
    func companyLinkAction() {
        self.openSafariPageWith(url: item?.wiki_url ?? "")
    }

}
