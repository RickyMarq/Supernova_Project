//
//  ImageViewerScreen.swift
//  Supernova
//
//  Created by Henrique Marques on 25/01/23.
//

import UIKit

protocol ImageViewerScreenProtocol: AnyObject {
    func dissmissButtonAction()
    func saveImageButtonAction()
}

class ImageViewerScreen: UIView {
    
    weak var delegate: ImageViewerScreenProtocol?
    
    func delegate(delegate: ImageViewerScreenProtocol) {
        self.delegate = delegate
    }
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var imageViewerScroll: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsVerticalScrollIndicator = false
        scroll.showsHorizontalScrollIndicator = false
        scroll.maximumZoomScale = 6.0
        scroll.minimumZoomScale = 1.0
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    lazy var imageNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .label
        return label
    }()
    
    lazy var imageExplanationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .secondaryLabel
        return label
    }()
    
    lazy var explanationScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    lazy var explanationContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    public func scrollViewProtocol(delegate: UIScrollViewDelegate) {
        self.imageViewerScroll.delegate = delegate
    }
    
    lazy var pictureOfTheDayImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var dismissButton: UIButton = {
        let button = UIButton(type: .close)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBackground
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(tappedDismissButton), for: .touchUpInside)
        return button
    }()
    
    lazy var saveImageButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Save Image", for: .normal)
        button.setButtonDesign(layout: .primary)
        button.addTarget(self, action: #selector(tappedSaveImageButton), for: .touchUpInside)
        return button
    }()
        
    @objc func tappedSaveImageButton() {
        self.delegate?.saveImageButtonAction()
    }
    
    @objc func tappedDismissButton() {
        self.delegate?.dissmissButtonAction()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViewCode()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

extension ImageViewerScreen: ViewCode {
    
    func configureSubViews() {
        self.addSubview(self.imageViewerScroll)
        self.imageViewerScroll.addSubview(self.contentView)
        
        self.contentView.addSubview(self.pictureOfTheDayImageView)
        self.addSubview(self.imageNameLabel)
        self.addSubview(self.dismissButton)
        self.addSubview(self.saveImageButton)
        self.addSubview(self.explanationScrollView)
        self.explanationScrollView.addSubview(self.explanationContentView)
        self.explanationContentView.addSubview(self.imageExplanationLabel)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            
            self.imageViewerScroll.topAnchor.constraint(equalTo: self.topAnchor, constant: 200),
            self.imageViewerScroll.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.imageViewerScroll.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.imageViewerScroll.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -200),
            
            self.contentView.topAnchor.constraint(equalTo: self.imageViewerScroll.topAnchor),
            self.contentView.leadingAnchor.constraint(equalTo: self.imageViewerScroll.leadingAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.imageViewerScroll.trailingAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.imageViewerScroll.bottomAnchor),

            self.dismissButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 32),
            self.dismissButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            self.dismissButton.heightAnchor.constraint(equalToConstant: 50),
            self.dismissButton.widthAnchor.constraint(equalToConstant: 50),
            
            self.saveImageButton.topAnchor.constraint(equalTo: self.dismissButton.topAnchor),
            self.saveImageButton.rightAnchor.constraint(equalTo: self.dismissButton.leftAnchor, constant: -20),
            self.saveImageButton.heightAnchor.constraint(equalToConstant: 50),
            self.saveImageButton.widthAnchor.constraint(equalToConstant: 120),
            
            self.pictureOfTheDayImageView.topAnchor.constraint(equalTo: self.topAnchor),
            self.pictureOfTheDayImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.pictureOfTheDayImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.pictureOfTheDayImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.imageNameLabel.topAnchor.constraint(equalTo: self.imageViewerScroll.bottomAnchor, constant: 10),
            self.imageNameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12),
            self.imageNameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12),
            
            self.explanationScrollView.topAnchor.constraint(equalTo: self.imageNameLabel.bottomAnchor, constant: 12),
            self.explanationScrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.explanationScrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.explanationScrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -12),
            
            self.explanationContentView.topAnchor.constraint(equalTo: self.explanationScrollView.topAnchor),
            self.explanationContentView.bottomAnchor.constraint(equalTo: self.explanationScrollView.bottomAnchor),
            self.explanationContentView.widthAnchor.constraint(equalTo: self.explanationScrollView.widthAnchor),
            
            self.explanationScrollView.centerXAnchor.constraint(equalTo: self.explanationScrollView.centerXAnchor),
            self.explanationScrollView.centerYAnchor.constraint(equalTo: self.explanationScrollView.centerYAnchor),
            
            
            self.imageExplanationLabel.topAnchor.constraint(equalTo: self.explanationContentView.topAnchor, constant: 4),
            self.imageExplanationLabel.bottomAnchor.constraint(equalTo: self.explanationContentView.bottomAnchor, constant: -4),
            self.imageExplanationLabel.leftAnchor.constraint(equalTo: self.explanationContentView.leftAnchor, constant: 12),
            self.imageExplanationLabel.rightAnchor.constraint(equalTo: self.explanationContentView.rightAnchor, constant: -12),
            
        ])
    }
    
    func configureAdditionalBehaviors() {
        self.backgroundColor = .systemBackground
    }
    
    func configureAccessibility() { }
        
}
