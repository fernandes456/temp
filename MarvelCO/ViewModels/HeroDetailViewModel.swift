//
//  HeroDetailViewModel.swift
//  MarvelCO
//
//  Created by Geraldo Fernandes on 06/04/24.
//

import Foundation

final class HeroDetailViewModel {
    let hero: Hero
    private let favoriteManager: FavoriteManager
    
    init(hero: Hero, favoriteManager: FavoriteManager) {
        self.hero = hero
        self.favoriteManager = favoriteManager
    }
    
    var name: String {
        hero.name
    }
    
    var description: String {
        hero.description
    }
    
    var imageUrl: String {
        hero.thumbnail.urlString
    }
    var isFavorite: Bool {
        favoriteManager.isFavorite(hero)
    }
    
    func toogleFavorite() {
        favoriteManager.toggleFavorite(hero: hero)
    }
}
