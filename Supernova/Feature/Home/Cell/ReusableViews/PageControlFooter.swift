//
//  PageControlFooter.swift
//  Supernova
//
//  Created by Henrique Marques on 20/02/23.
//

import UIKit
import Combine

class PageControlFooter: UICollectionReusableView {
    
    static let identifier = "PageContPageControlFooterrolFooter"
    
    lazy var homePageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = .secondaryColour
        pageControl.pageIndicatorTintColor = .gray
        pageControl.isUserInteractionEnabled = false
//        pageControl.isAccessibilityElement = false
        pageControl.layer.masksToBounds = true
        pageControl.layer.cornerRadius = 10
        pageControl.tag = 100
        return pageControl
    }()
    
    private var pagingInfoToken: AnyCancellable?
    
    func numberOfItems(numberOfItems: Int) {
        self.homePageControl.numberOfPages = numberOfItems
    }
    
    
    func subscribeTo(subject: PassthroughSubject<PagingInfo, Never>, for section: Int) {
        pagingInfoToken = subject
            .filter { $0.sectionIndex == section }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] pagingInfo in
                self?.homePageControl.currentPage = pagingInfo.currentPage
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViewCode()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        pagingInfoToken?.cancel()
        pagingInfoToken = nil
    }
        
}

extension PageControlFooter: ViewCode {
   
    func configureSubViews() {
        self.addSubview(self.homePageControl)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
        
            self.homePageControl.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.homePageControl.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
    
    func configureAdditionalBehaviors() {
        
    }
    
    func configureAccessibility() {
        
    }
    
    
}
