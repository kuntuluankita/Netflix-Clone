//
//  Tv.swift
//  Netflix Clone
//
//  Created by K Praveen Kumar on 28/07/23.
//

import Foundation

struct TrendingTvResponce: Codable {
    let results: [Tv]
}

struct Tv: Codable {
    let adult: Bool
        let backdropPath: String
        let id: Int
        let name: String
        let originalLanguage: String
        let originalName, overview, posterPath: String
        let mediaType: String
        let genreIDS: [Int]
        let popularity: Double
        let firstAirDate: String
        let voteAverage: Double
        let voteCount: Int
        let originCountry: [String]

        enum CodingKeys: String, CodingKey {
            case adult
            case backdropPath = "backdrop_path"
            case id, name
            case originalLanguage = "original_language"
            case originalName = "original_name"
            case overview
            case posterPath = "poster_path"
            case mediaType = "media_type"
            case genreIDS = "genre_ids"
            case popularity
            case firstAirDate = "first_air_date"
            case voteAverage = "vote_average"
            case voteCount = "vote_count"
            case originCountry = "origin_country"
        }
    }





