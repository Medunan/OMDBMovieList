//
//  ViewController.swift
//  GetMoviesUIKit
//
//  Created by Medunan Skyraan  on 03/07/24.
//

import UIKit

class MainViewController: UIViewController, UITextFieldDelegate {

    let movieNameTextField = OBTextField()
    let searchButton = OBButton(backgroundColor: .systemGray, title: "Search")
    let titleTextView = OBTitleLabel(textAlignment: .center, fontSize: 60)
    
    var isMovieNameEntered: Bool { return
        !movieNameTextField.text!.isEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureTitleView()
        configureTextField()
        configureSearchButton()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @objc func pushMovieListVC() {
        guard isMovieNameEntered else {
            print("Movie Name is not entered")
            return
        }
        
        let searchResultVC = SearchResultVC()
        searchResultVC.movieName = movieNameTextField.text
        searchResultVC.title = movieNameTextField.text
        navigationController?.pushViewController(searchResultVC, animated: true)
    }
    
    func configureTitleView() {
        self.titleTextView.text = "OMDB"
        
        view.addSubview(titleTextView)
        titleTextView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 80),
            titleTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    func configureTextField() {
        view.addSubview(movieNameTextField)
        movieNameTextField.delegate = self
        
        NSLayoutConstraint.activate([
            movieNameTextField.topAnchor.constraint(equalTo: titleTextView.topAnchor, constant: 100),
            movieNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            movieNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            movieNameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureSearchButton() {
        view.addSubview(searchButton)
        searchButton.addTarget(self, action: #selector(pushMovieListVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            searchButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            searchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 50),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            searchButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

