//
//  WhatsNewController.swift
//  Supernova
//
//  Created by Henrique Marques on 27/01/23.
//

import UIKit

class WhatsNewController: UIViewController {
    
    var whatsNewsScreen: WhatsNewScreen?
    var model = WhatsNewModel().populate()
    
    override func loadView() {
        self.whatsNewsScreen = WhatsNewScreen()
        self.view = whatsNewsScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.whatsNewsScreen?.whatsNewTableView.rowHeight = UITableView.automaticDimension
        self.whatsNewsScreen?.whatsNewTableView.estimatedRowHeight = 150
        self.configNavigationController()
        self.whatsNewsScreen?.whatsNewTableViewProtocols(delegate: self, dataSource: self)
    }
    
    func configNavigationController() {
        self.title = "What's New"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

}

extension WhatsNewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return model.count
    }
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return model[section].title
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = model[indexPath.section].whatsNewCell[indexPath.row]
        
        switch index {
        case .whatsNewCell(model: let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: WhatsNewCell.identifier, for: indexPath) as? WhatsNewCell else {return UITableViewCell()}
            cell.configCell(with: model)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
