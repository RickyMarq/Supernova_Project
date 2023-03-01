//
//  LauchController.swift
//  Supernova
//
//  Created by Henrique Marques on 24/01/23.
//

import UIKit

class LauchController: UIViewController {

    var lauch: UpcomingModel?
    var lauchScreen: LauchScreen?
    
    override func loadView() {
        self.lauchScreen = LauchScreen()
        self.view = lauchScreen
    }
    
    init(lauch: UpcomingModel) {
        self.lauch = lauch
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = lauch?.name
        self.lauchScreen?.delegate(delegate: self)
        self.lauchScreen?.pictureOfTheDayLabel.text = lauch?.name
        self.lauchScreen?.pictureOfTheDayImageView.sd_setImage(with: URL(string: (lauch?.links.patch.small)!))

    }
    

    

}

extension LauchController: LauchScreenProtocol {
    
    func action() {
//        let vc = ImageViewerController(data: lauch!)
//        vc.modalPresentationStyle = .fullScreen
//        self.present(vc, animated: true)
    }
    
    
}
