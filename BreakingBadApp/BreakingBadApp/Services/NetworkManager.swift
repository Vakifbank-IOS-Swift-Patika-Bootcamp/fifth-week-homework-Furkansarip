//
//  NetworkManager.swift
//  BreakingBadApp
//
//  Created by Furkan Sarı on 22.11.2022.
//

import Foundation

struct NetworkManager {
    private let baseURL = "https://breakingbadapi.com/api/"
        static let shared = NetworkManager()
        private init(){}
        
    func getAllCharacters(path:String,completion:@escaping(_ result:Result<[CharacterModel],ErrorModel>)->Void){
            let endpoint = baseURL + path
            
            guard let url = URL(string: endpoint) else {
                completion(.failure(.invalidURL))
                return
            }
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let _ = error {
                    completion(.failure(.unableToComplete))
                }
                guard let response = response as? HTTPURLResponse,response.statusCode == 200 else {
                    completion(.failure(.invalidResponse))
                    return
                }
                guard let data = data else {
                    completion(.failure(.invalidData))
                    
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let characters = try decoder.decode([CharacterModel].self, from: data)
                    completion(.success(characters))
                }catch{
                    completion(.failure(.invalidData))
                }
            
            }
            task.resume()
        }
    
    
    func getCharacterQuote(author:String,completion:@escaping(_ result:Result<[QuoteModel],ErrorModel>)->Void){
            let endpoint = baseURL + "quote?author=\(author)"
            
            guard let url = URL(string: endpoint) else {
                completion(.failure(.invalidURL))
                return
            }
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let _ = error {
                    completion(.failure(.unableToComplete))
                }
                guard let response = response as? HTTPURLResponse,response.statusCode == 200 else {
                    completion(.failure(.invalidResponse))
                    return
                }
                guard let data = data else {
                    completion(.failure(.invalidData))
                    
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let quotes = try decoder.decode([QuoteModel].self, from: data)
                    completion(.success(quotes))
                }catch{
                    completion(.failure(.invalidData))
                }
            
            }
            task.resume()
        }
    
    func getAllEpisodes(series:String,completion:@escaping(_ result:Result<[EpisodesModel],ErrorModel>)->Void){
    
            let endpoint = baseURL + "episodes?series=\(series)"
            
            guard let url = URL(string: endpoint) else {
                completion(.failure(.invalidURL))
                return
            }
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let _ = error {
                    completion(.failure(.unableToComplete))
                }
                guard let response = response as? HTTPURLResponse,response.statusCode == 200 else {
                    completion(.failure(.invalidResponse))
                    return
                }
                guard let data = data else {
                    completion(.failure(.invalidData))
                    
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let episodes = try decoder.decode([EpisodesModel].self, from: data)
                    completion(.success(episodes))
                }catch{
                    completion(.failure(.invalidData))
                }
            
            }
            task.resume()
        }
    
    
}
