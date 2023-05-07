//
//  YoutubeInternetServices.swift
//  Supernova
//
//  Created by Henrique Marques on 17/04/23.
//

import Foundation

class YoutubeInternetServices {
    
    static let sharedObjc = YoutubeInternetServices()
    
    private init() { }
    
    enum Errors: Error {
        case badUrl
    }

    func getVideosByName(name: String, completion: @escaping (Result<[ItemYT]?, Errors>) -> Void) {
        print("DEBUG MODE: ITS A URL PROBLEM ?")
        let enconded = name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let apiKey = "&key=AIzaSyBpupH3mQqHrVro5Yb-ELusckyUmiLBxso"
        guard let url = URL(string: "https://www.googleapis.com/youtube/v3/search?part=id&q=" + enconded + apiKey) else {return}
        //https://www.googleapis.com/youtube/v3/search?part=id&q=Starship|IntegratedFlightTest&key=AIzaSyBpupH3mQqHrVro5Yb-ELusckyUmiLBxso
        let session = URLSession.shared
        let request = URLRequest(url: url)
        session.dataTask(with: request) { data, response, error in
            print("DEBUG MODE \(url)")
            guard let data = data else {
                completion(.failure(Errors.badUrl))
                return}
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode(YoutubeSearch.self, from: data)
                completion(.success(model.items))
            } catch {
                completion(.failure(Errors.badUrl))
            }
        }
        .resume()
    }
    
    
}
