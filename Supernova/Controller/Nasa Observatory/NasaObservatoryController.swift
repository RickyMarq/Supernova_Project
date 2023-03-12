//
//  NasaObservatoryController.swift
//  Supernova
//
//  Created by Henrique Marques on 04/03/23.
//

import UIKit
import SDWebImage

class NasaObservatoryController: UIViewController {
 
    var nasaObservatoryScreen: NasaObservatoryScreen?
    var nasaObservatory = [PictureOfTheDay]()
    var width: CGFloat = 0
    var height: CGFloat = 0

    
    override func loadView() {
        self.nasaObservatoryScreen = NasaObservatoryScreen()
        self.view = nasaObservatoryScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.nasaObservatoryScreen?.nasaObservatoryCVProtocols(delegate: self, dataSource: self)
        self.nasaObservatoryScreen?.layoutDelegate(delegate: self)
        self.getLastPicturesOfTheDays(limit: 10)
    }
    
    func configNavigationController() {
        self.title = "Nasa Observatory"
        self.navigationController?.navigationBar.topItem?.backButtonTitle = "Home"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.titleView?.tintColor = .primaryColour
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.configNavigationController()
    }
    
    func saveImage(imageToDownload: String) {
        DispatchQueue.main.async {
            let img = UIImageView()
            img.sd_setImage(with: URL(string: imageToDownload))
            UIImageWriteToSavedPhotosAlbum(img.image!, nil, nil, nil)
        }
    }
    
    func sizeOfImageAt(url: URL) -> CGSize? {
        // with CGImageSource we avoid loading the whole image into memory
        
        guard let source = CGImageSourceCreateWithURL(url as CFURL, nil) else {
            return nil
        }
        
        let propertiesOptions = [kCGImageSourceShouldCache: false] as CFDictionary
        guard let properties = CGImageSourceCopyPropertiesAtIndex(source, 0, propertiesOptions) as? [CFString: Any] else {
            return nil
        }
        
        if let width = properties[kCGImagePropertyPixelWidth] as? CGFloat,
           let height = properties[kCGImagePropertyPixelHeight] as? CGFloat {
            return CGSize(width: width, height: height)
        } else {
            return nil
        }
    }
    
    func getLastPicturesOfTheDays(limit: Int) {
        NasaInternetService.sharedObjc.getLastPicturesOfTheDays(images: limit) { [weak self] pictures in
            
            switch pictures {
                
            case .success(let model):
                guard let strongSelf = self else {return}
                strongSelf.nasaObservatory.append(contentsOf: model ?? [])
                
                DispatchQueue.main.async {
                    strongSelf.nasaObservatoryScreen?.nasaObservatoryCollectionView.reloadData()
                }
                
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    

}

extension NasaObservatoryController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("DEBUG MODE: Nasa Observatory count -> \(nasaObservatory.count)")
        return nasaObservatory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NasaObservatoryCell.identifier, for: indexPath) as? NasaObservatoryCell else {return UICollectionViewCell()}
        let index = nasaObservatory[indexPath.row]
        cell.backgroundColor = .systemBackground
        cell.nasaObservatoryImageView.sd_setImage(with: URL(string: index.url ?? ""))
        
//        print("DEBUG MODE: AAA -> HEIGHT \(cell.nasaObservatoryImageView.image?.size)")
        
        
        if let image = cell.nasaObservatoryImageView.image {
            let size = image.size
               print("image size is \(size)")
        } else {
            print("There is no image here..")
        }

        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.present(ImageViewerController(data: nasaObservatory[indexPath.item]), animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
//        let index = collectionView.indexPathForItem(at: point)
        let index = nasaObservatory[indexPath.item]
        
        
        
        return self.configureContextMenu(index: indexPath.row, indexObjc: index)
    }
    
    func configureContextMenu(index: Int, indexObjc: PictureOfTheDay) -> UIContextMenuConfiguration {
        let contextMenu = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { (action) -> UIMenu? in
            
            let saveImage = UIAction(title: "Save Image", image: UIImage(systemName: "camera.aperture"), identifier: nil, discoverabilityTitle: nil, attributes: .Element(), state: .on) { _ in
                self.saveImage(imageToDownload: indexObjc.url ?? "")
            }
            
            return UIMenu(title: "Options", image: nil, identifier: nil, options: UIMenu.Options.displayInline, children: [saveImage])
        }
        
        return contextMenu
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? NasaObservatoryCell else {return}
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn) {
            cell.transform = .init(scaleX: 0.95, y: 0.95)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? NasaObservatoryCell else {return}
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn) {
            cell.transform = .identity
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let height = scrollView.frame.size.height
        let contentYOffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYOffset
        
        if distanceFromBottom - 100 <= height {
            self.getLastPicturesOfTheDays(limit: 10)
        }
    }
    
    
}

extension NasaObservatoryController: PinterestLayoutDelegate {
    
    func cellSize(indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 100, height: 200)
        
        let randomImageH = Int.random(in: 300...2000)
        let randomImageW = Int.random(in: 300...2000)
        
        let index = nasaObservatory[indexPath.row]
    
        let sizeOfImage = sizeOfImageAt(url: URL(string: index.url ?? "")!)
        
        //        guard let width = image.thumbnail?.width, let height = image.thumbnail?.height else { return .zero }
        let cellWidth = self.nasaObservatoryScreen!.layoutPintrest.width

        let size = CGSize(width: Int(cellWidth), height: Int(CGFloat(((sizeOfImage?.height ?? 10)/(sizeOfImage?.width ?? 10))) * cellWidth))
        return size
    }
    
}
