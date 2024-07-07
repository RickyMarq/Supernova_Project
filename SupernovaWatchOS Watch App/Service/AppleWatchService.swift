//
//  AppleWatchService.swift
//  SupernovaWatchOS Watch App
//
//  Created by Henrique Marques on 27/06/23.
//

import Foundation

class AppleWatchService {
    
    static let sharedObjc = AppleWatchService()
    
    private init() {}
    
    enum Errors: String, Error {
        case badUrl = ""
    }
    
    func getPictureOfTheDay(completion: @escaping (PictureOfTheDayModel?, Error?) -> Void) {
        guard let url = URL(string: "https://api.nasa.gov/planetary/apod?api_key=w5JIaXjSdSutczlH7qd7LnKLY3nWZSQcEAFRPcNt") else {return}
        let session = URLSession.shared
        let request = URLRequest(url: url)
        
        session.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(nil, error)
                return}
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode(PictureOfTheDayModel.self, from: data)
                completion(model, nil)
            } catch {
                completion(nil, error)
            }
        }
        .resume()
    }
    
    func getFirstArticles(page: Int, completion: @escaping (Result<[ResultedNewsSite]?, Errors>) -> Void) {
        guard let url = URL(string: "https://api.spaceflightnewsapi.net/v4/articles?limit=10&offset=\(page)") else {return}
        let session = URLSession.shared
        let request = URLRequest(url: url)
        session.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(.failure(Errors.badUrl))
                return}
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode(NewsSiteModel.self, from: data)
                completion(.success(model.results))
            } catch {
                completion(.failure(Errors.badUrl))
            }
        }
        .resume()
    }
    
    func getFutureLauches(limit: Int, startsAt: Int, completion: @escaping (Result<[ResultedModel]?, Errors>) -> Void) {
        guard let url = URL(string: "https://ll.thespacedevs.com/2.2.0/launch/upcoming/?limit=12&offset=\(startsAt)") else {return}
        let session = URLSession.shared
        let request = URLRequest(url: url)
        session.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(.failure(Errors.badUrl))
                return}
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode(LastLauchesModel.self, from: data)
                completion(.success(model.results))
            } catch {
                completion(.failure(Errors.badUrl))
            }
        }
        .resume()
    }
    
    func getLastLauches(limit: Int, completion: @escaping (Result<[ResultedModel]?, Errors>) -> Void) {
        guard let url = URL(string: "https://ll.thespacedevs.com/2.2.0/launch/previous/?limit=12&offset=\(limit)") else {return}
        let session = URLSession.shared
        let request = URLRequest(url: url)
        session.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(.failure(Errors.badUrl))
                return}
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode(LastLauchesModel.self, from: data)
                completion(.success(model.results))
            } catch {
                completion(.failure(Errors.badUrl))
            }
        }
        .resume()
    }
}
