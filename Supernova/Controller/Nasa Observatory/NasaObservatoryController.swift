//
//  NasaObservatoryController.swift
//  Supernova
//
//  Created by Henrique Marques on 04/03/23.
//

import UIKit
import SDWebImage
import AlamofireImage


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
//        self.nasaObservatoryScreen?.layoutDelegate(delegate: self)
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
    
    func sizeOfImageAt(url: URL) -> CGSize {
        guard let source = CGImageSourceCreateWithURL(url as CFURL, nil) else {
            return .zero
        }
        
        let propertiesOptions = [kCGImageSourceShouldCache: false] as CFDictionary
        guard let properties = CGImageSourceCopyPropertiesAtIndex(source, 0, propertiesOptions) as? [CFString: Any] else {
            return .zero
        }
        
        if let width = properties[kCGImagePropertyPixelWidth] as? CGFloat,
           let height = properties[kCGImagePropertyPixelHeight] as? CGFloat {
            return CGSize(width: width, height: height)
        } else {
            return .zero
        }
    }
    
    func sizeOfImageAtSD(url: URL, completion: @escaping (CGSize?) -> Void) {
        // Check if the image is already cached
        if let cachedImage = SDImageCache.shared.imageFromCache(forKey: url.absoluteString) {
            // If the image is cached, return its size
            completion(cachedImage.size)
            return
        }

        // If the image is not cached, download it and get its size
        SDWebImageManager.shared.loadImage(with: url, options: [], progress: nil) { (image, _, _, _, _, _) in
            if let image = image {
                // If the image was downloaded successfully, return its size
                SDImageCache.shared.store(image, forKey: url.absoluteString)
                completion(image.size)
            } else {
                // If the image could not be downloaded, return nil
                completion(nil)
            }
        }
    }
    
    func sizeOfImageAtWithCompletion(url: URL, completion: @escaping (CGSize) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            guard let source = CGImageSourceCreateWithURL(url as CFURL, nil) else {
                completion(.zero)
                return
            }
            
            let propertiesOptions = [kCGImageSourceShouldCache: false] as CFDictionary
            guard let properties = CGImageSourceCopyPropertiesAtIndex(source, 0, propertiesOptions) as? [CFString: Any] else {
                completion(.zero)
                return
            }
            
            if let width = properties[kCGImagePropertyPixelWidth] as? CGFloat,
               let height = properties[kCGImagePropertyPixelHeight] as? CGFloat {
                let size = CGSize(width: width, height: height)
                completion(size)
            } else {
                completion(.zero)
            }
        }
    }
    

    
    
//    func getImageSize(from urlString: String, completion: @escaping (CGSize?, Error?) -> Void) {
//        guard let url = URL(string: urlString) else {
//            completion(nil, NSError(domain: "com.example.app", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL string"]))
//            return
//        }
//        let request = URLRequest(url: url)
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            if let error = error {
//                completion(nil, error)
//                return
//            }
//            guard let data = data, let image = UIImage(data: data) else {
//                completion(nil, NSError(domain: "com.example.app", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unable to create image from data"]))
//                return
//            }
//            completion(image.size, nil)
//        }
//        task.resume()
//    }


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
    
    func getImageSizeAF(from url: URL, completion: @escaping (CGSize?) -> Void) {
        let imageDownloader = ImageDownloader.default
        let urlRequest = URLRequest(url: url)

        imageDownloader.download(urlRequest, completion: { response in
            switch response.result {
            case .success(let image):
                let imageSize = image.size
                completion(imageSize)
            case .failure(let error):
                print("Error downloading image: \(error.localizedDescription)")
                completion(nil)
            }
        })
    }

}

extension NasaObservatoryController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
//    func cellSize(indexPath: IndexPath) -> CGSize {
//        let index = nasaObservatory[indexPath.row]
//        let sizeOfImage = sizeOfImageAt(url: URL(string: index.url ?? "")!)
//
//        guard let url = URL(string: index.url ?? "") else {return CGSize(width: 0, height: 0)}
//
//        self.sizeOfImageAtSD(url: url) { result in
//            self.width = result?.width ?? 0
//            self.height = result?.height ?? 0
//        }
//
//
//        let cellWidth = self.nasaObservatoryScreen!.layoutPintrest.width
//        let size = CGSize(width: Int(cellWidth), height: Int(CGFloat(height ?? 0)/(width ?? 0) * cellWidth))
//        return size
//    }
    
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
        cell.nasaImageNameLabel.text = index.title
        cell.nasaObservatoryImageView.sd_setImage(with: URL(string: index.url ?? "")!)


//        guard let imageUrl = index.url else {return UICollectionViewCell()}
        
        
//        SDWebImageManager.shared.loadImage(with: URL(string: index.url ?? ""), options: [], progress: nil) { (image, _, _, _, _, _) in
//            let aspectRatio = (image?.size.height)! / (image?.size.width)! ?? 1
//            let cellWidth = collectionView.frame.width / 2 - 8
//            let cellHeight = cellWidth * aspectRatio
//            // Set the size of the cell here
//        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let index = nasaObservatory[indexPath.row]
        let sizeOfImage = sizeOfImageAt(url: URL(string: index.url ?? "")!)
        let spacing: CGFloat = 10 // desired spacing between cells
        let numberOfColumns: CGFloat = 2 // number of columns in the collection view
        let totalSpacing = spacing * (numberOfColumns - 1)
        let availableWidth = collectionView.bounds.width - totalSpacing
        let width = availableWidth / numberOfColumns
        let imageHeight = sizeOfImage.height// height of image (e.g., obtained from server)
        let cellHeight = max(0, imageHeight * (width / sizeOfImage.width)) // calculate cell height based on aspect ratio, ensuring it is not negative
        return CGSize(width: width, height: cellHeight)
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

            let saveImage = UIAction(title: "Save Image", image: UIImage(systemName: "camera.aperture"), identifier: nil, discoverabilityTitle: nil) { _ in
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

//extension NasaObservatoryController: PinterestLayoutDelegate {
//
//    func cellSize(indexPath: IndexPath) -> CGSize {
////        return CGSize(width: 100, height: 200)
//
//        let randomImageH = Int.random(in: 300...2000)
//        let randomImageW = Int.random(in: 300...2000)
//
//        let index = nasaObservatory[indexPath.row]
//
//        var SizeForImage: CGSize = CGSize(width: 0, height: 0)
//
//  //      let sizeOfImage = sizeOfImageAt(url: URL(string: index.url ?? "")!)
//
//
////        let sizeOfIt = try getImageSize(from: index.url ?? "")
////
////        getImageSize(from: "https://example.com/image.png") { (size, error) in
////            if let size = size {
////                print("Image size: \(size)")
////            } else if let error = error {
////                print("Error getting image size: \(error)")
////            }
////        }
//
////        imageDownloader.download(urlRequest, completion: { response in
////            if let error = response.error {
////                print("Error downloading image: \(error.localizedDescription)")
////                completion(nil)
////                return
////            }
////
////            if let image = response.result.value {
////                let imageSize = image.size
////                completion(imageSize)
////            } else {
////                print("Error getting image size")
////                completion(nil)
////            }
////        })
//
////    }
//
////        getImageSizeAF(from: URL(string: index.url ?? "")!) { size in
////            if let size = size {
////                print("Image size: \(size.width) x \(size.height)")
////                SizeForImage = size
////            } else {
////                print("Failed to get image size")
////            }
////        }
//
//        self.sizeOfImageAtSD(url: URL(string: index.url ?? "")!) { result in
//            SizeForImage = result ?? CGSize(width: 0, height: 0)
//        }
//
////        let size: CGSize
////        if SizeForImage.width != 0 {
////            let cellWidth = self.nasaObservatoryScreen!.layoutPintrest.width
////            let height = CGFloat(SizeForImage.height) / CGFloat(SizeForImage.width) * cellWidth
////            size = CGSize(width: cellWidth, height: height)
////        } else {
////            size = CGSize.zero
////        }
////
// //       guard let width = image.thumbnail?.width, let height = image.thumbnail?.height else { return .zero }
//
//
//        DispatchQueue.global(qos: .background).async {
//            guard let sizeImage = self.sizeOfImageAt(url: URL(string: index.url ?? "")!) else {return}
//
//            DispatchQueue.main.async {
//                self.height = sizeImage.height
//                self.width = sizeImage.width
//                let cellWidth = self.nasaObservatoryScreen!.layoutPintrest.width
//                let size = CGSize(width: Int(cellWidth), height: Int(CGFloat(sizeImage.height ?? 0)/(sizeImage.width ?? 0) * cellWidth))
//                return size
//            }
//        }
//
//
//    }
//
//}
