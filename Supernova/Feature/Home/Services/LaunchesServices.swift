//
//  LaunchesServices.swift
//  Supernova
//
//  Created by Henrique Marques on 08/08/23.
//

import Foundation
import Alamofire

protocol LaunchesServicesProtocol: AnyObject {
    func getFutureLaunches(completion: @escaping (Result<LastLauchesModel?, Error>) -> Void)
    func getLastLauches(completion: @escaping (Result<LastLauchesModel?, Error>) -> Void)
}

class LaunchesServices: LaunchesServicesProtocol {
    
    func getFutureLaunches(completion: @escaping (Result<LastLauchesModel?, Error>) -> Void) {
        guard let url = URL(string: "https://ll.thespacedevs.com/2.2.0/launch/upcoming/") else {return}
        
        AF.request(url, method: .get).response { response in
            switch response.result {
            case .success(let data):
                guard let data = data else {return}
                
                
                do {
                    let decoder = JSONDecoder()
                    let data = try decoder.decode(LastLauchesModel.self, from: data)
                    completion(.success(data))
                } catch {
                    completion(.failure(error))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getLastLauches(completion: @escaping (Result<LastLauchesModel?, Error>) -> Void) {
        guard let url = URL(string: "https://ll.thespacedevs.com/2.2.0/launch/previous/") else {return}
        AF.request(url, method: .get).response { response in
            switch response.result {
            case .success(let data):
                guard let data = data else {return}
                
                do {
                    let decoder = JSONDecoder()
                    let data = try decoder.decode(LastLauchesModel.self, from: data)
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
