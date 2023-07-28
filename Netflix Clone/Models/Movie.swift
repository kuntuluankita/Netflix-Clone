//
//  Movie.swift
//  Netflix Clone
//
//  Created by K Praveen Kumar on 26/07/23.
//

import Foundation

struct TrendingMoviesResponse: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    let adult: Bool = false
    let backdropPath: String?
    let id: Int
    let title, originalLanguage, originalTitle, overview: String?
    let posterPath, mediaType: String?
    let popularity: Double
    let releaseDate: String?
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case id, title
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case popularity
        case releaseDate = "release_date"
        case voteAverage = "vote_average"

    }
}


