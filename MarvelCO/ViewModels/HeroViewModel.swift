//
//  HomeViewModel.swift
//  MarvelCO
//
//  Created by Geraldo Fernandes on 06/04/24.
//

import Foundation

final class HeroViewModel {
    
    private let listRepository: FetchProtocol
    private let favoriteManager: FavoriteManager
    private let isFavoriteScreen: Bool
    var cellToUpdate: IndexPath? = nil
    
    init(listRepository: RepositoryProtocol,
         favoriteManager: FavoriteManager,
         isFavoriteScreen: Bool = false) {
        self.listRepository = listRepository
        self.favoriteManager = favoriteManager
        self.isFavoriteScreen = isFavoriteScreen
        NotificationCenter.default.addObserver(self, selector: #selector(favoritesUpdated), name: .didUpdateFavorites, object: nil)
    }
    
    private var heroes: [Hero] = [] {
        didSet {
            self.reloadCollectionViewClosure?()
        }
    }
    
    var heroesToDisplay: [Hero] {
        isFavoriteScreen ? favoriteManager.favoriteHeroes : heroes
    }

    var reloadCollectionViewClosure: (() -> Void)?
    
    var reloadCellClosure: ((IndexPath) -> Void)?
    
    var deleteCellClosure: ((IndexPath) -> Void)?
    
    func fetchHeroes() {
        
        self.listRepository.fetchHeroes(completion: { [weak self] heroes, error in
            if let error = error {
                print("[gfsf] deu erro: \(error)")
                return
            }
            self?.heroes = heroes
        })
    }
    
    func isFavorite(_ hero: Hero) -> Bool {
        return favoriteManager.isFavorite(hero)
    }
    
    func toggleFavorite(_ isFavorite: Bool, hero: Hero) {
        favoriteManager.toggleFavorite(hero: hero)
//        if let cellToUpdate = cellToUpdate {
//            self.reloadCellClosure?(cellToUpdate)
//            self.cellToUpdate = nil
//        }
    }
    
    @objc func favoritesUpdated() {
        
//        if let cellToUpdate = cellToUpdate, isFavoriteScreen == false {
//            self.reloadCellClosure?(cellToUpdate)
//            self.cellToUpdate = nil
//        } else {
//            self.reloadCollectionViewClosure?()
//        }
        
        if isFavoriteScreen {
            self.reloadCollectionViewClosure?()
        } else if let cellToUpdate = cellToUpdate {
            self.reloadCellClosure?(cellToUpdate)
        }
    }
}
