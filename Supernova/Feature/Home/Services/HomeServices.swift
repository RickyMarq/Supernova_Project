//
//  HomeServices.swift
//  Supernova
//
//  Created by Henrique Marques on 23/08/23.
//

import Foundation

protocol HomeServicesProtocol: AnyObject {
    func getPastLaunches(completion: @escaping (Result<[UpcomingModel]?, Errors>) -> Void)
    func getPictureOfTheDay(completion: @escaping (PictureOfTheDay?, Error?) -> Void)
    func getLastPicturesOfTheDays(images: Int, completion: @escaping (Result<[PictureOfTheDay]?, Errors>) -> Void)
    func getLastLauches(limit: Int, completion: @escaping (Result<[ResultedModel]?, Errors>) -> Void)
    func getFutureLauches(limit: Int, startsAt: Int, completion: @escaping (Result<[ResultedModel]?, Errors>) -> Void)
    func getFirstArticles(limit: Int, startsAt: Int, completion: @escaping (Result<[ResultedNewsSite]?, Errors>) -> Void)
    func getLastEvents(limit: Int, startsAt: Int, completion: @escaping (Result<[ResultedEvents]?, Errors>) -> Void)
}

class HomeServices: HomeServicesProtocol {
    
    func getPastLaunches(completion: @escaping (Result<[UpcomingModel]?, Errors>) -> Void) {
        guard let url = URL(string: "https://api.spacexdata.com/v4/launches/past") else {
            completion(.failure(.badUrl))
            return
        }
        let session = URLSession.shared
        let request = URLRequest(url: url)
        session.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(.failure(.data))
                return
            }
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode([UpcomingModel].self, from: data)
                completion(.success(model))
            } catch {
                completion(.failure(.decode))
            }
        }
        .resume()
    }
    
    func getPictureOfTheDay(completion: @escaping (PictureOfTheDay?, Error?) -> Void) {
        guard let url = URL(string: "https://api.nasa.gov/planetary/apod?api_key=w5JIaXjSdSutczlH7qd7LnKLY3nWZSQcEAFRPcNt") else {return}
        let session = URLSession.shared
        let request = URLRequest(url: url)
        
        session.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(nil, error)
                return}
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode(PictureOfTheDay.self, from: data)
                completion(model, nil)
            } catch {
                completion(nil, error)
            }
        }
        .resume()
    }
    
    func getLastPicturesOfTheDays(images: Int, completion: @escaping (Result<[PictureOfTheDay]?, Errors>) -> Void) {
        guard let url = URL(string: "https://api.nasa.gov/planetary/apod?api_key=w5JIaXjSdSutczlH7qd7LnKLY3nWZSQcEAFRPcNt&count=\(images)") else {
            completion(.failure(.badUrl))
            return
        }
        let session = URLSession.shared
        let request = URLRequest(url: url)
        
        session.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(.failure(.data))
                return}
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode([PictureOfTheDay].self, from: data)
                completion(.success(model))
            } catch {
                completion(.failure(.decode))
            }
        }
        .resume()
    }
    
    func getLastLauches(limit: Int, completion: @escaping (Result<[ResultedModel]?, Errors>) -> Void) {
        guard let url = URL(string: "https://ll.thespacedevs.com/2.2.0/launch/previous/?limit=\(limit)&offset=\(limit)") else {
            completion(.failure(.badUrl))
            return
        }
        let session = URLSession.shared
        let request = URLRequest(url: url)
        session.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(.failure(.data))
                return}
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode(LastLauchesModel.self, from: data)
                completion(.success(model.results))
            } catch {
                completion(.failure(.decode))
            }
        }
        .resume()
    }
    
    func getFutureLauches(limit: Int, startsAt: Int, completion: @escaping (Result<[ResultedModel]?, Errors>) -> Void) {
        guard let url = URL(string: "https://ll.thespacedevs.com/2.2.0/launch/upcoming/?limit=\(limit)&offset=\(startsAt)") else {
            completion(.failure(.badUrl))
            return
        }
        let session = URLSession.shared
        let request = URLRequest(url: url)
        session.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(.failure(.data))
                return}
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode(LastLauchesModel.self, from: data)
                completion(.success(model.results))
            } catch {
                completion(.failure(.decode))
            }
        }
        .resume()
    }
    
    func getFirstArticles(limit: Int, startsAt: Int, completion: @escaping (Result<[ResultedNewsSite]?, Errors>) -> Void) {
        guard let url = URL(string: "https://api.spaceflightnewsapi.net/v4/articles?limit=\(limit)&offset=\(startsAt)") else {
            completion(.failure(.badUrl))
            return
        }
        let session = URLSession.shared
        let request = URLRequest(url: url)
        session.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(.failure(.data))
                return}
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode(NewsSiteModel.self, from: data)
                completion(.success(model.results))
            } catch {
                completion(.failure(.decode))
            }
        }
        .resume()
    }
    
    func getLastEvents(limit: Int, startsAt: Int, completion: @escaping (Result<[ResultedEvents]?, Errors>) -> Void) {
        guard let url = URL(string: "https://ll.thespacedevs.com/2.2.0/event/upcoming/?limit=\(limit)&offset=\(startsAt)") else {
            completion(.failure(.badUrl))
            return
        }
        let session = URLSession.shared
        let request = URLRequest(url: url)
        session.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(.failure(.data))
                return}
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode(LastEventsModel.self, from: data)
                completion(.success(model.results))
            } catch {
                completion(.failure(.decode))
            }
        }
        .resume()
    }
}
