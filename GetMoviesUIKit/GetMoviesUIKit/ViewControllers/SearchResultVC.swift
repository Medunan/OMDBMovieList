//
//  SearchResultVC.swift
//  GetMoviesUIKit
//
//  Created by Medunan Skyraan  on 04/07/24.
//

import UIKit

protocol SearchResultVCDelegate: AnyObject {
    func didRequestSearch(for movieName: String)
}

class SearchResultVC: UIViewController {
    
    enum Section {  // hashable - diffable data source
        case main
    }
    
    
    var movieName: String!
    var results: [St_Movie] = []
    var filteredResults: [St_Movie] = []
    var page = 1
    var hasMoreResults = true
    var isSearching = false
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section,St_Movie>!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
        configureCollectionView()
        getSearchResults(movieName: movieName, page: page)
        configureDataSource()
        configureViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds,
                                          collectionViewLayout: UIHelper.createColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.reuseID)
    }
    
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate   = self
        searchController.searchBar.placeholder = "Search for Movies"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController        = searchController
    }
    
    
    func getSearchResults(movieName: String, page: Int) {
        showLoadingView()
        NetworkManager.shared.getMovieNames(for: movieName, page: page) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let results):
                if Int(results.totalResults) ?? 9 < 10 { self.hasMoreResults = false }
                self.results.append(contentsOf: results.Search)
                
                if self.results.isEmpty {
                    let message = "InValid Search"
                    DispatchQueue.main.async {self.showEmptyStateView(with: message, in: self.view)}
                    return
                }
                self.updateData(on: self.results)
                
            case .failure(let error):
                if error == .tooManyData {
                    DispatchQueue.main.async {
                        self.showEmptyStateView(with: "Too Many Data!!", in: self.view)
                    }
                } else {
                    DispatchQueue.main.async {
                        self.showEmptyStateView(with: error.localizedDescription, in: self.view)
                    }
                }
                print(error)
            }
        }
        
    }
    
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, St_Movie>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, result) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.reuseID, for: indexPath) as! MovieCollectionViewCell
            cell.set(movie: result)
            cell.delegate = self
            return cell
        })
    }
    
    func updateData(on followers: [St_Movie]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, St_Movie>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
}

extension SearchResultVC: MovieCollectionViewCellDelegate {
    func didTapFavoriteButton(for movie: St_Movie) {
        showLoadingView()
        NetworkManager.shared.getMovieDetails(for: movie.imdbID) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let detail):
                let favorite = St_Movie(Title: detail.Title, Year: detail.Year, imdbID: detail.imdbID, Type: detail.Type, Poster: detail.Poster)
                
                PersistenceManager.updateWith(favorite: favorite, actionType: .add) { [weak self] error in
                    guard let self = self else { return  }
                    guard let error = error else {
                        self.presentAlertMainThread(title: "Success!", message: "You have successfully favorited this Movie!", buttonTitle: "Ok")
                        return
                    }
                    self.presentAlertMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
                }
                
            case .failure(let error):
                self.presentAlertMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
}

extension SearchResultVC: SearchResultVCDelegate {
    func didRequestSearch(for movieName: String) {
        self.movieName = movieName
        title = movieName
        page = 1
        results.removeAll()
        filteredResults.removeAll()
        collectionView.setContentOffset(.zero, animated: true)
        getSearchResults(movieName: movieName, page: page)
    }
    
    
}

extension SearchResultVC: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        isSearching = true
        filteredResults = results.filter({ $0.Title.lowercased().contains(filter.lowercased())})
        updateData(on: filteredResults)
    }
    
    
}


extension SearchResultVC: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY         = scrollView.contentOffset.y  // how for we scroll down
        let contentHeight   = scrollView.contentSize.height //10 followers height points
        let height          = scrollView.frame.size.height // height in points of the target phone
        
        if offsetY > contentHeight - height {
            guard hasMoreResults else { return }
            page += 1
            getSearchResults(movieName: movieName, page: page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = isSearching ? filteredResults : results
        let selectedMovie = activeArray[indexPath.item]
        
        let movieDetailVC = MovieDetailView()
        movieDetailVC.title = selectedMovie.Title
        movieDetailVC.movie = selectedMovie
        
        if let navigationController = self.navigationController {
            navigationController.pushViewController(movieDetailVC, animated: true)
        } else {
            print("view controller is not embedded in a UINavigationController")
        }
    }
}
