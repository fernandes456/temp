//
//  HeroDetailsViewController.swift
//  MarvelCO
//
//  Created by Geraldo Fernandes on 06/04/24.
//

import UIKit

final class HeroDetailViewController: UIViewController {

    private let viewModel: HeroDetailViewModel
    private lazy var heroDetailView: HeroDetailView = {
        let heroDetailView = HeroDetailView()
        heroDetailView.delegate = self
        return heroDetailView
    }()
    
    init(viewModel: HeroDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view = heroDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        heroDetailView.configureView(hero: viewModel.hero)
    }
}

extension HeroDetailViewController: HeroDetailViewDelegate {
    func shareImage(_ image: UIImage) {
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)

        present(activityViewController, animated: true, completion: nil)
    }
}
