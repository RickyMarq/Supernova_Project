//
//  NasaPictureController.swift
//  Supernova
//
//  Created by Henrique Marques on 24/01/23.
//

import UIKit

class NasaPictureController: UIViewController {
    
    var picture: PictureOfTheDay?
    var nasaPictureScreen: NasaPictureScreen?
    
    override func loadView() {
        self.nasaPictureScreen = NasaPictureScreen()
        self.view = nasaPictureScreen
    }
    
    init(picture: PictureOfTheDay) {
        self.picture = picture
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nasaPictureScreen?.pictureOfTheDayLabel.text = picture?.title
        self.nasaPictureScreen?.pictureOfTheDayImageView.sd_setImage(with: URL(string: (picture?.url)!)!)

    }


}
