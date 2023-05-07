//
//  HomeCollectionHeader.swift
//  Supernova
//
//  Created by Henrique Marques on 31/01/23.
//

import UIKit
import SkeletonView

class HomeCollectionCellImage: UICollectionViewCell {
    
    static let identifier = "HomeCollectionCellImage"
    
    override var isHighlighted: Bool {
        didSet {
            contentView.alpha = isHighlighted ? 0.5 : 1.0
        }
    }
    
    // Por algum motivo, o scaleAspectFill fica ótimo em iPhones X >, porém n funciona em modelos 8<. Tendo q usar o
    
    lazy var pictureOfTheDayImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isSkeletonable = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .clear
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var pictureOfTheDayLabel: UILabel = {
        let label = UILabel()
        label.isSkeletonable = true
        label.linesCornerRadius = 7
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.text = "Nasa Picture of The Day"
        return label
    }()
    
    lazy var pictureOfTheDayNameLabel: UILabel = {
        let label = UILabel()
        label.isSkeletonable = true
        label.linesCornerRadius = 7
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.textAlignment = .left
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.text = "Loading..."
        return label
    }()
    
    lazy var imageShadowView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var textBlurView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        return view
    }()
    
    func configCell(with data: PictureOfTheDay) {
        self.pictureOfTheDayImageView.sd_setImage(with: URL(string: data.url ?? ""))
        self.pictureOfTheDayNameLabel.text = data.title
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        initViewCode()
    }
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension HomeCollectionCellImage: ViewCode {
 
    func configureSubViews() {
        self.contentView.addSubview(self.pictureOfTheDayImageView)
        self.contentView.addSubview(self.imageShadowView)
        self.contentView.addSubview(self.pictureOfTheDayLabel)
        self.contentView.addSubview(self.pictureOfTheDayNameLabel)
//        self.contentView.addSubview(self.textBlurView)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            
            self.pictureOfTheDayImageView.topAnchor.constraint(equalTo: self.topAnchor),
            self.pictureOfTheDayImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.pictureOfTheDayImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.pictureOfTheDayImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.imageShadowView.topAnchor.constraint(equalTo: self.topAnchor),
            self.imageShadowView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.imageShadowView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.imageShadowView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.pictureOfTheDayLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            self.pictureOfTheDayLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            self.pictureOfTheDayLabel.topAnchor.constraint(equalTo: self.pictureOfTheDayImageView.bottomAnchor, constant: -100),
            
            self.pictureOfTheDayNameLabel.topAnchor.constraint(equalTo: self.pictureOfTheDayLabel.bottomAnchor, constant: 2),
            self.pictureOfTheDayNameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            self.pictureOfTheDayNameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30),

        ])
    }
    
    func configureAdditionalBehaviors() {
        self.setShadow(view: self)
        self.isSkeletonable = true
        
        DispatchQueue.main.async {
            self.pictureOfTheDayImageView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .darkClouds), animation: nil, transition: .crossDissolve(0.25))
        }
        
        DispatchQueue.main.async {
            self.imageShadowView.setGradientBlackImage()
        }
    }
    
    func configureAccessibility() {
        
    }
}
