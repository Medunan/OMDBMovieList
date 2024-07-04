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

class SearchResultVC: UIViewController, UICollectionViewDelegate {
    
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
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
                    print("No Results")
                    return
                }
                self.updateData(on: self.results)
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, St_Movie>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, result) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.reuseID, for: indexPath) as! MovieCollectionViewCell
            cell.set(movie: result)
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
