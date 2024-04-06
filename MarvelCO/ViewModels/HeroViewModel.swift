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
                       thumbnail: Thumbnail(path: "https://example.com/spiderman.jpg", extension: "jpg")),
                  
                  Hero(id: 2,
                       name: "Iron Man",
                       description: "Genius. Billionaire. Playboy. Philanthropist.",
                       thumbnail: Thumbnail(path: "https://example.com/ironman.jpg", extension: "jpg"))]
    }
    
    func isFavorite(_ hero: Hero) -> Bool {
        return false
    }
    
    func favorite(_ favorite: Bool, hero: Hero) {
        
    }
}
