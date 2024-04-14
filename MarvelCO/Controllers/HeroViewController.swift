//
//  HomeViewController.swift
//  MarvelCO
//
//  Created by Geraldo Fernandes on 06/04/24.
//

import UIKit

class HeroViewController: UIViewController {

    fileprivate var viewModel: HeroViewModel
    var router: HeroDetailRouter?
    private lazy var heroView: HeroView = {
        let heroView = HeroView()
        heroView.setDataSourceDelegate(dataSourceDelegate: self)
        heroView.delegate = self
        return heroView
    }()
    
    private lazy var errorView: ErrorView = {
        let view = ErrorView()
        view.isHidden = true
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(viewModel: HeroViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view = heroView
        
        errorView.addToSuperView(heroView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        heroView.showSearchBar(viewModel.shouldDisplaySerachBar())

        viewModel.reloadCollectionViewClosure = { [weak self] in
            DispatchQueue.main.async {
                self?.errorView.isHidden = true
                self?.heroView.reloadData()
            }
        }
        
        viewModel.reloadCellClosure = {[weak self] indexPath in
            DispatchQueue.main.async {
                self?.heroView.reloadCell(indexPath: indexPath)
            }
        }
        
        viewModel.showErrorView = {[weak self] message in
            DispatchQueue.main.async {
                self?.errorView.isHidden = false
                self?.errorView.showMessage(message)
            }
        }

        viewModel.fetchHeroes()
    }
}

extension HeroViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.heroesToDisplay.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeroCell", for: indexPath) as? HeroCell else {
            return UICollectionViewCell()
        }
        let hero = viewModel.heroesToDisplay[indexPath.item]
        cell.configure(with: hero)
        cell.isFavorite = viewModel.isFavorite(hero)
        
        cell.didToggleFavorite = { [weak self, weak cell] isFavorite in
            guard let self = self,
                  let cell = cell,
                  let indexPath = collectionView.indexPath(for: cell)
            else { return }
            
            self.viewModel.cellToUpdate = indexPath
            self.viewModel.toggleFavorite(isFavorite,
                                    hero: self.viewModel.heroesToDisplay[indexPath.row])
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedHero = viewModel.heroesToDisplay[indexPath.row]
        router?.navigateToHero(with: selectedHero)
    }
}

extension HeroViewController: ErrorViewDelegate {
    func retry() {
        self.viewModel.fetchHeroes()
    }
}


extension HeroViewController: HeroViewDelegate {
    func searchFor(_ text: String?) {
        self.viewModel.fetchHeroes(nameStartsWith: text ?? "")
    }
}
