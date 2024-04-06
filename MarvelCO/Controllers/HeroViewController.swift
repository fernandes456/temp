//
//  HomeViewController.swift
//  MarvelCO
//
//  Created by Geraldo Fernandes on 06/04/24.
//

import UIKit

class HeroViewController: UIViewController {

    fileprivate var viewModel: HeroViewModel = HeroViewModel() // [gfsf] injetar isso
    private lazy var heroView: HeroView = {
        let heroView = HeroView()
        heroView.setDataSourceDelegate(dataSourceDelegate: self)
        return heroView
    }()
    
    override func loadView() {
        super.loadView()
        self.view = heroView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.reloadCollectionViewClosure = { [weak self] in
            DispatchQueue.main.async {
                self?.heroView.reloadData()
            }
        }

        viewModel.fetchHeroes()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HeroViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.heroes.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeroCell", for: indexPath) as? HeroCell else {
            return UICollectionViewCell()
        }
        let character = viewModel.heroes[indexPath.item]
        cell.configure(with: character)
        return cell
    }
}
