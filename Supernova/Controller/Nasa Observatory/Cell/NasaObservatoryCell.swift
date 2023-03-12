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
        view.setShadow(view: self)
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
        return imageView
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
            self.nasaObservatoryImageView.bottomAnchor.constraint(equalTo: self.imageUIView.bottomAnchor),
        
        ])
    }
    
    func configureAdditionalBehaviors() {
        
    }
    
    func configureAccessibility() {
        
    }
}
