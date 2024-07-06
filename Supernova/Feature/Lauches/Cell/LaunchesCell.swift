//
//  LaunchesCell.swift
//  Supernova
//
//  Created by Henrique Marques on 01/03/23.
//

import UIKit
import SkeletonView

class LaunchesCell: UICollectionViewCell {
    
    static let identifier = "LaunchesCell"
    var cellViewModel: LaunchesCellViewModel?
    
    lazy var launchImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isSkeletonable = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.roundCorners([.topLeft, .topRight], radius: 12.0)
        return imageView
    }()
    
    lazy var launchLiveView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.isSkeletonable = true
        view.backgroundColor = .primaryColour
        view.layer.cornerRadius = 10
        
        view.layer.shadowColor = UIColor.green.cgColor
        view.layer.shadowOpacity = 3
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowRadius = 10
        return view
    }()
    
    lazy var launchLiveLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .label
        return label
    }()
    
    lazy var launchNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isSkeletonable = true
        label.textColor = .label
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    lazy var companyNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isSkeletonable = true
        label.textColor = .secondaryLabel
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    lazy var calendarImageView: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "calendar"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.isSkeletonable = true
        image.tintColor = .label
        return image
    }()
    
    lazy var clockImageView: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "clock"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isSkeletonable = true
        image.contentMode = .scaleAspectFit
        image.tintColor = .label
        return image
    }()
    
    lazy var dateEventLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isSkeletonable = true
        label.textAlignment = .left
        label.textColor = .label
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    lazy var dateHourLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isSkeletonable = true
        label.textAlignment = .right
        label.textColor = .label
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
//    lazy var launchStateUIView: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.layer.masksToBounds = true
//        view.layer.cornerRadius = 10
//        view.backgroundColor = .tertiarySystemBackground
//
//        view.layer.cornerRadius = 12.0
//        view.layer.shadowColor = UIColor.white.cgColor
//        view.layer.shadowOffset = CGSize(width: 1, height: 1)
//        view.layer.shadowRadius = 3.5
//        view.layer.shadowOpacity = 3
//        return view
//    }()
//
//    lazy var launchStateImageView: UIImageView = {
//        let image = UIImageView()
//        image.translatesAutoresizingMaskIntoConstraints = false
//        image.contentMode = .scaleAspectFit
//        image.tintColor = .primaryColour
//        return image
//    }()
    
    func configCell(with data: ResultedModel) {
        self.cellViewModel = LaunchesCellViewModel(data: data)
        
        self.launchNameLabel.text = cellViewModel?.launchName
        self.companyNameLabel.text = cellViewModel?.companyName
        self.launchImageView.sd_setImage(with: URL(string: cellViewModel?.launchImage ?? ""))
        
//        let formatDate = convertDateLaunchesFormatter(data.windowStart ?? "")
//        let formatHour = convertHourLaunchesFormatter(data.windowStart ?? "", outPut: "HH:mm zzz")
        
        self.dateEventLabel.text = "Live in \(cellViewModel?.formatedDate.capitalizedSentence ?? "")"
        self.dateHourLabel.text = "\(cellViewModel?.formatedHour ?? "")"
        
        if cellViewModel?.launchLive == true {
            self.launchLiveLabel.text = "Live"
        } else {
            self.launchLiveLabel.text = "Not Live"
        }
        
        
        
//        if data.status.abbrev == "Go" {
//            self.launchStateImageView.image = UIImage(systemName: "clock")
//        } else {
//            self.launchStateImageView.image = UIImage(systemName: "checkmark")
//        }
        
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViewCode()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

extension LaunchesCell: ViewCode {
   
    func configureSubViews() {
        self.contentView.addSubview(self.launchImageView)
        self.contentView.addSubview(self.launchNameLabel)
        self.contentView.addSubview(self.companyNameLabel)
        self.contentView.addSubview(self.launchLiveView)
        self.launchLiveView.addSubview(self.launchLiveLabel)
        self.contentView.addSubview(self.calendarImageView)
        self.contentView.addSubview(self.clockImageView)
        self.contentView.addSubview(self.dateEventLabel)
        self.contentView.addSubview(self.dateHourLabel)
//        self.contentView.addSubview(self.launchStateUIView)
//        self.launchStateUIView.addSubview(self.launchStateImageView)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
        
            self.launchImageView.topAnchor.constraint(equalTo: self.topAnchor),
            self.launchImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.launchImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.launchImageView.heightAnchor.constraint(equalToConstant: 150),
            
            self.launchNameLabel.topAnchor.constraint(equalTo: self.launchImageView.bottomAnchor, constant: 8),
            self.launchNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            self.launchNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
            
            self.companyNameLabel.topAnchor.constraint(equalTo: self.launchNameLabel.bottomAnchor, constant: 8),
            self.companyNameLabel.leadingAnchor.constraint(equalTo: self.launchNameLabel.leadingAnchor),
            self.companyNameLabel.trailingAnchor.constraint(equalTo: self.launchNameLabel.trailingAnchor),
            
            self.launchLiveView.topAnchor.constraint(equalTo: self.launchImageView.topAnchor, constant: 12),
            self.launchLiveView.rightAnchor.constraint(equalTo: self.launchImageView.rightAnchor, constant: -20),
            self.launchLiveView.heightAnchor.constraint(equalToConstant: 30),
            self.launchLiveView.widthAnchor.constraint(equalToConstant: 80),

            self.launchLiveLabel.centerXAnchor.constraint(equalTo: self.launchLiveView.centerXAnchor),
            self.launchLiveLabel.centerYAnchor.constraint(equalTo: self.launchLiveView.centerYAnchor),

//            self.launchStateUIView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -20),
//            self.launchStateUIView.widthAnchor.constraint(equalToConstant: 40),
//            self.launchStateUIView.heightAnchor.constraint(equalToConstant: 40),
//            self.launchStateUIView.topAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -50),
//
//            self.launchStateImageView.centerXAnchor.constraint(equalTo: self.launchStateUIView.centerXAnchor),
//            self.launchStateImageView.centerYAnchor.constraint(equalTo: self.launchStateUIView.centerYAnchor),
//            self.launchStateImageView.heightAnchor.constraint(equalToConstant: 20),
//            self.launchStateImageView.widthAnchor.constraint(equalToConstant: 20),
            
            self.calendarImageView.topAnchor.constraint(equalTo: self.bottomAnchor, constant: -30),
            self.calendarImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12),
            self.calendarImageView.heightAnchor.constraint(equalToConstant: 15),

            self.dateEventLabel.centerYAnchor.constraint(equalTo: self.dateHourLabel.centerYAnchor),
            self.dateEventLabel.leftAnchor.constraint(equalTo: self.calendarImageView.rightAnchor, constant: 4),
            
            self.clockImageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12),
            self.clockImageView.heightAnchor.constraint(equalToConstant: 15),
            self.clockImageView.topAnchor.constraint(equalTo: self.calendarImageView.topAnchor),
            
//            self.dateHourLabel.topAnchor.constraint(equalTo: self.dateEventLabel.topAnchor),
            self.dateHourLabel.centerYAnchor.constraint(equalTo: self.clockImageView.centerYAnchor),
            self.dateHourLabel.rightAnchor.constraint(equalTo: self.clockImageView.leftAnchor, constant: -4),
        
        ])
    }
    
    func configureAdditionalBehaviors() {
        self.isSkeletonable = true
        self.setShadow(view: self)
        self.backgroundColor = .secondarySystemBackground
    }
    
    func configureAccessibility() { }
    
    
}
