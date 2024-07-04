//
//  MovieDetailView.swift
//  GetMoviesUIKit
//
//  Created by Medunan Skyraan  on 04/07/24.
//

import UIKit

class MovieDetailView: UIViewController {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    let posterImageView = OBImageCache(frame: .zero)
    let descriptionLabel = UILabel()
    let genreLabel = UILabel()
    let ratingLabel = UILabel()
    var directorLabel = UILabel()
    let actorsLabel = UILabel()
    let awardLabel = UILabel()
    
    var director = OBTitleLabel(textAlignment: .left, fontSize: 20)
    var actors = OBTitleLabel(textAlignment: .left, fontSize: 20)
    var award = OBTitleLabel(textAlignment: .left, fontSize: 20)
    var plot = OBTitleLabel(textAlignment: .left, fontSize: 20)
    var type = OBTitleLabel(textAlignment: .left, fontSize: 20)
    var imdb = OBTitleLabel(textAlignment: .left, fontSize: 20)
    
    var movie: St_Movie?
    var movieInfo: St_MovieInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        self.getMovieInfo(imdbID: movie!.imdbID)
    }
    
    func setupViews() {
        view.backgroundColor = .systemBackground
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        directorLabel.translatesAutoresizingMaskIntoConstraints = false
        director.translatesAutoresizingMaskIntoConstraints = false
        actorsLabel.translatesAutoresizingMaskIntoConstraints = false
        actors.translatesAutoresizingMaskIntoConstraints = false
        awardLabel.translatesAutoresizingMaskIntoConstraints = false
        award.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        plot.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        type.translatesAutoresizingMaskIntoConstraints = false
        genreLabel.translatesAutoresizingMaskIntoConstraints = false
        imdb.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(posterImageView)
        contentView.addSubview(director)
        contentView.addSubview(directorLabel)
        contentView.addSubview(actors)
        contentView.addSubview(actorsLabel)
        contentView.addSubview(award)
        contentView.addSubview(awardLabel)
        contentView.addSubview(plot)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(type)
        contentView.addSubview(genreLabel)
        contentView.addSubview(imdb)
        contentView.addSubview(ratingLabel)
        
        director.text = "Director:"
        actors.text = "Cast:"
        award.text = "Award:"
        plot.text = "Plot:"
        type.text = "Genre:"
        imdb.text = "IMDB Rating:"
        
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        
        genreLabel.numberOfLines = 0
        genreLabel.font = UIFont.systemFont(ofSize: 16)
        
        ratingLabel.numberOfLines = 0
        ratingLabel.font = UIFont.systemFont(ofSize: 16)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            posterImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            posterImageView.widthAnchor.constraint(equalToConstant: 200),
            posterImageView.heightAnchor.constraint(equalToConstant: 300),
            
            director.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 20),
            director.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            directorLabel.topAnchor.constraint(equalTo: director.bottomAnchor, constant: 10),
            directorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            directorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            actors.topAnchor.constraint(equalTo: directorLabel.bottomAnchor, constant: 20),
            actors.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            actorsLabel.topAnchor.constraint(equalTo: actors.bottomAnchor, constant: 10),
            actorsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            actorsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            award.topAnchor.constraint(equalTo: actorsLabel.bottomAnchor, constant: 20),
            award.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            awardLabel.topAnchor.constraint(equalTo: award.bottomAnchor, constant: 10),
            awardLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            awardLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            plot.topAnchor.constraint(equalTo: awardLabel.bottomAnchor, constant: 20),
            plot.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            descriptionLabel.topAnchor.constraint(equalTo: plot.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            type.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            type.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            genreLabel.topAnchor.constraint(equalTo: type.bottomAnchor, constant: 10),
            genreLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            genreLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            imdb.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: 20),
            imdb.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            ratingLabel.topAnchor.constraint(equalTo: imdb.bottomAnchor, constant:10),
            ratingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            ratingLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            ratingLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    func getMovieInfo(imdbID: String) {
        showLoadingView()
        NetworkManager.shared.getMovieDetails(for: imdbID) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let results):
                
                print(results)
                DispatchQueue.main.async {
                    self.movieInfo = results
                    self.updateUI()
                }
                
            case .failure(let error):
                print(error)
                return
            }
        }
        
    }
    
    func updateUI() {
        self.posterImageView.downloadImage(from: movieInfo?.Poster ?? "")
        self.directorLabel.text = movieInfo?.Director
        self.actorsLabel.text = movieInfo?.Actors
        self.awardLabel.text = movieInfo?.Awards
        self.descriptionLabel.text = movieInfo?.Plot
        self.genreLabel.text = movieInfo?.Genre
        self.ratingLabel.text = movieInfo?.imdbRating
    }
}
