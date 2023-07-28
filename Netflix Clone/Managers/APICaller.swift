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
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/movie/day?api_key=\(Constants.API_Key)")
        else{return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let  data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TrendingMoviesResponse.self, from:data)
                completion(.success(results.results))
            }
            catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        
        task.resume()
    }
    
    func getTrandingTvs(completion:@escaping (Result<[Movie], Error>)-> Void) {
        
        guard let  url = URL(string: "\(Constants.baseURL)/3/trending/tv/day?api_key=\(Constants.API_Key)")
        else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let  data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TrendingMoviesResponse.self, from: data)
                completion(.success(results.results))
            }
            catch {
                completion(.failure(APIError.failedToGetData))
            }
        } 
        
        task.resume()
    }
    
    func getUpcomingMovie(completion:@escaping (Result<[Movie], Error>)-> Void) {
        
        guard let  url = URL(string: "\(Constants.baseURL)/3/movie/upcoming?api_key=\(Constants.API_Key)")
        else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let  data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TrendingMoviesResponse.self, from: data)
                completion(.success(results.results))
            }
            catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        
        task.resume()
    }
    
    func getPopularMovie(completion:@escaping (Result<[Movie], Error>)-> Void) {
        
        guard let url = URL(string: "\(Constants.baseURL)/3/tv/popular?api_key=\(Constants.API_Key)")
        else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let  data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TrendingMoviesResponse.self, from: data)
                completion(.success(results.results))
            }
            catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        
        task.resume()
    }
    
    func getTopRated(completion:@escaping (Result<[Movie], Error>)-> Void) {
        
        guard let url = URL(string: "\(Constants.baseURL)/3/tv/top_rated?api_key=\(Constants.API_Key)")
        else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let  data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TrendingMoviesResponse.self, from: data)
                completion(.success(results.results))
            }
            catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        
        task.resume()
    }
    
    
}




// https://api.themoviedb.org/3/movie/upcoming?api_key=3c3895e1cba7ab9c182d5d7df5b89610
// https://api.themoviedb.org/3/tv/popular?api_key=3c3895e1cba7ab9c182d5d7df5b89610
//https://api.themoviedb.org/3/tv/top_rated?api_key=3c3895e1cba7ab9c182d5d7df5b89610
