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
                let movieInfo = try decoder.decode(St_SearchMovieModel.self, from: data)
                print(movieInfo)
                completed(.success(movieInfo))
            }
            catch  {
                completed(.failure(.invalidData))
            }
                     
        }
        task.resume()
    }
}
