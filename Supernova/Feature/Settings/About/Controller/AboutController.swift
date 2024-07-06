//
//  AboutController.swift
//  Supernova
//
//  Created by Henrique Marques on 27/01/23.
//

import UIKit

class AboutController: UIViewController {

    var aboutScreen: AboutScreen?
    var viewModel: AboutViewModel?
    
    override func loadView() {
        self.aboutScreen = AboutScreen()
        self.view = aboutScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = AboutViewModel(delegate: self)
        self.viewModel?.populateModel()
        self.configNavigationController()
        self.aboutScreen?.aboutTableViewProtocols(delegate: self, dataSouce: self)

    }
    
    func configNavigationController() {
        self.title = "About the App"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
}

extension AboutController: AboutViewModelProtocol {
    
    func success() {
        DispatchQueue.main.async {
            self.aboutScreen?.aboutTableVIew.reloadData()
        }
    }
    
    func failure(error: String) {
        print("Error")
    }
    
    
}

extension AboutController: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return model[section].cell.count
        return viewModel?.modelSection(section: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AboutTableCell.identifier, for: indexPath) as? AboutTableCell else {return UITableViewCell()}
 //       let index = model[indexPath.section].cell[indexPath.row]
        let index = viewModel?.cellCount(section: indexPath.section, indexPath: indexPath)
        switch index {
        case .staticCell(model: let model):
            print(model)
            cell.configCell(with: model)
        case .none:
            return cell
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.countModel ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return model[section].title
        return viewModel?.modelTitles(section: section)

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
        let index = viewModel?.cellCount(section: indexPath.section, indexPath: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch index {
        case .staticCell(model: let model):
            self.openSafariPageWith(url: model.link ?? "Error")
        case .none:
            return 
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
