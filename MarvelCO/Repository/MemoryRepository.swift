//
//  MemoryRepository.swift
//  MarvelCO
//
//  Created by Geraldo Fernandes on 07/04/24.
//

import Foundation

class MemoryRepository: RepositoryProtocol {
    
    private var heroes = [Hero]()
//    [Hero(id: 1,
//                               name: "Spider-Man",
//                               description: "Friendly neighborhood Spider-Man",
//                               thumbnail: Thumbnail(path: "https://assetsio.reedpopcdn.com/amspm-poster-cropped", extension: "jpg")),
//                          
//                          Hero(id: 2,
//                               name: "Iron Man",
//                               description: "Genius. Billionaire. Playboy. Philanthropist.",
//                               thumbnail: Thumbnail(path: "https://t.ctcdn.com.br/PhMSWC4JoezPaXVPDzV12EA0ZOo=/768x432/smart/i759818", extension: "jpeg")),
//                
//                          Hero(id: 3,
//                               name: "Ant Man",
//                               description: "Genius. Bla bla bla.",
//                               thumbnail: Thumbnail(path: "https://static1.squarespace.com/static/52a86cb9e4b098a46d38a18c/57220cbf27d4bd9f8070f9f6/63efe7044813e64d9860348d/1676666800218/ant-man-fan-art-tony-santiago", extension: "jpg"))]
    
    func fetchHeroes(nameStartsWith: String, completion: @escaping ([Hero], Error?) -> Void) {
        completion(heroes, nil)
    }
    
    func saveHeroes(_ heroes: [Hero], completion: @escaping (Error?) -> Void) {
        self.heroes = heroes
    }
}
