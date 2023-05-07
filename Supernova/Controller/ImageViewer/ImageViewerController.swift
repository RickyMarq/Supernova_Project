//
//  ImageViewerController.swift
//  Supernova
//
//  Created by Henrique Marques on 25/01/23.
//

import UIKit

class ImageViewerController: UIViewController {
    
    var imageViewerScreen: ImageViewerScreen?
    var data: PictureOfTheDay?
    var alerts: Alerts?
    
    init(data: PictureOfTheDay) {
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.imageViewerScreen = ImageViewerScreen()
        self.view = imageViewerScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.alerts = Alerts(controller: self)
        self.imageViewerScreen?.delegate(delegate: self)
        self.imageViewerScreen?.scrollViewProtocol(delegate: self)
        self.imageViewerScreen?.pictureOfTheDayImageView.sd_setImage(with: URL(string: data?.url ?? "loading"))
        self.imageViewerScreen?.imageNameLabel.text = data?.title
        self.imageViewerScreen?.imageExplanationLabel.text = data?.explanation
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
    }
}

extension ImageViewerController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageViewerScreen?.pictureOfTheDayImageView
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("Teste")
    }

}

extension ImageViewerController: ImageViewerScreenProtocol {
    
    func saveImageButtonAction() {
        DispatchQueue.main.async {
            let image = self.imageViewerScreen?.pictureOfTheDayImageView.image?.pngData() ?? Data()
            let compressedImage = UIImage(data: image)
            UIImageWriteToSavedPhotosAlbum(compressedImage ?? UIImage(), nil, nil, nil)
            self.alerts?.getAlert(title: "Saved", message: "The Picture Of The day was saved in your Photos", buttonMessage: "Ok")
        }
    }
    
   
    func dissmissButtonAction() {
        self.dismiss(animated: true)
//        self.navigationController?.popViewController(animated: true)
    }
    
}
