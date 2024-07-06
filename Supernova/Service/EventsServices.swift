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
    
//    func getLastEvents(limit: Int, startsAt: Int, completion: @escaping (Result<[ResultedEvents]?, Errors>) -> Void) {
//        guard let url = URL(string: "https://ll.thespacedevs.com/2.2.0/event/upcoming/?limit=\(limit)&offset=\(startsAt)") else {return}
//        let session = URLSession.shared
//        let request = URLRequest(url: url)
//        session.dataTask(with: request) { data, response, error in
//            print(response)
//            guard let data = data else {
//                completion(.failure(Errors.badUrl))
//                return}
//            do {
//                let decoder = JSONDecoder()
//                let model = try decoder.decode(LastEventsModel.self, from: data)
//                completion(.success(model.results))
//            } catch {
//                completion(.failure(Errors.badUrl))
//            }
//        }
//        .resume()
//    }
    
}
