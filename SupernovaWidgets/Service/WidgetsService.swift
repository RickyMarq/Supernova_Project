//
//  WidgetsService.swift
//  SupernovaWidgetsExtension
//
//  Created by Henrique Marques on 06/07/24.
//

import Foundation

class WidgetsService {
    
    static let sharedObjc = WidgetsService()
    
    private init() {}
    
    enum Errors: String, Error {
        case badUrl = "Error on url"
        case data = "Data not found"
        case decode = "Error trying to decode data"
    }

    func getFutureLauches(limit: Int, startsAt: Int, completion: @escaping (Result<[ResultedModel]?, Errors>) -> Void) {
        guard let url = URL(string: "https://ll.thespacedevs.com/2.2.0/launch/upcoming/?limit=\(limit)&offset=\(startsAt)") else {
            completion(.failure(.badUrl))
            return
        }
        let session = URLSession.shared
        let request = URLRequest(url: url)
        session.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(.failure(.data))
                return
            }
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode(LastLauchesModel.self, from: data)
                completion(.success(model.results))
            } catch {
                completion(.failure(.decode))
            }
        }
        .resume()
    }
    
}
