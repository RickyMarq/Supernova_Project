//
//  CompanyItem.swift
//  Supernova
//
//  Created by Henrique Marques on 17/03/23.
//

import UIKit

class CompanyItem: UIViewController {
    
    var companyScreen: CompanyItemScreen?
    var viewModel: CompanyItemViewModel?
    
    init(viewModel: CompanyItemViewModel) {
        self.viewModel = viewModel
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
        self.companyScreen?.companyLogoImageView.sd_setImage(with: URL(string: viewModel?.companyLogo ?? ""))
        self.companyScreen?.companyNameLabel.text = viewModel?.companyName
        self.companyScreen?.companyDescriptionLabel.text = viewModel?.companyDescription
        self.companyScreen?.totalLaunchesIntLabel.text = "\(viewModel?.totalLaunches ?? 0)"
        self.companyScreen?.FoundingYearLabel.text = "Founding Year: \(viewModel?.foundingYear ?? "Not found")"
        
        self.companyScreen?.failedLaunchesIntLabel.text = "\(viewModel?.failedLaunches ?? 0)"
        
        self.companyScreen?.successLaunchesIntLabel.text = "\(viewModel?.successLaunches ?? 0)"
    }
}

extension CompanyItem: CompanyItemScreenProtocols {
   
    func companyLinkAction() {
        self.openSafariPageWith(url: viewModel?.wikiURL ?? "")
    }

}
