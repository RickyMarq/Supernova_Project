//
//  OnboardingController.swift
//  Supernova
//
//  Created by Henrique Marques on 01/02/23.
//

import UIKit
import UserNotifications

class OnboardingController: UIViewController {
    
    var onboardingScreen: OnboardingScreen?
    var index = 0
    var model = OnboardingModel().populateModel()

    override func loadView() {
        self.onboardingScreen = OnboardingScreen()
        self.view = onboardingScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.onboardingScreen?.onboardingCollectionProtocols(delegate: self, dataSource: self)
        self.onboardingScreen?.delegate(delegate: self)


    }
    
    override func viewWillAppear(_ animated: Bool) {
        UserDefaults.standard.synchronize()
        let isOn = UserDefaults.standard.bool(forKey: "PermissionForNotification")
    }
   
    func requestNotificationAuthorization() {
        
        let nc = UNUserNotificationCenter.current()
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        
        nc.requestAuthorization(options: options) { granted, _ in
            
            UNUserNotificationCenter.current().getNotificationSettings { result in
                
                switch result.authorizationStatus {
                    
                case .notDetermined:
                    if granted {
                        print("\(#function) Permission granted: \(granted)")
                        DispatchQueue.main.async {
                            UIApplication.shared.registerForRemoteNotifications()
                        }
                        UserDefaults.standard.set(true, forKey: "PermissionForNotification")
                        UserDefaults.standard.synchronize()
                    } else {
                        print("\(#function) Permission NOT granted: \(granted)")
                        UserDefaults.standard.set(false, forKey: "PermissionForNotification")
                        UserDefaults.standard.synchronize()
                    }
                case .authorized:
                    UserDefaults.standard.set(true, forKey: "PermissionForNotification")
                    UserDefaults.standard.synchronize()
                case .denied:
                    UserDefaults.standard.set(false, forKey: "PermissionForNotification")
                    UserDefaults.standard.synchronize()
                case .ephemeral:
                    print("Ephemeral")
                case .provisional:
                    print("Provisional")
                @unknown default:
                    fatalError("Fatal Error")
                }
            }
            }
        }
}

extension OnboardingController: OnboardingScreenProtocol {
    
    func skipAllButtonAction() {
        let vc = TabBarController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    
    func skipButtonAction() {
        let nextIndex = min((self.onboardingScreen?.homePageControl.currentPage)! + 1, model.count + 1)
        let index = IndexPath(item: nextIndex, section: 0)
        self.onboardingScreen?.homePageControl.currentPage = nextIndex
        print(nextIndex)

        if nextIndex == 4 {
            let vc = TabBarController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        } else if nextIndex == 3 {
            self.requestNotificationAuthorization()
            self.onboardingScreen?.onboardingCollection.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
        } else {
            self.onboardingScreen?.onboardingCollection.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
        }
    }
}

extension OnboardingController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.onboardingScreen?.homePageControl.numberOfPages = model.count
        return model.count
    }
                                      
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCell.identifier, for: indexPath) as? OnboardingCell else {return UICollectionViewCell()}
        let index = model[indexPath.item]
        cell.onBoardingAnimationView.animation = .named(index.wavingAnimation)
        cell.onBoardingAnimation.animation = .named(index.image)
        cell.OnboardingPrimaryLabel.text = index.firstLabel
        cell.OnboardingSecondaryLabel.text = index.secondaryLabel
        cell.onBoardingAnimation.play()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.row == 3 {
            self.index = -3
            self.onboardingScreen?.skipIntroButton.setTitle("Begin", for: .normal)
        } else if indexPath.row == 2 {
            self.index = -2
            self.requestNotificationAuthorization()
            self.onboardingScreen?.skipIntroButton.setTitle("Next", for: .normal)
        } else {
            self.onboardingScreen?.skipIntroButton.setTitle("Next", for: .normal)
        }
            
            
        guard let visible = collectionView.visibleCells.last else {return}
        guard let index = collectionView.indexPath(for: visible)?.row else {return}
        self.onboardingScreen?.homePageControl.currentPage = index
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let visible = collectionView.visibleCells.last else {return}
        guard let index = collectionView.indexPath(for: visible)?.row else {return}
        self.onboardingScreen?.homePageControl.currentPage = index
    }
}
