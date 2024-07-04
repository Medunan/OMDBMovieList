//
//  SearchResultCell.swift
//  GetMoviesUIKit
//
//  Created by Medunan Skyraan  on 04/07/24.
//

import Foundation
import UIKit


protocol MovieCollectionViewCellDelegate: AnyObject {
    func didTapFavoriteButton(for movie: St_Movie)
}

class MovieCollectionViewCell: UICollectionViewCell {
    static let reuseID = "MovieCell"

    let posterImageView = OBImageCache(frame: .zero)
    let titleLabel = UILabel()
    let releaseDateLabel = UILabel()
    let favoriteButton = UIButton()
    
    weak var delegate: MovieCollectionViewCellDelegate?
    private var movie: St_Movie?

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(movie: St_Movie) {
        self.movie = movie
        titleLabel.text = movie.Title
        releaseDateLabel.text = movie.Year
        posterImageView.downloadImage(from: movie.Poster)
    }
    
    @objc func favoriteButtonAction() {
        guard let movie = movie else { return }
               delegate?.didTapFavoriteButton(for: movie)
    }

    private func configure() {
        
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        titleLabel.minimumScaleFactor = 0.6
        titleLabel.numberOfLines = 2
        titleLabel.adjustsFontSizeToFitWidth = true

        releaseDateLabel.font = .systemFont(ofSize: 15)
        
        let heartImage = UIImage(systemName: "heart.fill")
        favoriteButton.setImage(heartImage, for: .normal)
        
        self.favoriteButton.addTarget(self, action: #selector(favoriteButtonAction), for: .touchUpInside)
        
        addSubview(posterImageView)
        addSubview(titleLabel)
        addSubview(releaseDateLabel)
        addSubview(favoriteButton)

        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        releaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false

        let padding: CGFloat = 8

        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            posterImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            posterImageView.heightAnchor.constraint(equalTo: posterImageView.widthAnchor),

            titleLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),

            releaseDateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            releaseDateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            releaseDateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            releaseDateLabel.heightAnchor.constraint(equalToConstant: 20),

            favoriteButton.topAnchor.constraint(equalTo: releaseDateLabel.topAnchor, constant: 0),
            favoriteButton.trailingAnchor.constraint(equalTo: posterImageView.trailingAnchor),
            favoriteButton.heightAnchor.constraint(equalToConstant: 20),
            favoriteButton.widthAnchor.constraint(equalToConstant: 20)
        ])
    }
}
