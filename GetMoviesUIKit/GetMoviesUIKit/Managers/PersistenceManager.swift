//
//  PersistenceManager.swift
//  GetMoviesUIKit
//
//  Created by Medunan Skyraan  on 04/07/24.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

enum PersistenceManager {
    
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let favorites = "favorites"
    }
    
    static func save(movie: [St_Movie]) -> OmdbErrors? {
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(movie)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            return nil
        }
        catch {
            return .unableToFavorite
        }
    }
    
    static func retrieveFavorites(completed: @escaping (Result<[St_Movie], OmdbErrors>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completed(.success([]))
            return
        }
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([St_Movie].self, from: favoritesData)
            completed(.success(favorites))
        }
        catch {
            completed(.failure(.unableToFavorite))
        }
    }
    
    static func updateWith(favorite: St_Movie, actionType: PersistenceActionType, completed: @escaping (OmdbErrors?) -> Void) {
        retrieveFavorites { result in
            switch result {
            case .success(let favorites):
                var retrievedFavorites = favorites
                
                switch actionType {
                case .add:
                    guard !retrievedFavorites.contains(where: { $0.imdbID == favorite.imdbID }) else {
                        completed(.alreadyInFavorites)
                        return
                    }
                    retrievedFavorites.append(favorite)
                    
                case .remove:
                    retrievedFavorites.removeAll { $0.imdbID == favorite.imdbID }
                }
                
                completed(save(movie: retrievedFavorites))
                
            case .failure(let error):
                completed(error)
            }
        }
    }
}
