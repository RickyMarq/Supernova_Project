//
//  EventsCell.swift
//  Supernova
//
//  Created by Henrique Marques on 28/02/23.
//

import UIKit
import SkeletonView

class EventsCell: UICollectionViewCell {
    
    static let identifier = "EventsCell"
    
    lazy var eventsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isSkeletonable = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.roundCorners([.topLeft, .topRight], radius: 12.0)
        return imageView
    }()
        
    lazy var eventsNameLabel: UILabel = {
        let label = UILabel()
        label.isSkeletonable = true
        label.linesCornerRadius = 7
        label.skeletonTextNumberOfLines = 2
        label.skeletonLineSpacing = 2.5
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.textAlignment = .left
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    lazy var eventsDescriptionLabel: UILabel = {
        let label = UILabel()
        label.isSkeletonable = true
        label.linesCornerRadius = 7
        label.skeletonTextNumberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    lazy var locationEventLabel: UILabel = {
        let label = UILabel()
        label.isSkeletonable = true
        label.linesCornerRadius = 7
        label.skeletonTextNumberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .tertiaryLabel
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    lazy var eventsLiveView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.isSkeletonable = true
        view.backgroundColor = .primaryColour
        view.layer.cornerRadius = 10
        return view
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
    
    lazy var eventsLiveLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .label
        return label
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
    
    func configCell(with data: ResultedEvents) {
        self.eventsImageView.sd_setImage(with: URL(string: data.featureImage ?? ""))
        self.eventsNameLabel.text = data.name
        self.eventsDescriptionLabel.text = data.description
        self.locationEventLabel.text = data.location
        
        let formatDate = convertDateEventsFormatter(data.date ?? "")
        let formatHour = convertDateHourEventsFormatter(data.date ?? "")
        self.dateEventLabel.text = "Live in \(formatDate.capitalizedSentence)"
        self.dateHourLabel.text = "\(formatHour) GMT-3"
        
        if data.webcastLive == true {
            self.eventsLiveLabel.text = "Live"
        } else {
            UIView.animate(withDuration: 1.0, delay: 0) {
                self.eventsLiveLabel.text = "Not Live"
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViewCode()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

extension EventsCell: ViewCode {
  
    func configureSubViews() {
        self.contentView.addSubview(self.eventsImageView)
        self.contentView.addSubview(self.eventsNameLabel)
        self.contentView.addSubview(self.eventsDescriptionLabel)
        self.contentView.addSubview(self.locationEventLabel)
        self.eventsImageView.addSubview(self.eventsLiveView)
        self.eventsLiveView.addSubview(self.eventsLiveLabel)
        self.contentView.addSubview(self.calendarImageView)
        self.contentView.addSubview(self.clockImageView)
        self.contentView.addSubview(self.dateEventLabel)
        self.contentView.addSubview(self.dateHourLabel)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
        
            self.eventsImageView.topAnchor.constraint(equalTo: self.topAnchor),
            self.eventsImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.eventsImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.eventsImageView.heightAnchor.constraint(equalToConstant: 150),
            
            self.eventsNameLabel.topAnchor.constraint(equalTo: self.eventsImageView.bottomAnchor, constant: 8),
            self.eventsNameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12),
            self.eventsNameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12),
            
            self.eventsDescriptionLabel.topAnchor.constraint(equalTo: self.eventsNameLabel.bottomAnchor, constant: 8),
            self.eventsDescriptionLabel.leftAnchor.constraint(equalTo: self.eventsNameLabel.leftAnchor),
            self.eventsDescriptionLabel.rightAnchor.constraint(equalTo: self.eventsNameLabel.rightAnchor),
            self.eventsDescriptionLabel.heightAnchor.constraint(equalToConstant: 50),
            
            self.locationEventLabel.topAnchor.constraint(equalTo: self.eventsDescriptionLabel.bottomAnchor, constant: 8),
            self.locationEventLabel.leftAnchor.constraint(equalTo: self.eventsDescriptionLabel.leftAnchor),
            self.locationEventLabel.rightAnchor.constraint(equalTo: self.eventsDescriptionLabel.rightAnchor),
            
            self.calendarImageView.topAnchor.constraint(equalTo: self.dateEventLabel.topAnchor),
            self.calendarImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12),
            self.calendarImageView.heightAnchor.constraint(equalToConstant: 15),

            self.dateEventLabel.topAnchor.constraint(equalTo: self.bottomAnchor, constant: -30),
            self.dateEventLabel.leftAnchor.constraint(equalTo: self.calendarImageView.rightAnchor, constant: 8),
 //           self.dateEventLabel.rightAnchor.constraint(equalTo: self.eventsDescriptionLabel.rightAnchor),
            
            
            self.clockImageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12),
            self.clockImageView.heightAnchor.constraint(equalToConstant: 15),
            self.clockImageView.topAnchor.constraint(equalTo: self.calendarImageView.topAnchor),
            
            self.dateHourLabel.topAnchor.constraint(equalTo: self.dateEventLabel.topAnchor),
            self.dateHourLabel.rightAnchor.constraint(equalTo: self.clockImageView.leftAnchor, constant: -8),
            
            self.eventsLiveView.topAnchor.constraint(equalTo: self.eventsImageView.topAnchor, constant: 12),
            self.eventsLiveView.rightAnchor.constraint(equalTo: self.eventsImageView.rightAnchor, constant: -20),
            self.eventsLiveView.heightAnchor.constraint(equalToConstant: 30),
            self.eventsLiveView.widthAnchor.constraint(equalToConstant: 80),

            
            self.eventsLiveLabel.centerXAnchor.constraint(equalTo: self.eventsLiveView.centerXAnchor),
            self.eventsLiveLabel.centerYAnchor.constraint(equalTo: self.eventsLiveView.centerYAnchor),
        
        ])
    }
    
    func configureAdditionalBehaviors() {
        self.isSkeletonable = true
        self.backgroundColor = .secondarySystemBackground
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10
        self.setShadow(view: self)
    }
    
    func configureAccessibility() {
        
    }
    
    
}
