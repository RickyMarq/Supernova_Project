//
//  LaunchServices.swift
//  SupernovaVision
//
//  Created by Henrique Marques on 15/11/23.
//

import Foundation


class LaunchServices {
    
    static let sharedObjc = LaunchServices()
    
    private init() {}
    
    func getUpcomingLaunches(limit: Int, startsAt: Int, completion: @escaping (Result<[ResultedModel]?, NetworkingError>) -> Void) {
        guard let url = URL(string: "https://ll.thespacedevs.com/2.2.0/launch/upcoming/?limit=12&offset=\(startsAt)") else {
            completion(.failure(.badUrl))
            return
        }
        let session = URLSession.shared
        let request = URLRequest(url: url)
        session.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(.failure(.badUrl))
                return}
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode(LastLauchesModel.self, from: data)
                completion(.success(model.results))
            } catch {
                completion(.failure(.decodingError))
            }
        }
        .resume()
    }
    
    func getPictureOfTheDay(completion: @escaping (Result<PictureOfTheDay?, NetworkingError>) -> Void) {
        guard let url = URL(string: "https://api.nasa.gov/planetary/apod?api_key=w5JIaXjSdSutczlH7qd7LnKLY3nWZSQcEAFRPcNt") else {
            completion(.failure(NetworkingError.badUrl))
            return
        }
        let session = URLSession.shared
        let request = URLRequest(url: url)
        
        session.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(.failure(.badUrl))
                print("Error")
                return}
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode(PictureOfTheDay.self, from: data)
                completion(.success(model))
            } catch {
                completion(.failure(NetworkingError.decodingError))
                print("Error")
            }
        }
        .resume()
    }
}
