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
}
