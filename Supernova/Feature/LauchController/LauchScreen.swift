////
////  LauchScreen.swift
////  Supernova
////
////  Created by Henrique Marques on 24/01/23.
////
//
//import UIKit
//
//protocol LauchScreenProtocol: AnyObject {
//    func action()
//}
//
//class LauchScreen: UIView {
//    
//    weak var delegate: LauchScreenProtocol?
//    
//    func delegate(delegate: LauchScreenProtocol) {
//        self.delegate = delegate
//    }
//    
//    lazy var pictureOfTheDayImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.contentMode = .scaleAspectFill
//        return imageView
//    }()
//    
//    lazy var pictureButton: UIButton = {
//        let button = UIButton()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.backgroundColor = .clear
//        button.addTarget(self, action: #selector(tappedpictureButton), for: .touchUpInside)
//        return button
//    }()
//    
//    @objc func tappedpictureButton() {
//        self.delegate?.action()
//    }
//    
//    lazy var pictureOfTheDayLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.textColor = .label
//        label.text = "Nasa Picture of The Day"
//        label.textAlignment = .left
//        label.numberOfLines = 0
//        label.lineBreakMode = .byWordWrapping
//        label.font = .systemFont(ofSize: 20, weight: .semibold)
//        return label
//    }()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        initViewCode()
//    }
//    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//    }
//
//}
//
//extension LauchScreen: ViewCode {
// 
//    func configureSubViews() {
//        self.addSubview(self.pictureOfTheDayImageView)
//        self.addSubview(self.pictureButton)
//        self.addSubview(self.pictureOfTheDayLabel)
//    }
//    
//    func configureConstraints() {
//        NSLayoutConstraint.activate([
//            
//            self.pictureOfTheDayImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 200),
//            self.pictureOfTheDayImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
//            self.pictureOfTheDayImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
//            self.pictureOfTheDayImageView.heightAnchor.constraint(equalToConstant: 50),
//            
//            self.pictureButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 200),
//            self.pictureButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
//            self.pictureButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
//            self.pictureButton.heightAnchor.constraint(equalToConstant: 50),
//        
//            self.pictureOfTheDayLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//            self.pictureOfTheDayLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
//        
//        
//        ])
//    }
//    
//    func configureAdditionalBehaviors() {
//        self.backgroundColor = .systemBackground
//    }
//    
//    func configureAccessibility() {
//
//    }
//    
//    
//}
