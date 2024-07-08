//
//  NasaObservatoryService.swift
//  SupernovaVision
//
//  Created by Henrique Marques on 11/01/24.
//

import Foundation

class NasaObservatoryService {
    
    static let sharedObjc = NasaObservatoryService()
    
    private init() {}

    func getLastPicturesOfTheDays(images: Int, completion: @escaping (Result<[PictureOfTheDay]?, NetworkingError>) -> Void) {
        guard let url = URL(string: "https://api.nasa.gov/planetary/apod?api_key=w5JIaXjSdSutczlH7qd7LnKLY3nWZSQcEAFRPcNt&count=\(images)") else {
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
                let model = try decoder.decode([PictureOfTheDay].self, from: data)
                completion(.success(model))
            } catch {
                completion(.failure(.decodingError))
            }
        }
        .resume()
    }
}
