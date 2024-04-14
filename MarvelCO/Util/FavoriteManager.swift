//
//  FavoriteManager.swift
//  MarvelCO
//
//  Created by Geraldo Fernandes on 08/04/24.
//

import Foundation

class FavoriteManager: FetchProtocol {
    
    private let repository: FavoriteProtocol
    
    init(repository: FavoriteProtocol = CoreDataRepository()) {
        self.repository = repository
    }
    
    var favoriteHeroes = [Hero]()
    
    func fetchHeroes(nameStartsWith: String, completion: @escaping ([Hero], Error?) -> Void) {
        self.repository.fetchFavorite { [weak self] heroes in
            self?.favoriteHeroes = heroes
            completion(heroes, nil)
        }
    }
    
    func fetchFavoriteHeroes(completion: @escaping (([Hero]) -> Void)) {
        
        self.repository.fetchFavorite { [weak self] heroes in
            self?.favoriteHeroes = heroes
            completion(heroes)
        }
        
//        self.localDataRepository.fetchHeroes { [weak self] heroes, error in
//            if let error = error {
//                self?.favoriteHeroes = []
//                return
//            }
//            
//            self?.favoriteHeroes = heroes
//        }
    }
    
    func isFavorite(_ hero: Hero) -> Bool {
//        return favoriteHeroes.contains { $0.id == hero.id }
        return (repository.findHero(with: hero.id) != nil)
    }

    func toggleFavorite(hero: Hero) {

        if let favoriteHero = repository.findHero(with: hero.id) {
            repository.removeFromFavorite(hero: favoriteHero)
        } else {
            repository.addToFavorite(hero: hero)
        }
        
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
