//
//  HeroDetailRouter.swift
//  MarvelCO
//
//  Created by Geraldo Fernandes on 06/04/24.
//

import UIKit

final class HeroDetailRouter {
    weak var viewController: UIViewController?
    private let favoriteManager: FavoriteManager
    
    init(viewController: UIViewController? = nil,
         favoriteManager: FavoriteManager) {
        self.viewController = viewController
        self.favoriteManager = favoriteManager
    }
    
    func navigateToHero(with hero: Hero) {
        let viewModel = HeroDetailViewModel(hero: hero, favoriteManager: favoriteManager)
        let detailViewController = HeroDetailViewController(viewModel: viewModel)
        viewController?.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
