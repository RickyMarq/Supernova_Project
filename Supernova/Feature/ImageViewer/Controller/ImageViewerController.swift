//
//  ImageViewerController.swift
//  Supernova
//
//  Created by Henrique Marques on 25/01/23.
//

import UIKit
import SwiftUI

class ImageViewerController: UIViewController {
    
    var imageViewerScreen: ImageViewerScreen?
    var imageViewerViewModel: ImageViewerViewModel?
    var alerts: Alerts?
    
    init(imageViewerViewModel: ImageViewerViewModel) {
        self.imageViewerViewModel = imageViewerViewModel
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
        self.setUpView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func setUpView() {
        self.imageViewerScreen?.pictureOfTheDayImageView.sd_setImage(with: URL(string: imageViewerViewModel?.getPictureOfTheDay ?? "loading"))
        self.imageViewerScreen?.imageNameLabel.text = imageViewerViewModel?.imageName
        self.imageViewerScreen?.imageExplanationLabel.text = imageViewerViewModel?.imageExplanation
    }
}

extension ImageViewerController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageViewerScreen?.pictureOfTheDayImageView
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
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
        self.navigationController?.popViewController(animated: true)
    }
    
}

struct ImageViewerRepresentable: UIViewControllerRepresentable {
    var imageViewerController: ImageViewerController

    func makeUIViewController(context: Context) -> ImageViewerController {
        return imageViewerController
    }

    func updateUIViewController(_ uiViewController: ImageViewerController, context: Context) {
    }
}
