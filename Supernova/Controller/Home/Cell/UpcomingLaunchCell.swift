//
//  UpcomingLaunchCell.swift
//  Supernova
//
//  Created by Henrique Marques on 04/04/23.
//

import UIKit
import SkeletonView

class UpcomingLaunchCell: UICollectionViewCell {
    
    static let identifier = "UpcomingLaunchCell"
    var hourCountDown = 0
    var minuteCountDown = 0
    var secondCountDown = 0
    var count = 0
    
    lazy var rocketImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
//        image.alpha = 0.5
        return image
    }()
    
    lazy var separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .primaryColour
        view.layer.masksToBounds = true
        view.clipsToBounds = true
        view.frame = CGRect(x: 0, y: 0, width: 50, height: 5)
        view.layer.cornerRadius = view.frame.size.height / 2
        return view
    }()
    
    lazy var launchNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isSkeletonable = true
        label.textColor = .label
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    lazy var launchIDLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    lazy var launchDateOffSetReferenceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isSkeletonable = true
        label.textColor = .label
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    lazy var hoursView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    lazy var hourLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .heavy)
        label.text = "0"
        return label
    }()
    
    lazy var hoursTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.text = "Hours"
        label.textAlignment = .center
        return label
    }()
    
    lazy var minuteView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    lazy var minuteLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .heavy)
        label.text = "0"
        return label
    }()
    
    lazy var minuteTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.text = "Mins"
        label.textAlignment = .center
        return label
    }()
    
    lazy var secondView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    lazy var secondLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .heavy)
        label.text = "0"
        return label
    }()
    
    lazy var secondTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.text = "Secs"
        label.textAlignment = .center
        return label
    }()
    
    
    func configCell(with data: ResultedModel) {
        self.launchNameLabel.text = data.name
        self.launchIDLabel.text = "#\(data.rocket?.id ?? 0)"
        self.rocketImageView.sd_setImage(with: URL(string: data.image ?? ""))
        
        let fullHours = convertHoursForCountDownLaunchesFormatter(data.windowStart ?? "", outPut: "HH:mm:ss")
        
        let formatter = RelativeDateTimeFormatter()
        let timeInterval = fullHours.timeIntervalSince(Date())
        print("TIME INTERVAL: \(timeInterval)")
        
        let date = formatter.localizedString(for: fullHours, relativeTo: Date())
        
 //       self.launchDateOffSetReferenceLabel.text = "\(timeInterval)"
        
        let convertion = Int(timeInterval)


        let hours = convertion / 3600
        let minutes = (convertion % 3600) / 60
        let seconds = (convertion % 3600) % 60
        
        // RETORNAR DEPOIS
        
 //       self.launchDateOffSetReferenceLabel.text = "DEBUG MODE: \(hours) \(minutes) \(seconds) + \(date)"

        
//        let hour = convertHourLaunchesFormatter(data.windowStart ?? "", outPut: "HH")
//        let convert = Double(hour) ?? 0.0
//        print("DEBUG MODE: CONVERT STRING TO DOUBLE \(convert)")
//        if convert > 0.0 {
//            let hours: Double = convert / 3600.0
//            let remainder: Double = convert - (hours * 3600)
//            let minute = remainder / 60
//            let second = convert - (hours * 3600) - (minute * 60)
//            print("DEBUG MODE \(hours) \(minute) \(second) left")
//        } else {
//            print("DEBUG MODE: Valor Negativo")
//        }
        //       self.hourLabel.text = hour
//        self.hourCountDown = Int(hours) ?? 0
//      let minute = convertHourLaunchesFormatter(data.lastUpdated ?? "", outPut: "mm")
        //       self.minuteLabel.text = minute
//        self.minuteCountDown = Int(minutes) ?? 0
//        let second = convertHourLaunchesFormatter(data.lastUpdated ?? "", outPut: "ss")
//        self.secondCountDown = Int(seconds) ?? 0
        //       self.secondLabel.text = second
    }
    
    func startCountdown(data: ResultedModel) {
        if count == 0 {
            print("DEBUG MODE: HOW MUCH TIME DOES THE TIMER START ?")
            count += 1
            let fullHours = convertHoursForCountDownLaunchesFormatter(data.windowStart ?? "", outPut: "HH:mm:ss")
            let timeInterval = fullHours.timeIntervalSince(Date())
            let convertion = Int(timeInterval)


            let hours = convertion / 3600
            let minutes = (convertion % 3600) / 60
            let seconds = (convertion % 3600) % 60
            
            self.hourCountDown = Int(hours)
            self.minuteCountDown = Int(minutes) 
            self.secondCountDown = Int(seconds)

            if self.hourCountDown <= 0 && self.minuteCountDown <= 0 && self.secondCountDown <= 0 {
                self.hourLabel.text = "0"
                self.minuteLabel.text = "0"
                self.secondLabel.text = "0"
            } else {
                self.startTimer()
            }
        } else {
            print("DEBUG MODE: TIMER ALREADY STARTED")
        }
        
    }
    
    
    
    func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { _ in
            if self.secondCountDown > 0 {
                self.secondCountDown = self.secondCountDown - 1
            } else if self.minuteCountDown > 0 && self.secondCountDown == 0 {
                self.minuteCountDown = self.minuteCountDown - 1
                self.secondCountDown = 59
            } else if self.hourCountDown > 0 && self.minuteCountDown == 0 && self.secondCountDown == 0 {
                self.hourCountDown = self.hourCountDown - 1
                self.minuteCountDown = 59
                self.secondCountDown = 59
            }
            self.hourLabel.text = "\(self.hourCountDown)"
            self.minuteLabel.text = "\(self.minuteCountDown)"
            self.secondLabel.text = "\(self.secondCountDown)"
        })
    }
    
    func updateLabel() {
        DispatchQueue.main.async {
            self.hourLabel.text = "\(self.hourCountDown)"
            self.minuteLabel.text = "\(self.minuteCountDown)"
            self.secondLabel.text = "\(self.secondCountDown)"
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

extension UpcomingLaunchCell: ViewCode {
    
    func configureSubViews() {
        self.contentView.addSubview(self.rocketImageView)
        self.contentView.addSubview(self.separatorView)
        self.contentView.addSubview(self.launchNameLabel)
        self.contentView.addSubview(self.launchIDLabel)
        self.contentView.addSubview(self.hoursView)
        self.hoursView.addSubview(self.hourLabel)
        self.contentView.addSubview(self.hoursTitleLabel)
        self.contentView.addSubview(self.minuteView)
        self.minuteView.addSubview(self.minuteLabel)
        self.contentView.addSubview(self.minuteTitleLabel)
        self.contentView.addSubview(self.secondView)
        self.secondView.addSubview(self.secondLabel)
        self.contentView.addSubview(self.secondTitleLabel)
//        self.contentView.addSubview(self.launchDateOffSetReferenceLabel)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            
            self.rocketImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.rocketImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.rocketImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
//            self.rocketImageView.heightAnchor.constraint(equalToConstant: 150),
            self.rocketImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            
            self.separatorView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 12),
            self.separatorView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            self.separatorView.heightAnchor.constraint(equalToConstant: 5),
            self.separatorView.widthAnchor.constraint(equalToConstant: 50),
            
            self.launchNameLabel.topAnchor.constraint(equalTo: self.separatorView.bottomAnchor, constant: 8),
            self.launchNameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            self.launchNameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
            
            self.launchIDLabel.topAnchor.constraint(equalTo: self.launchNameLabel.bottomAnchor, constant: 8),
            self.launchIDLabel.leadingAnchor.constraint(equalTo: self.launchNameLabel.leadingAnchor),
            
            self.hoursView.topAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -100),
            self.hoursView.leadingAnchor.constraint(equalTo: self.launchNameLabel.leadingAnchor),
            self.hoursView.widthAnchor.constraint(equalToConstant: 50),
            self.hoursView.heightAnchor.constraint(equalToConstant: 50),
            
            self.hourLabel.centerXAnchor.constraint(equalTo: self.hoursView.centerXAnchor),
            self.hourLabel.centerYAnchor.constraint(equalTo: self.hoursView.centerYAnchor),
            
            self.hoursTitleLabel.topAnchor.constraint(equalTo: self.hoursView.bottomAnchor, constant: 8),
            self.hoursTitleLabel.centerXAnchor.constraint(equalTo: self.hoursView.centerXAnchor),

            self.minuteView.topAnchor.constraint(equalTo: self.hoursView.topAnchor),
            self.minuteView.widthAnchor.constraint(equalTo: self.hoursView.widthAnchor),
            self.minuteView.heightAnchor.constraint(equalTo: self.hoursView.heightAnchor),
            self.minuteView.leftAnchor.constraint(equalTo: self.hoursView.rightAnchor, constant: 8),
            
            self.minuteLabel.centerXAnchor.constraint(equalTo: self.minuteView.centerXAnchor),
            self.minuteLabel.centerYAnchor.constraint(equalTo: self.minuteView.centerYAnchor),
            
            self.minuteTitleLabel.topAnchor.constraint(equalTo: self.minuteView.bottomAnchor, constant: 8),
            self.minuteTitleLabel.centerXAnchor.constraint(equalTo: self.minuteView.centerXAnchor),
            
            self.secondView.topAnchor.constraint(equalTo: self.hoursView.topAnchor),
            self.secondView.widthAnchor.constraint(equalTo: self.hoursView.widthAnchor),
            self.secondView.heightAnchor.constraint(equalTo: self.hoursView.heightAnchor),
            self.secondView.leftAnchor.constraint(equalTo: self.minuteView.rightAnchor, constant: 8),
            
            self.secondLabel.centerXAnchor.constraint(equalTo: self.secondView.centerXAnchor),
            self.secondLabel.centerYAnchor.constraint(equalTo: self.secondView.centerYAnchor),
            
            self.secondTitleLabel.topAnchor.constraint(equalTo: self.secondView.bottomAnchor, constant: 8),
            self.secondTitleLabel.centerXAnchor.constraint(equalTo: self.secondView.centerXAnchor),

//            self.launchDateOffSetReferenceLabel.topAnchor.constraint(equalTo: self.hoursTitleLabel.bottomAnchor, constant: 12),
//            self.launchDateOffSetReferenceLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
        
        
        ])
    }
    
    func configureAdditionalBehaviors() {
        self.backgroundColor = .tertiarySystemBackground
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10
        
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.alpha = 1.0
        DispatchQueue.main.async {
            blurView.frame = self.rocketImageView.bounds
            blurView.center = self.rocketImageView.center
            self.rocketImageView.addSubview(blurView)
        }
      
    }
    
    func configureAccessibility() {
        
    }
    
}
