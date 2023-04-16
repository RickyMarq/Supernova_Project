//
//  AboutController.swift
//  Supernova
//
//  Created by Henrique Marques on 27/01/23.
//

import UIKit

class AboutController: UIViewController {

    var aboutScreen: AboutScreen?
    var model = AboutModel().populateModel()
    
    override func loadView() {
        self.aboutScreen = AboutScreen()
        self.view = aboutScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configNavigationController()
        self.aboutScreen?.aboutTableViewProtocols(delegate: self, dataSouce: self)

    }
    
    func configNavigationController() {
        self.title = "About the App"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
}

extension AboutController: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model[section].cell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AboutTableCell.identifier, for: indexPath) as? AboutTableCell else {return UITableViewCell()}
        let index = model[indexPath.section].cell[indexPath.row]
        
        switch index {
        case .staticCell(model: let model):
            cell.configCell(with: model)
        }        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return model[section].title
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: AboutTableHeader.identifier) as? AboutTableHeader
            return header ?? UITableViewHeaderFooterView()

        } else {
            return nil
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = model[indexPath.section].cell[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch index {
        case .staticCell(model: let model):
            self.openSafariPageWith(url: model.link ?? "Error")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 200
        } else {
            return 35
        }
    }
    
}
