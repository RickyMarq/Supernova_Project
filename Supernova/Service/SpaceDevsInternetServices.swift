//
//  SpaceDevsInternetServices.swift
//  Supernova
//
//  Created by Henrique Marques on 27/01/23.
//

import Foundation

class SpaceDevsInternetServices {
    
    static let sharedObjc = SpaceDevsInternetServices()
    
    private init() {}
    
    enum Errors: Error {
        case badUrl
    }
    
    func getAllSpaceSations(completion: @escaping (Result<[Resulted]?, Errors>) -> Void) {
        guard let url = URL(string: "https://ll.thespacedevs.com/2.2.0/spacestation/?format=json&limit=15") else {return}
        let session = URLSession.shared
        let request = URLRequest(url: url)
        session.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(.failure(Errors.badUrl))
                return}
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode(SpaceStationsModel.self, from: data)
                completion(.success(model.results))
            } catch {
                completion(.failure(Errors.badUrl))
            }
        }
        .resume()
    }
    
    func getUpcomingLauches(completion: @escaping (Result<[Resulted]?, Errors>) -> Void) {
        guard let url = URL(string: "https://ll.thespacedevs.com/2.2.0/launch/upcoming/") else {return}
        let session = URLSession.shared
        let request = URLRequest(url: url)
        session.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(.failure(Errors.badUrl))
                return}
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode(SpaceStationsModel.self, from: data)
                completion(.success(model.results))
            } catch {
                completion(.failure(Errors.badUrl))
            }
        }
        .resume()
    }
    
    func getFirstArticles(limit: Int, startsAt: Int, completion: @escaping (Result<[NewsModel]?, Errors>) -> Void) {
        guard let url = URL(string: "https://api.spaceflightnewsapi.net/v3/articles?_limit=\(limit)&_start=\(startsAt)") else {return}
        let session = URLSession.shared
        let request = URLRequest(url: url)
        session.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(.failure(Errors.badUrl))
                return}
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode([NewsModel].self, from: data)
                completion(.success(model))
            } catch {
                completion(.failure(Errors.badUrl))
            }
        }
        .resume()
    }
    
    func getLastLauches(limit: Int, completion: @escaping (Result<[ResultedModel]?, Errors>) -> Void) {
        guard let url = URL(string: "https://ll.thespacedevs.com/2.2.0/launch/previous/?limit=\(limit)&offset=\(limit)") else {return}
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
    
    func getFutureLauches(limit: Int, completion: @escaping (Result<[ResultedModel]?, Errors>) -> Void) {
        guard let url = URL(string: "https://ll.thespacedevs.com/2.2.0/launch/upcoming/?limit=\(limit)&offset=\(limit)") else {return}
        let session = URLSession.shared
        let request = URLRequest(url: url)
        session.dataTask(with: request) { data, response, error in
            print(response)
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
    
    func getLastEvents(limit: Int, completion: @escaping (Result<[ResultedEvents]?, Errors>) -> Void) {
        guard let url = URL(string: "https://ll.thespacedevs.com/2.2.0/event/?limit=\(limit)&offset=\(limit)") else {return}
        let session = URLSession.shared
        let request = URLRequest(url: url)
        session.dataTask(with: request) { data, response, error in
            print(response)
            guard let data = data else {
                completion(.failure(Errors.badUrl))
                return}
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode(LastEventsModel.self, from: data)
                completion(.success(model.results))
            } catch {
                completion(.failure(Errors.badUrl))
            }
        }
        .resume()
    }

}