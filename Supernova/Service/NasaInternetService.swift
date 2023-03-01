//
//  File.swift
//  Supernova
//
//  Created by Henrique Marques on 23/01/23.
//

import Foundation

class NasaInternetService {
    
    static let sharedObjc = NasaInternetService()
    
    private init() {}
    
    enum Errors: Error {
        case badUrl
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
        guard let url = URL(string: "https://api.nasa.gov/planetary/apod?api_key=w5JIaXjSdSutczlH7qd7LnKLY3nWZSQcEAFRPcNt&count=\(images)") else {return}
        let session = URLSession.shared
        let request = URLRequest(url: url)
        
        session.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(.failure(Errors.badUrl))
                return}
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode([PictureOfTheDay].self, from: data)
                completion(.success(model))
            } catch {
                completion(.failure(Errors.badUrl))
            }
        }
        .resume()
    }
}
