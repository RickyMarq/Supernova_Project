//
//  InternetServices.swift
//  Supernova
//
//  Created by Henrique Marques on 23/01/23.
//

import Foundation

class SpaceExInternetServices {
    
    static let sharedObjc = SpaceExInternetServices()
    
    private init() { }
    
    enum Errors: Error {
        case badUrl
    }
    
    func getUpcomingLaunches(completion: @escaping (Result<[UpcomingModel]?, Errors>) -> Void) {
        guard let url = URL(string: "https://api.spacexdata.com/v4/launches/upcoming") else {return}
        let session = URLSession.shared
        let request = URLRequest(url: url)
        session.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(.failure(Errors.badUrl))
                return}
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode([UpcomingModel].self, from: data)
                completion(.success(model))
            } catch {
                completion(.failure(Errors.badUrl))
            }
        }
        .resume()
    }
    
    func getAllLaunches(completion: @escaping (Result<[UpcomingModel]?, Errors>) -> Void) {
        guard let url = URL(string: "https://api.spacexdata.com/v4/launches") else {return}
        let session = URLSession.shared
        let request = URLRequest(url: url)
        session.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(.failure(Errors.badUrl))
                return}
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode([UpcomingModel].self, from: data)
                completion(.success(model))
            } catch {
                completion(.failure(Errors.badUrl))
            }
        }
        .resume()
    }
    
    func getPastLaunches(completion: @escaping (Result<[UpcomingModel]?, Errors>) -> Void) {
        guard let url = URL(string: "https://api.spacexdata.com/v4/launches/past") else {return}
        let session = URLSession.shared
        let request = URLRequest(url: url)
        session.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(.failure(Errors.badUrl))
                return}
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode([UpcomingModel].self, from: data)
                completion(.success(model))
            } catch {
                completion(.failure(Errors.badUrl))
            }
        }
        .resume()
    }
    
    func getAllDragons(completion: @escaping (Result<[DragonsModel]?, Errors>) -> Void) {
        guard let url = URL(string: "https://api.spacexdata.com/v4/dragons") else {return}
        let session = URLSession.shared
        let request = URLRequest(url: url)
        session.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(.failure(Errors.badUrl))
                return}
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode([DragonsModel].self, from: data)
                completion(.success(model))
            } catch {
                completion(.failure(Errors.badUrl))
            }
        }
        .resume()
    }
    
    func getAllCrew(completion: @escaping (Result<[CrewModel]?, Errors>) -> Void) {
        guard let url = URL(string: "https://api.spacexdata.com/v4/crew") else {return}
        let session = URLSession.shared
        let request = URLRequest(url: url)
        session.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(.failure(Errors.badUrl))
                return}
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode([CrewModel].self, from: data)
                completion(.success(model))
            } catch {
                completion(.failure(Errors.badUrl))
            }
        }
        .resume()
    }
    
    func getAllRockets(completion: @escaping (Result<[DragonsModel]?, Errors>) -> Void) {
        guard let url = URL(string: "https://api.spacexdata.com/v4/rockets") else {return}
        let session = URLSession.shared
        let request = URLRequest(url: url)
        session.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(.failure(Errors.badUrl))
                return}
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode([DragonsModel].self, from: data)
                completion(.success(model))
            } catch {
                completion(.failure(Errors.badUrl))
            }
        }
        .resume()
    }
    
    func getAllStarlink(completion: @escaping (Result<[DragonsModel]?, Errors>) -> Void) {
        guard let url = URL(string: "https://api.spacexdata.com/v4/starlink") else {return}
        let session = URLSession.shared
        let request = URLRequest(url: url)
        session.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(.failure(Errors.badUrl))
                return}
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode([DragonsModel].self, from: data)
                completion(.success(model))
            } catch {
                completion(.failure(Errors.badUrl))
            }
        }
        .resume()
    }
}
