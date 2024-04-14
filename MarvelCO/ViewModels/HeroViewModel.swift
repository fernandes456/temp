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
    
    var showErrorView: ((String) -> Void)?
    
    func fetchHeroes(nameStartsWith: String = "") {
        
        if isFavoriteScreen {
            self.favoriteManager.fetchFavoriteHeroes { [weak self] heroes in
                self?.heroes = heroes
                if heroes.count == 0 {
                    self?.showErrorView?("Não há heróis")
                }
            }
        } else {
            self.listRepository.fetchHeroes(nameStartsWith: nameStartsWith, completion: { [weak self] heroes, error in
                if let error = error {
                    print("[gfsf] deu erro: \(error)")
                    self?.showErrorView?("Ocorreu um erro")
                    return
                }
                self?.heroes = heroes
            })
        }
    }
    
    func isFavorite(_ hero: Hero) -> Bool {
        return favoriteManager.isFavorite(hero)
    }
    
    func toggleFavorite(_ isFavorite: Bool, hero: Hero) {
        favoriteManager.toggleFavorite(hero: hero)
    }
    
    func shouldDisplaySerachBar() -> Bool {
        return !isFavoriteScreen
    }
    
    @objc func favoritesUpdated() {
        if isFavoriteScreen {
            self.favoriteManager.fetchFavoriteHeroes { [weak self] heroes in
                self?.heroes = heroes
                if heroes.count == 0 {
                    self?.showErrorView?("Não há heróis")
                } else {
                    self?.reloadCollectionViewClosure?()
                }
            }
        } else {
            self.reloadCollectionViewClosure?()
        }
    }
}
