//
//  HomeView.swift
//  MarvelCO
//
//  Created by Geraldo Fernandes on 06/04/24.
//

import UIKit

protocol HeroViewDelegate: AnyObject {
    func searchFor(_ text: String?)
}

class HeroView: UIView {
    
    weak var delegate: HeroViewDelegate?
    
    private(set) lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 150, height: 300)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(HeroCell.self, forCellWithReuseIdentifier: "HeroCell")
        
        return collectionView
    }()
    
    private lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .darkGray
        textField.placeholder = "Buscar"
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
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
        backgroundColor = .white
        addSubViews()
        addConstraints()
    }
    
    private func addSubViews() {
        addSubview(collectionView)
        addSubview(searchTextField)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            searchTextField.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            searchTextField.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            searchTextField.heightAnchor.constraint(equalToConstant: 44),
//            searchTextField.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
//            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor),
            collectionView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
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
    
    func showSearchBar(_ show: Bool) {
        searchTextField.isHidden = !show
    }
}

extension HeroView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.searchFor(searchTextField.text)
        return true
    }
}
