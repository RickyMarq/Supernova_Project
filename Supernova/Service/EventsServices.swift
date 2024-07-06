//
//  EventsServices.swift
//  Supernova
//
//  Created by Henrique Marques on 09/08/23.
//

import Foundation
import Alamofire

protocol EventsServicesProtocol: AnyObject {
    func getEvents(completion: @escaping (Result<LastEventsModel?, Error>) -> Void)
}

class EventsServices: EventsServicesProtocol {
    
    func getEvents(completion: @escaping (Result<LastEventsModel?, Error>) -> Void) {
        guard let url = URL(string: "https://ll.thespacedevs.com/2.2.0/event/upcoming/") else {return}
        
        AF.request(url, method: .get).response { response in
            switch response.result {
            case .success(let data):
                guard let data = data else {return}
                
                do {
                    let decoder = JSONDecoder()
                    let data = try decoder.decode(LastEventsModel.self, from: data)
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
