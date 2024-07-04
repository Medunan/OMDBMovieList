//
//  OmdbModel.swift
//  GetMoviesUIKit
//
//  Created by Medunan Skyraan  on 04/07/24.
//

import Foundation

struct St_SearchErrorModel: Codable {
    var Response: String
    var Error: String
}

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


struct St_MovieInfo: Codable {
    let Title: String
    let Year: String
    let Rated: String
    let Released: String
    let Runtime: String
    let Genre: String
    let Director: String
    let Writer: String
    let Actors: String
    let Plot: String
    let Language: String
    let Country: String
    let Awards: String
    let Poster: String
    let Ratings: [Rating]
    let Metascore: String
    let imdbRating: String
    let imdbVotes: String
    let imdbID: String
    let `Type`: String
    let DVD: String?
    let BoxOffice: String
    let Production: String?
    let Website: String?
    let Response: String
}

struct Rating: Codable {
    let Source: String
    let Value: String
}
