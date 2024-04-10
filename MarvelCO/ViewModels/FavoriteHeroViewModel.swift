//
//  FavoriteHeroViewModel.swift
//  MarvelCO
//
//  Created by Geraldo Fernandes on 07/04/24.
//

import Foundation

final class FavoriteHeroViewModel {
    private let localDataRepository: RepositoryProtocol
    private let favotiteManager: FavoriteManager
    
    init(localDataRepository: RepositoryProtocol) {
        self.localDataRepository = localDataRepository
        self.favotiteManager = FavoriteManager(localDataRepository: localDataRepository)
    }
    
    var heroes: [Hero] = [] {
        didSet {
            self.reloadCollectionViewClosure?()
        }
    }

    var reloadCollectionViewClosure: (() -> Void)?
    
    func fetchHeroes() {
        self.localDataRepository.fetchHeroes { [weak self] heroes, error in
            if let error = error {
                print("[gfsf] deu erro: \(error)")
                return
            }
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
