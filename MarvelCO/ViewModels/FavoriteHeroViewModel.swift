//
//  FavoriteHeroViewModel.swift
//  MarvelCO
//
//  Created by Geraldo Fernandes on 07/04/24.
//

import Foundation

final class FavoriteHeroViewModel {
    private let favotiteManager: FavoriteManager
    
    init() {
        self.favotiteManager = FavoriteManager()
    }
    
    var heroes: [Hero] = [] {
        didSet {
            self.reloadCollectionViewClosure?()
        }
    }

    var reloadCollectionViewClosure: (() -> Void)?
    
    func fetchHeroes() {
        favotiteManager.fetchFavoriteHeroes { [weak self] heroes in
            self?.heroes = heroes
        }
    }
    
    func isFavorite(_ hero: Hero) -> Bool {
        return favotiteManager.isFavorite(hero)
    }
    
    // [gfsf] remover o bool
    func toggleFavorite(_ isFavorite: Bool, hero: Hero) {
        favotiteManager.toggleFavorite(hero: hero)
    }
}
