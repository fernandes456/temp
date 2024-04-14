//
//  TabBarController.swift
//  MarvelCO
//
//  Created by Geraldo Fernandes on 08/04/24.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let networkRepository = NetworkRepository()
        let coredataRepository = CoreDataRepository()
        let favoriteManager = FavoriteManager(repository: coredataRepository)
        
        let viewModel = HeroViewModel(listRepository: networkRepository, favoriteManager: favoriteManager)
        let allHeroesViewController = HeroViewController(viewModel: viewModel)
        allHeroesViewController.tabBarItem = UITabBarItem(title: "Todos", image: UIImage(systemName: "smallcircle.circle.fill"), tag: 0)
        let router = HeroDetailRouter(viewController: allHeroesViewController, favoriteManager: favoriteManager)
        allHeroesViewController.router = router
        
        let favoriteViewModel = FavoriteHeroViewModel(favoriteManager: favoriteManager)
        let favoriteHeroesHeroesViewController = HeroViewController(viewModel: favoriteViewModel)
        favoriteHeroesHeroesViewController.tabBarItem = UITabBarItem(title: "Favoritos", image: UIImage(systemName: "star.fill"), tag: 1)
        let favoriteRouter = HeroDetailRouter(viewController: favoriteHeroesHeroesViewController, favoriteManager: favoriteManager)
        favoriteHeroesHeroesViewController.router = favoriteRouter
        
        let controllers = [allHeroesViewController, favoriteHeroesHeroesViewController].map {
            UINavigationController(rootViewController: $0)
        }
        
        self.viewControllers = controllers
    }
}

