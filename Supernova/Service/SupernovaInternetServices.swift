//
//  SupernovaInternetServices.swift
//  Supernova
//
//  Created by Henrique Marques on 21/06/23.
//

import Foundation

class SupernovaInternetServices {
    
    static let sharedObjc = SupernovaInternetServices()
    
    private init() {}
    
    enum Errors: String, Error {
        case badUrl = ""
    }
    
    func getRockets(completion: @escaping (Result<[SupernovaRocketModel]?, Errors>) -> Void) {
        guard let url = URL(string: "https://supernova-rocket-ftvvby42x-rickymarq.vercel.app/getRockets") else {return}
        let session = URLSession.shared
        let request = URLRequest(url: url)
        session.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(.failure(Errors.badUrl))
                return}
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode(SupernovaRocketData.self, from: data)
                completion(.success(model.data))
            } catch {
                completion(.failure(Errors.badUrl))
            }
        }
        .resume()
    }
    
    
}