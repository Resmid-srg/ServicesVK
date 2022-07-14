//
//  NetworkingServices.swift
//  ServicesVK
//
//  Created by Dima on 14.07.22.
//

import Foundation

class NetworkService {
    
    func request(urlString: String, completion: @escaping (Result<VKServices, Error>) -> Void) {
        guard let url = URL(string:  urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    print(error)
                    return
                }
            guard let data = data else { return }
            do {
                let services = try JSONDecoder().decode(VKServices.self, from: data)
                completion(.success(services))
            } catch let jsonError {
                print("Failed to decode JSON", jsonError)
                completion(.failure(jsonError))
            }
        }
        }.resume()
    }
}
