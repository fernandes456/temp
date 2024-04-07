//
//  HomeViewModel.swift
//  MarvelCO
//
//  Created by Geraldo Fernandes on 06/04/24.
//

import Foundation

final class HeroViewModel {
    var heroes: [Hero] = [] {
        didSet {
            self.reloadCollectionViewClosure?()
        }
    }
    
    var reloadCollectionViewClosure: (() -> Void)?
    
    func fetchHeroes() {
        
        heroes = [Hero(id: 1,
                       name: "Spider-Man",
                       description: "Friendly neighborhood Spider-Man",
                       thumbnail: Thumbnail(path: "https://assetsio.reedpopcdn.com/amspm-poster-cropped", extension: "jpg")),
                  
                  Hero(id: 2,
                       name: "Iron Man",
                       description: "Genius. Billionaire. Playboy. Philanthropist.",
                       thumbnail: Thumbnail(path: "https://t.ctcdn.com.br/PhMSWC4JoezPaXVPDzV12EA0ZOo=/768x432/smart/i759818", extension: "jpeg"))]
        
        //https://t.ctcdn.com.br/PhMSWC4JoezPaXVPDzV12EA0ZOo=/768x432/smart/i759818.jpeg
    }
    
    func isFavorite(_ hero: Hero) -> Bool {
        return false
    }
    
    func favorite(_ favorite: Bool, hero: Hero) {
        
    }
}
