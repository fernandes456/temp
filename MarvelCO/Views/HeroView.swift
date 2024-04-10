//
//  HomeView.swift
//  MarvelCO
//
//  Created by Geraldo Fernandes on 06/04/24.
//

import UIKit

class HeroView: UIView {
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 150, height: 300)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(HeroCell.self, forCellWithReuseIdentifier: "HeroCell")
        
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    
    private func setupViews() {
        addSubViews()
        addConstraints()
    }
    
    private func addSubViews() {
        addSubview(collectionView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setDataSourceDelegate(dataSourceDelegate: UICollectionViewDataSource & UICollectionViewDelegate) {
        collectionView.dataSource = dataSourceDelegate
        collectionView.delegate = dataSourceDelegate
        collectionView.reloadData()
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
    
    func reloadCell(indexPath: IndexPath) {
        collectionView.reloadItems(at: [indexPath])
    }
    
    func deleteCell(at indexPath: IndexPath) {
        collectionView.deleteItems(at: [indexPath])
    }
}
