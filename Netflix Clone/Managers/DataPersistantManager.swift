//
//  DataPersistantManager.swift
//  Netflix Clone
//
//  Created by K Praveen Kumar on 02/08/23.
//

import Foundation
import UIKit
import CoreData

class DataPersistenceManager {
    
    enum databasError: Error {
        case failedToSaveData
        case failedToFetchData
        case failedToDeleteData
    }
    
    static let shared = DataPersistenceManager()
    
    func downloadTitleWith(model: Movie, completion: @escaping (Result<Void, Error>) -> Void) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
   
        let context = appDelegate.persistentContainer.viewContext
        
        let item = MovieItem(context: context)
        
        item.id = Int64(model.id)
        item.adult = model.adult
        item.backdropPath = model.backdropPath
        item.mediaType = model.mediaType
        item.originalLanguage = model.originalLanguage
        item.originalTitle = model.originalTitle
        item.overview = model.overview
        item.popularity = model.popularity
        item.posterPath = model.posterPath
        item.releaseDate = model.releaseDate
        item.title = model.title
        item.voteAverage = model.voteAverage
        
        
        do {
            try context.save()
            completion(.success(()))
        } catch  {
            completion(.failure(databasError.failedToSaveData))
        }
    }
    
    func fetchMoviesFromDataBase(completion: @escaping (Result<[MovieItem], Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
   
        let context = appDelegate.persistentContainer.viewContext
        
        let request: NSFetchRequest<MovieItem>
        
        request = MovieItem.fetchRequest()
        
        do {
            
            let titles = try context.fetch(request)
            completion(.success(titles))
            
            
        } catch  {
            completion(.failure(databasError.failedToFetchData))
        }
    }
    
    func deleteTitleWith(model:MovieItem, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
   
        let context = appDelegate.persistentContainer.viewContext
        
        context.delete(model)
        
        do {
            
            try context.save()
            completion(.success(()))
            
            
        } catch  {
            completion(.failure(databasError.failedToDeleteData))
        }
    }
    
    
}
