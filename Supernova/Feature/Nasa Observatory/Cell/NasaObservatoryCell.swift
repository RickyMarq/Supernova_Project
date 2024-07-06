//
//  NasaObservatoryCell.swift
//  Supernova
//
//  Created by Henrique Marques on 04/03/23.
//

import UIKit

class NasaObservatoryCell: UICollectionViewCell {
    
    static let identifier = "NasaObservatoryCell"
    
    lazy var imageUIView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.backgroundColor = .clear
//        view.setShadow(view: self)
        return view
    }()
    
    lazy var contentViewLabel: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var nasaObservatoryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.roundCorners(.allCorners, radius: 10)
        return imageView
    }()
    
    lazy var nasaImageNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.textColor = .label
        label.lineBreakMode = .byTruncatingTail
        label.text = "Test text"
        label.font = .systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViewCode()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

extension NasaObservatoryCell: ViewCode {
   
    func configureSubViews() {
        self.contentView.addSubview(self.imageUIView)
        self.imageUIView.addSubview(self.nasaObservatoryImageView)
        self.imageUIView.addSubview(self.nasaImageNameLabel)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
        
            self.imageUIView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.imageUIView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.imageUIView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.imageUIView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            
            self.nasaObservatoryImageView.topAnchor.constraint(equalTo: self.imageUIView.topAnchor),
            self.nasaObservatoryImageView.leadingAnchor.constraint(equalTo: self.imageUIView.leadingAnchor),
            self.nasaObservatoryImageView.trailingAnchor.constraint(equalTo: self.imageUIView.trailingAnchor),
            self.nasaObservatoryImageView.bottomAnchor.constraint(equalTo: self.imageUIView.bottomAnchor, constant: -20),
            
            self.nasaImageNameLabel.topAnchor.constraint(equalTo: self.nasaObservatoryImageView.bottomAnchor, constant: 4),
            self.nasaImageNameLabel.leadingAnchor.constraint(equalTo: self.imageUIView.leadingAnchor, constant: 4),
            self.nasaImageNameLabel.trailingAnchor.constraint(equalTo: self.imageUIView.trailingAnchor, constant: -4),
//            self.nasaImageNameLabel.bottomAnchor.constraint(equalTo: self.nasaObservatoryImageView.bottomAnchor, constant: -4),
        
        ])
    }
    
    func configureAdditionalBehaviors() {
        
    }
    
    func configureAccessibility() {
        
    }
}
