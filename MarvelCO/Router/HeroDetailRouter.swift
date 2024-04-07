//
//  HeroDetailRouter.swift
//  MarvelCO
//
//  Created by Geraldo Fernandes on 06/04/24.
//

import UIKit

protocol HeroDetailRouting {
    func navigateToHero(with hero: Hero)
}

final class HeroDetailRouter: HeroDetailRouting {
    private weak var viewController: UIViewController?
    
    init(viewController: UIViewController? = nil) {
        self.viewController = viewController
    }
    
    func navigateToHero(with hero: Hero) {
        let viewModel = HeroDetailViewModel(hero: hero)
        let detailViewController = HeroDetailViewController(viewModel: viewModel)
        viewController?.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
