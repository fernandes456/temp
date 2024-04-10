//
//  HeroCell.swift
//  MarvelCO
//
//  Created by Geraldo Fernandes on 06/04/24.
//

import UIKit

class HeroCell: UICollectionViewCell {
    
    private var task: URLSessionDataTask? = nil
    
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
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.center = contentView.center
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    private lazy var favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(toggleFavorite), for: .touchUpInside)
        return button
    }()
    
    var isFavorite: Bool = false {
        didSet {
            updateFavoriteButton()
        }
    }
    
    var didToggleFavorite: ((Bool) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.backgroundColor = .lightGray
        addSubViews()
        addConstraints()
    }
    
    private func addSubViews() {
        self.addSubview(nameLabel)
        self.addSubview(descriptionLabel)
        self.addSubview(imageView)
        self.addSubview(activityIndicator)
        self.addSubview(favoriteButton)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            favoriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            favoriteButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            favoriteButton.widthAnchor.constraint(equalToConstant: 22),
            favoriteButton.heightAnchor.constraint(equalToConstant: 22)
        ])
    }
    
    private func updateFavoriteButton() {
        let imageName = isFavorite ? "heart.fill" : "heart"
        favoriteButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    @objc private func toggleFavorite() {
        isFavorite.toggle()
        
        // [gfsf] explicar isso aqui
        let animation = CAKeyframeAnimation(keyPath: "transform.scale")
        animation.values = [1.0, 1.2, 1.0]
        animation.keyTimes = [0, 0.5, 1]
        animation.duration = 0.3
        favoriteButton.layer.add(animation, forKey: nil)
        
        didToggleFavorite?(isFavorite)
    }
    
    func configure(with hero: Hero) {
        updateFavoriteButton()
        nameLabel.text = hero.name
        descriptionLabel.text = hero.name
        self.activityIndicator.startAnimating()
        task = imageView.loadImage(fromURL: hero.thumbnail.urlString) { [weak self] in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        task?.cancel()
        nameLabel.text = nil
        descriptionLabel.text = nil
        imageView.image = nil
        
        activityIndicator.stopAnimating()
    }
}
