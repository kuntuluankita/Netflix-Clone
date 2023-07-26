//
//  APICaller.swift
//  Netflix Clone
//
//  Created by K Praveen Kumar on 25/07/23.
//

import Foundation

struct Constants {
    static let API_Key = "3c3895e1cba7ab9c182d5d7df5b89610"
    static let baseURL =  "https://api.themoviedb.org"
}

enum APIError: Error {
    case failedToGetData
}

class APICaller {
    static let shared = APICaller()
    
    func getTrendingMovies(completion:@escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/all/day?api_key=\(Constants.API_Key)")
        else{return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let  data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TrendingMoviesResponse.self, from:data)
                print(results.results[0].originalTitle)
            }
            catch {
                print(error.localizedDescription)
            }
        }
        
        task.resume()
    }
}




