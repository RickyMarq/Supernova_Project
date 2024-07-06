//
//  RocketServices.swift
//  Supernova
//
//  Created by Henrique Marques on 09/08/23.
//

import Foundation
import Alamofire

protocol RocketServicesProtocol: AnyObject {
    func getRockets(url: String, completion: @escaping (Result<RocketModel?, Error>) -> Void)
}

class RocketServices: RocketServicesProtocol {
    
    func getRockets(url: String, completion: @escaping (Result<RocketModel?, Error>) -> Void) {
        guard let url = URL(string: "\(url)") else {return}

        AF.request(url, method: .get).response { response in
            switch response.result {
            case .success(let data):
                guard let data = data else {return}
                
                do {
                    let decoder = JSONDecoder()
                    let data = try decoder.decode(RocketModel.self, from: data)
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
