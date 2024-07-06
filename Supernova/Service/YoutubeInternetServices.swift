//
//  YoutubeInternetServices.swift
//  Supernova
//
//  Created by Henrique Marques on 17/04/23.
//

import Foundation
import Alamofire

class YoutubeInternetServices {
    
    static let sharedObjc = YoutubeInternetServices()
    
    private init() {}
    
    func getVideosByName(name: String, completion: @escaping (Result<[ItemYT]?, Error>) -> Void) {
        print("DEBUG MODE: ITS A URL PROBLEM ?")
        let enconded = name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let apiKey = "&key=AIzaSyBpupH3mQqHrVro5Yb-ELusckyUmiLBxso"
        guard let url = URL(string: "https://www.googleapis.com/youtube/v3/search?part=id&q=" + enconded + apiKey) else {return}
        //https://www.googleapis.com/youtube/v3/search?part=id&q=Starship|IntegratedFlightTest&key=AIzaSyBpupH3mQqHrVro5Yb-ELusckyUmiLBxso
        
        AF.request(url, method: .get).response { response in
            switch response.result {
            case .success(let data):
                guard let data = data else {return}
                do {
                    let decoder = JSONDecoder()
                    let model = try decoder.decode(YoutubeSearch.self, from: data)
                    completion(.success(model.items))
                } catch {
                    completion(.failure(error))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
//    func getEvents(completion: @escaping (Result<LastEventsModel?, Error>) -> Void) {
//        guard let url = URL(string: "https://ll.thespacedevs.com/2.2.0/event/upcoming/") else {return}
//        
//        AF.request(url, method: .get).response { response in
//            switch response.result {
//            case .success(let data):
//                guard let data = data else {return}
//                
//                do {
//                    let decoder = JSONDecoder()
//                    let data = try decoder.decode(LastEventsModel.self, from: data)
//                    completion(.success(data))
//                } catch {
//                    completion(.failure(error))
//                }
//                
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }
    
}
