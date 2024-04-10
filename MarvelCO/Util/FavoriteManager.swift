//
//  FavoriteManager.swift
//  MarvelCO
//
//  Created by Geraldo Fernandes on 08/04/24.
//

import Foundation

class FavoriteManager {
    private let localDataRepository: RepositoryProtocol
    
    init(localDataRepository: RepositoryProtocol) {
        self.localDataRepository = localDataRepository
    }
    
    var favoriteHeroes = [Hero]()
    
    func fetchFavoriteHeroes() {
        self.localDataRepository.fetchHeroes { [weak self] heroes, error in
            if let error = error {
                self?.favoriteHeroes = []
                return
            }
            
            self?.favoriteHeroes = heroes
        }
    }
    
    func isFavorite(_ hero: Hero) -> Bool {
        return favoriteHeroes.contains { $0.id == hero.id }
    }

    func toggleFavorite(hero: Hero) {
        if let index = favoriteHeroes.firstIndex(where: { $0.id == hero.id }) {
            favoriteHeroes.remove(at: index)
        } else {
            favoriteHeroes.append(hero)
        }
        
        localDataRepository.saveHeroes(favoriteHeroes) { _ in }
        
        NotificationCenter.default.post(name: .didUpdateFavorites, object: hero)
    }

//    func toggleFavorite(_ isFavorite: Bool, hero: Hero) {
//        if isFavorite {
//            favoriteHeroes.append(hero)
//        } else {
//            
//            if let index = favoriteHeroes.firstIndex(where: { $0.id == hero.id }) {
//                favoriteHeroes.remove(at: index)
//            }
//        }
//        
//        localDataRepository.saveHeroes(favoriteHeroes) { _ in }
//        
//        NotificationCenter.default.post(name: .didUpdateFavorites, object: hero)
//    }
}
