//
//  NetworkManager.swift
//  GetMoviesUIKit
//
//  Created by Medunan Skyraan  on 04/07/24.
//

import Foundation
import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "https://www.omdbapi.com/?apikey=ff5b7c7c"
    let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func getMovieNames(for movieName: String, page: Int, completed: @escaping (Result<St_SearchMovieModel,OmdbErrors>) -> Void) {
        let endpoint = baseURL + "&type=movie" + "&s=\(movieName)" + "&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidMoviename))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                if let movieInfo = try? decoder.decode(St_SearchMovieModel.self, from: data) {
                    print("Successful response")
                    completed(.success(movieInfo))
                } else if let errorResponse = try? decoder.decode(St_SearchErrorModel.self, from: data) {
                    print("Error response")
                    completed(.failure(.tooManyData))
                } else {
                    print("Unable to decode")
                    completed(.failure(.invalidData))
                }
            }
        }
        task.resume()
    }
    
    func getMovieDetails(for imdbID: String, completed: @escaping (Result<St_MovieInfo,OmdbErrors>) -> Void) {
        let endpoint = baseURL + "&i=\(imdbID)"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidMoviename))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                if let movieDetials = try? decoder.decode(St_MovieInfo.self, from: data) {
                    print("Successful response")
                    completed(.success(movieDetials))
                } else {
                    print("Unable to decode")
                    completed(.failure(.invalidData))
                }
            }
        }
        task.resume()
    }
    
    
}
