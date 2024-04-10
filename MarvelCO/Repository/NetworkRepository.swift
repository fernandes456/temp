//
//  NetworkRepository.swift
//  MarvelCO
//
//  Created by Geraldo Fernandes on 07/04/24.
//

import Foundation

class NetworkRepository: RepositoryProtocol {

    func fetchHeroes(completion: @escaping ([Hero], Error?) -> Void) {
        
        let publicKey = "9ebdb359fe98d87d0e7a07873a293272"
        let privateKey = "6a26d3ea02635fe645160b6908ae2a7e8478ab24"
        let timestamp = String(Date().timeIntervalSince1970)
        let hash = (timestamp + privateKey + publicKey).md5

        let baseUrl = "https://gateway.marvel.com:443/v1/public/characters"
        let queryItems = [
            URLQueryItem(name: "ts", value: timestamp),
            URLQueryItem(name: "apikey", value: publicKey),
            URLQueryItem(name: "hash", value: hash)
        ]
        
        var urlComponents = URLComponents(string: baseUrl)
        urlComponents?.queryItems = queryItems
        
        guard let url = urlComponents?.url else {
            completion([], NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "URL inválida"]))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion([], error)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(MarvelResponse.self, from: data)
                completion(response.data.results, nil)
            } catch {
                completion([], error)
            }
        }
        task.resume()
    }
    
    func saveHeroes(_ heroes: [Hero], completion: @escaping (Error?) -> Void) {
        
    }
}
