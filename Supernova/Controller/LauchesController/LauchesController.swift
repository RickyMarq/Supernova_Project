//
//  LauchesController.swift
//  Supernova
//
//  Created by Henrique Marques on 01/03/23.
//

import UIKit

class LaunchesController: UIViewController {
    
    var index: Int = 0
    var lastLauchesObjc = [ResultedModel]()
    var futureLauchesObjc = [ResultedModel]()
    var masterArray = [ResultedModel]()
    var launchesScreen: LaunchesScreen?
    
    init(index: Int) {
        self.index = index
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.launchesScreen = LaunchesScreen()
        self.view = launchesScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.launchesScreen?.segmentedControl.setSelectedSegmentIndex(UInt(index), animated: true)
        self.configNavigationController()
        self.launchesScreen?.LaunchesCollectionViewProtocols(delegate: self, dataSource: self)
        self.launchesScreen?.delegate(delegate: self)
        
    }
    
    func configNavigationController() {
        self.title = "Launches"
        self.navigationController?.navigationBar.topItem?.backButtonTitle = "Home"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.titleView?.tintColor = .primaryColour
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getLastLaunches(limit: 10)
        self.getFutureLaunches(limit: 15, startsAt: 0)
//        masterArray = futureLauchesObjc
        print(index)

//        DispatchQueue.main.async {
//            self.launchesScreen?.LaunchesCollectionView.reloadData()
//        }
    }
    
    func getFutureLaunches(limit: Int, startsAt: Int) {
        SpaceDevsInternetServices.sharedObjc.getFutureLauches(limit: limit, startsAt: startsAt) { [weak self] result in
            
            switch result {
            case .success(let model):
                guard let strongSelf = self else {return}
                strongSelf.futureLauchesObjc = model ?? []
                print("DEBUG MODE INDEX -> \(strongSelf.index)")
                print("DEBUG MODE ARRAY LAST -> \(strongSelf.lastLauchesObjc.count)")
                print("DEBUG MODE ARRAY FUTURE -> \(strongSelf.futureLauchesObjc.count)")
                
                if strongSelf.index == 0 {
                    strongSelf.masterArray = strongSelf.futureLauchesObjc
                } else if strongSelf.index == 1 {
                    strongSelf.masterArray = strongSelf.lastLauchesObjc
                }
                
//                strongSelf.masterArray = strongSelf.futureLauchesObjc
                
                DispatchQueue.main.async {
                    strongSelf.launchesScreen?.LaunchesCollectionView.reloadData()
                }
                
            case .failure(let error):
                print("DEBUG MODE: ERROR FUTURE")
            }
        }
    }
    
    func getLastLaunches(limit: Int) {
        SpaceDevsInternetServices.sharedObjc.getLastLauches(limit: limit) { [weak self] result in
            
            switch result {
                
            case .success(let model):
                guard let strongSelf = self else {return}
                strongSelf.lastLauchesObjc = model ?? []
                print(strongSelf.lastLauchesObjc)
                print("DEBUG MODE ARRAY LAST -> \(strongSelf.lastLauchesObjc.count)")
                
                if strongSelf.index == 0 {
                    strongSelf.masterArray = strongSelf.futureLauchesObjc
                } else if strongSelf.index == 1 {
                    strongSelf.masterArray = strongSelf.lastLauchesObjc
                }
                
                DispatchQueue.main.async {
                    strongSelf.launchesScreen?.LaunchesCollectionView.reloadData()
                }
                
                
            case .failure(let error):
                print("DEBUG MODE: ERROR PAST")
            }
        }
    }
}

extension LaunchesController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("DEBUG MODE: MASTER ARRAY COUNT -> \(masterArray.count)")
        return masterArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LaunchesCell.identifier, for: indexPath) as? LaunchesCell else {return UICollectionViewCell()}
        let index = masterArray[indexPath.row]
        cell.newsImageView.sd_setImage(with: URL(string: index.image ?? ""))
        cell.newsNameLabel.text = index.name
        cell.backgroundColor = .secondarySystemBackground
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 24, height: 420)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = masterArray[indexPath.row]
        let vc = LaunchesItemController(lauches: index)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension LaunchesController: LaunchesScreenProtocol {
   
    func didChangedValue() {
        self.getSoftFeedbackGenerator()
        switch launchesScreen?.segmentedControl.selectedSegmentIndex {
            
        case 0:
            masterArray = futureLauchesObjc
            DispatchQueue.main.async {
                self.launchesScreen?.LaunchesCollectionView.reloadData()
               self.launchesScreen?.LaunchesCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
            }
        case 1:
            masterArray = lastLauchesObjc
            DispatchQueue.main.async {
                self.launchesScreen?.LaunchesCollectionView.reloadData()
                self.masterArray.isEmpty ? print("N") : self.launchesScreen?.LaunchesCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
            }
        default: break
        }
    }
    
    
}
