//
//  CrewController.swift
//  Supernova
//
//  Created by Henrique Marques on 26/01/23.
//

import UIKit

class SectionController: UIViewController {
    
    var sectionScreen: SectionScreen?
    var dragons = [DragonsModel]()
    var crew = [CrewModel]()
    var rockets = [DragonsModel]()
    var spaceSations = [Resulted]()
    
    override func loadView() {
        self.sectionScreen = SectionScreen()
        self.view = sectionScreen
    }
    
    override func viewDidLoad() {
        self.sectionScreen?.sectionTableViewProtocols(delegate: self, dataSource: self)
        self.setUpNavigationController()
        self.getDragons()
        self.getCrew()
        self.getAllRockts()
        self.getAllSpaceStations()
    }
    
    func setUpNavigationController() {
        self.title = "Explore"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func getDragons() {
        SpaceExInternetServices.sharedObjc.getAllDragons { result in
            switch result {
            case .success(let model):
                self.dragons = model ?? []
                print("DEU CERTO")
                
                DispatchQueue.main.async {
                    self.sectionScreen?.sectionTableView.reloadData()
                }
                
            case .failure(let _):
                print("A")
            }
        }
    }
    
    func getCrew() {
        SpaceExInternetServices.sharedObjc.getAllCrew { result in
            switch result {
            case .success(let model):
                self.crew = model ?? []
//                print(model)
                
                DispatchQueue.main.async {
                    self.sectionScreen?.sectionTableView.reloadData()
                }
                
            case .failure(let _):
                print("Error")
            }
        }
    }
    
    func getAllRockts() {
        SpaceExInternetServices.sharedObjc.getAllRockets { result in
            switch result {
            case .success(let model):
                   
                self.rockets = model ?? []
                print(model)
                
                DispatchQueue.main.async {
                    self.sectionScreen?.sectionTableView.reloadData()
                }
                
            case .failure(let _):
                print("Err")
            }
        }
    }
    
    func getAllSpaceStations() {
        SpaceDevsInternetServices.sharedObjc.getAllSpaceSations { result in
            switch result {
            case .success(let model):
                self.spaceSations = model ?? []
                
                DispatchQueue.main.async {
                    self.sectionScreen?.sectionTableView.reloadData()
                }
                
            case .failure(let _):
                print("Error")
            }
        }
    }

}

extension SectionController: UITableViewDelegate, UITableViewDataSource {
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SectionTableCell.identifier, for: indexPath) as? SectionTableCell else {return UITableViewCell()}
 //       cell.backgroundColor = .red
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Dragons"
        } else if section == 1  {
            return "Rockets"
        } else if section == 2 {
            return "Space Stations"
        } else if section == 3 {
            return "Agencies"
        } else if section == 4 {
            return "Crew"
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.text =  header.textLabel?.text?.localizedCapitalized
        header.textLabel?.textColor = .label
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? SectionTableCell else {return}
        tableViewCell.sectionCollectionViewProtocols(delegate: self, dataSouce: self)
        tableViewCell.sectionCollectionView.tag = indexPath.section
        tableViewCell.sectionCollectionView.reloadData()
//        tableViewCell.collectionViewOffset = storedOffsets[tableViewCell.homeTableCellCollectionView.tag] ?? -10
    }
    

}

extension SectionController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 {
            return dragons.count
        } else if collectionView.tag == 1 {
            return rockets.count
        } else if collectionView.tag == 2 {
            return spaceSations.count
        } else if collectionView.tag == 3 {
            return 1
        } else if collectionView.tag == 4 {
            return crew.count
        } else {
            return 12
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExploreCollectionCell.identifier, for: indexPath) as? ExploreCollectionCell else {return UICollectionViewCell()}
        
        if collectionView.tag == 0 {
            let index = dragons[indexPath.item]
            cell.itemLabel.text = index.name
            cell.itemImageView.sd_setImage(with: URL(string: index.flickrImages[1] ?? ""))
            
        } else if collectionView.tag == 4 {
            let index = crew[indexPath.item]
            cell.itemLabel.text = index.name
            cell.itemImageView.sd_setImage(with: URL(string: index.image ?? ""))
        } else if collectionView.tag == 1 {
            let index = rockets[indexPath.item]
            cell.itemLabel.text = index.name
            cell.itemImageView.sd_setImage(with: URL(string: index.flickrImages[0] ?? ""))
        } else if collectionView.tag == 2 {
            let ind = spaceSations[indexPath.item]
            cell.itemLabel.text = ind.name
            cell.itemImageView.sd_setImage(with: URL(string: ind.imageURL ?? ""))
        }
        
        cell.backgroundColor = .secondarySystemBackground
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView.tag == 0 {
            let index = dragons[indexPath.item]
            print(index.name)
            
        } else if collectionView.tag == 4 {
            let index = crew[indexPath.item]
            print(index.name)

        } else if collectionView.tag == 1 {
            let index = rockets[indexPath.item]
            print(index.name)

        } else if collectionView.tag == 2 {
            let index = spaceSations[indexPath.item]
            print(index.name)
        }
        
    }
}
