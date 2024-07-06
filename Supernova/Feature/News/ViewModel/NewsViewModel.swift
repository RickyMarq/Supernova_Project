//
//  NewsViewModel.swift
//  Supernova
//
//  Created by Henrique Marques on 17/08/23.
//

import Foundation

protocol NewsViewModelProtocol: AnyObject {
    func success()
    func failure(error: String)
}

class NewsViewModel {
    
    weak var delegate: NewsViewModelProtocol?
    var newsResult: NewsSiteModel?
    var news: [ResultedNewsSite] = []
    var nextPage: String?
    var services: NewsServices?
    
    init(services: NewsServices? = nil) {
        self.services = services
    }
    
    func delegate(delegate: NewsViewModelProtocol) {
        self.delegate = delegate
    }
    
    func getNews() {
        services?.getNews(completion: { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let model):
                self.newsResult = model
                self.nextPage = self.newsResult?.next
                self.news.append(contentsOf: newsResult?.results ?? [])
                delegate?.success()
            case .failure(let error):
                delegate?.failure(error: error.localizedDescription)
            }
        })
    }
    
    func getMoreNews(nextPage: String) {
        services?.getMoreNews(url: nextPage, completion: { [weak self] result in
            guard let self = self else {return}
            
            switch result {
            case .success(let model):
                self.newsResult = model
                self.nextPage = self.newsResult?.next
                self.news.append(contentsOf: newsResult?.results ?? [])
                delegate?.success()
            case .failure(let error):
                delegate?.failure(error: error.localizedDescription)
            }
        })
    }
    
    func getNewsByProvider(newsProvider: String) {
        services?.getArticlesByNewsSite(newsSite: newsProvider, completion: { [weak self] result in
            guard let self = self else {return}
            
            switch result {
            case .success(let model):
                self.newsResult = model
                self.nextPage = self.newsResult?.next
                self.news.append(contentsOf: newsResult?.results ?? [])
                delegate?.success()
            case .failure(let error):
                delegate?.failure(error: error.localizedDescription)
            }
        })
    }
    
    var newsCount: Int {
        return news.count
    }
    
    func indexPath(indexPath: IndexPath) -> ResultedNewsSite {
        return news[indexPath.item]
    }
    
}
