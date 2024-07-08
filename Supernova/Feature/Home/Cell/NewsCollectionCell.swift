//
//  NewsCollectionCell.swift
//  Supernova
//
//  Created by Henrique Marques on 30/01/23.
//

import SkeletonView
import UIKit
import GoogleMobileAds

class NewsCollectionCell: UICollectionViewCell {
    
    static let identifier = "NewsCollectionCell"
    
    override var isHighlighted: Bool {
        didSet {
            contentView.alpha = isHighlighted ? 0.8 : 1.0
        }
    }
    
    lazy var newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isSkeletonable = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.roundCorners([.topLeft, .topRight], radius: 12.0)
        return imageView
    }()
    
    lazy var newsProviderLabel: UILabel = {
        let label = UILabel()
        label.isSkeletonable = true
        label.linesCornerRadius = 7
        label.skeletonTextNumberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    lazy var newsNameLabel: UILabel = {
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
    
    lazy var newsDescriptionLabel: UILabel = {
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
    
    lazy var newsDateLabel: UILabel = {
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
    
    func configCell(with data: ResultedNewsSite) {
        self.newsImageView.sd_setImage(with: URL(string: data.imageURL ?? "Error"))
        self.newsProviderLabel.text = data.newsSite
        self.newsNameLabel.text = data.title
        self.newsDescriptionLabel.text = data.title
        
        
        let hour = convertHourNewsFormatter(data.publishedAt ?? "")
        let day = convertDayOfWeekFormatter(data.publishedAt ?? "")
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        let date = formatter.localizedString(for: hour, relativeTo: Date())
        self.newsDateLabel.text = "\(day.capitalizedSentence) • \(date)"
    }
    
    func configCellEvents(with data: ResultedEvents) {
        self.newsImageView.sd_setImage(with: URL(string: data.featureImage ?? "Error"))
        self.newsNameLabel.text = data.name
        self.newsDescriptionLabel.text = data.description
        
        let filterData = convertDateEventsFormatter(data.date ?? "")
        self.newsDateLabel.text = "Published at: \(filterData) GMT"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViewCode()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension NewsCollectionCell: ViewCode {
  
    func configureSubViews() {
        self.contentView.addSubview(self.newsImageView)
        self.contentView.addSubview(self.newsProviderLabel)
        self.contentView.addSubview(self.newsNameLabel)
        self.contentView.addSubview(self.newsDescriptionLabel)
        self.contentView.addSubview(self.newsDateLabel)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
        
            self.newsImageView.topAnchor.constraint(equalTo: self.topAnchor),
            self.newsImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.newsImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.newsImageView.heightAnchor.constraint(equalToConstant: 150),
        
            self.newsProviderLabel.topAnchor.constraint(equalTo: self.newsImageView.bottomAnchor, constant: 8),
            self.newsProviderLabel.leftAnchor.constraint(equalTo: self.newsNameLabel.leftAnchor),
            self.newsProviderLabel.rightAnchor.constraint(equalTo: self.newsNameLabel.rightAnchor),
            
            self.newsNameLabel.topAnchor.constraint(equalTo: self.newsProviderLabel.bottomAnchor, constant: 8),
            self.newsNameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12),
            self.newsNameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12),
            
            self.newsDescriptionLabel.topAnchor.constraint(equalTo: self.newsNameLabel.bottomAnchor, constant: 8),
            self.newsDescriptionLabel.leftAnchor.constraint(equalTo: self.newsNameLabel.leftAnchor),
            self.newsDescriptionLabel.rightAnchor.constraint(equalTo: self.newsNameLabel.rightAnchor),
            self.newsDescriptionLabel.heightAnchor.constraint(equalToConstant: 50),

            self.newsDateLabel.topAnchor.constraint(equalTo: self.bottomAnchor, constant: -30),
            self.newsDateLabel.leftAnchor.constraint(equalTo: self.newsDescriptionLabel.leftAnchor),
            self.newsDateLabel.rightAnchor.constraint(equalTo: self.newsDescriptionLabel.rightAnchor),
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
