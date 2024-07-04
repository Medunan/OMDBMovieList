//
//  OmdbModel.swift
//  GetMoviesUIKit
//
//  Created by Medunan Skyraan  on 04/07/24.
//

import Foundation

struct St_SearchMovieModel: Codable {
    var Search: [St_Movie]
    var totalResults: String
    var Response: String
}

struct St_Movie: Codable, Hashable {
    var Title: String
    var Year: String
    var imdbID: String
    var `Type`: String
    var Poster: String
}
