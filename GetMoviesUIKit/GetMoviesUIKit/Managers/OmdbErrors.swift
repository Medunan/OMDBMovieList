//
//  OmdbErrors.swift
//  GetMoviesUIKit
//
//  Created by Medunan Skyraan  on 04/07/24.
//

import Foundation

enum OmdbErrors: String, Error {
    case invalidMoviename    = "This movie name is invalid. Please try again."
    case unableToComplete   = "Unable to complete your request. Please check your internet connection."
    case invalidResponse    = "Invalid response from the server. Please try again."
    case invalidData        = "The dara received from the server was invalid. Please try again."
    case unableToFavorite   = "There was an error favoritung this Movie Please try again."
    case alreadyInFavorites = "You've already favorited this Movie."
    case tooManyData        = "Too many results."
}
