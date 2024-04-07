//
//  HeroDetailsView.swift
//  MarvelCO
//
//  Created by Geraldo Fernandes on 06/04/24.
//

import UIKit

protocol HeroDetailViewDelegate: NSObject {
    func shareImage(_ image: UIImage)
}

final class HeroDetailView: UIView {

    weak var delegate: HeroDetailViewDelegate?
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.center = self.center
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    private lazy var favoriteButton: UIButton = {
        let button = UIButton(type: .system)
//        let imageName = isFavorite ? "heart.fill" : "heart"
        button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(toggleFavorite), for: .touchUpInside)
        return button
    }()
    
    private lazy var shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(sharedTapped), for: .touchUpInside)
        return button
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
        self.backgroundColor = .white
        addSubViews()
        addConstraints()
    }
    
    private func addSubViews() {
        self.addSubview(nameLabel)
        self.addSubview(descriptionLabel)
        self.addSubview(imageView)
//        self.addSubview(activityIndicator)
        self.addSubview(favoriteButton)
        self.addSubview(shareButton)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            
//            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            favoriteButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            favoriteButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            favoriteButton.widthAnchor.constraint(equalToConstant: 44),
            favoriteButton.heightAnchor.constraint(equalToConstant: 44),
            
            shareButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            shareButton.topAnchor.constraint(equalTo: favoriteButton.bottomAnchor, constant: 10),
            shareButton.widthAnchor.constraint(equalToConstant: 44),
            shareButton.heightAnchor.constraint(equalToConstant: 44),
        ])
    }
    
    @objc private func toggleFavorite() {
//        isFavorite.toggle()
        
        // [gfsf] explicar isso aqui
        let animation = CAKeyframeAnimation(keyPath: "transform.scale")
        animation.values = [1.0, 1.2, 1.0]
        animation.keyTimes = [0, 0.5, 1]
        animation.duration = 0.3
        favoriteButton.layer.add(animation, forKey: nil)
        
//        didToggleFavorite?(isFavorite)
    }
    
    @objc private func sharedTapped() {
        if let image = imageView.image {
            self.delegate?.shareImage(image)
        }
    }
    
    func configureView(hero: Hero) {
        imageView.loadImage(fromURL: hero.thumbnail.urlString) {
            
        }
        
        nameLabel.text = hero.name
        descriptionLabel.text = hero.description
    }
}
