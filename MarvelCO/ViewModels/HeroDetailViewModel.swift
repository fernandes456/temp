//
//  HeroDetailViewModel.swift
//  MarvelCO
//
//  Created by Geraldo Fernandes on 06/04/24.
//

import Foundation

final class HeroDetailViewModel {
    let hero: Hero
    
    init(hero: Hero) {
        self.hero = hero
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
}
