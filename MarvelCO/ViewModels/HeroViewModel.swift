//
//  HomeViewModel.swift
//  MarvelCO
//
//  Created by Geraldo Fernandes on 06/04/24.
//

import Foundation

protocol HeroViewModelProtocol: AnyObject {
    var heroesToDisplay: [Hero] { get }
    var reloadCollectionViewClosure: (() -> Void)? { get set }
    var showErrorView: ((String) -> Void)? { get set }
    
    func fetchHeroes(nameStartsWith: String)
    
    func isFavorite(_ hero: Hero) -> Bool
    func toggleFavorite(hero: Hero)
    func shouldDisplaySerachBar() -> Bool
}

extension HeroViewModelProtocol {
    func fetchHeroes() {
        fetchHeroes(nameStartsWith: "")
    }
}

final class HeroViewModel: HeroViewModelProtocol {
    
    private let listRepository: FetchProtocol
    private let favoriteManager: FavoriteManager
    
    init(listRepository: FetchProtocol,
         favoriteManager: FavoriteManager) {
        self.listRepository = listRepository
        self.favoriteManager = favoriteManager
        NotificationCenter.default.addObserver(self, selector: #selector(favoritesUpdated), name: .didUpdateFavorites, object: nil)
    }
    
    private var heroes: [Hero] = [] {
        didSet {
            if heroes.count == 0 {
                self.showErrorView?("Lista vazia")
            } else {
                self.reloadCollectionViewClosure?()
            }
        }
    }
    
    var heroesToDisplay: [Hero] {
        heroes
    }

    var reloadCollectionViewClosure: (() -> Void)?
    
    var showErrorView: ((String) -> Void)?
    
    func fetchHeroes(nameStartsWith: String = "") {
        self.listRepository.fetchHeroes(nameStartsWith: nameStartsWith, completion: { [weak self] heroes, error in
            if let error = error {
                print("Erro: \(error)")
                self?.showErrorView?("Ocorreu um erro")
                return
            }
            self?.heroes = heroes
        })
    }
    
    func isFavorite(_ hero: Hero) -> Bool {
        return favoriteManager.isFavorite(hero)
    }
    
    func toggleFavorite(hero: Hero) {
        favoriteManager.toggleFavorite(hero: hero)
    }
    
    func shouldDisplaySerachBar() -> Bool {
        return true
    }
    
    @objc func favoritesUpdated() {
        self.reloadCollectionViewClosure?()
    }
}
