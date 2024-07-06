//
//  NewsServices.swift
//  Supernova
//
//  Created by Henrique Marques on 17/08/23.
//

import Foundation
import Alamofire

protocol NewsServicesProtocol: AnyObject {
    func getNews(completion: @escaping (Result<NewsSiteModel?, Error>) -> Void)
    func getMoreNews(url: String, completion: @escaping (Result<NewsSiteModel?, Error>) -> Void)
    func getArticlesByNewsSite(newsSite: String, completion: @escaping (Result<NewsSiteModel, Error>) -> Void) 
}

class NewsServices: NewsServicesProtocol {
    
    func getNews(completion: @escaping (Result<NewsSiteModel?, Error>) -> Void) {
        guard let url = URL(string: "https://api.spaceflightnewsapi.net/v4/articles") else {return}

        AF.request(url, method: .get).response { response in
            switch response.result {
            case .success(let data):
                guard let data = data else {return}
                do {
                    let decoder = JSONDecoder()
                    let data = try decoder.decode(NewsSiteModel.self, from: data)
                    completion(.success(data))
                } catch {
                    completion(.failure(error))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getMoreNews(url: String, completion: @escaping (Result<NewsSiteModel?, Error>) -> Void) {
        guard let url = URL(string: "\(url)") else {return}

        AF.request(url, method: .get).response { response in
            switch response.result {
            case .success(let data):
                guard let data = data else {return}
                do {
                    let decoder = JSONDecoder()
                    let data = try decoder.decode(NewsSiteModel.self, from: data)
                    completion(.success(data))
                } catch {
                    completion(.failure(error))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getArticlesByNewsSite(newsSite: String, completion: @escaping (Result<NewsSiteModel, Error>) -> Void) {
        guard let url = URL(string: "https://api.spaceflightnewsapi.net/v4/articles/?news_site=\(newsSite)") else {return}
        
        AF.request(url, method: .get).response { response in
        
            switch response.result {
                
            case .success(let data):
                guard let data = data else {return}
                do {
                    let decoder = JSONDecoder()
                    let data = try decoder.decode(NewsSiteModel.self, from: data)
                    completion(.success(data))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
                
            }
        }
    }
}
