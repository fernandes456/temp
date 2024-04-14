//
//  FavoriteHeroViewModel.swift
//  MarvelCO
//
//  Created by Geraldo Fernandes on 07/04/24.
//

import Foundation

final class FavoriteHeroViewModel: HeroViewModelProtocol {
    private let favoriteManager: FavoriteManager
    
    init(favoriteManager: FavoriteManager) {
        self.favoriteManager = favoriteManager
        NotificationCenter.default.addObserver(self, selector: #selector(favoritesUpdated), name: .didUpdateFavorites, object: nil)
    }
    
    private var heroes: [Hero] = [] {
        didSet {
            self.reloadCollectionViewClosure?()
        }
    }
    
    var heroesToDisplay: [Hero] {
        favoriteManager.favoriteHeroes
    }

    var reloadCollectionViewClosure: (() -> Void)?
    
    var showErrorView: ((String) -> Void)?
    
    func fetchHeroes(nameStartsWith: String = "") {
        self.favoriteManager.fetchFavoriteHeroes { [weak self] heroes in
            self?.heroes = heroes
            if heroes.count == 0 {
                self?.showErrorView?("Não há heróis")
            }
        }
    }
    
    func isFavorite(_ hero: Hero) -> Bool {
        return favoriteManager.isFavorite(hero)
    }
    
    func toggleFavorite(hero: Hero) {
        favoriteManager.toggleFavorite(hero: hero)
    }
    
    func shouldDisplaySerachBar() -> Bool {
        return false
    }
    
    @objc func favoritesUpdated() {
        self.favoriteManager.fetchFavoriteHeroes { [weak self] heroes in
            self?.heroes = heroes
            if heroes.count == 0 {
                self?.showErrorView?("Não há heróis")
            } else {
                self?.reloadCollectionViewClosure?()
            }
        }
    }
}
