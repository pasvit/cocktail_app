//
//  CocktailService.swift
//  Cocktails
//
//  Created by Pasquale on 30/06/22.
//

import Foundation

protocol CocktailServiceProtocol {
    func fetchCocktails(by letter: String, completion: @escaping (Result<[Drink], CocktailError>) -> Void)
}

class CocktailService: CocktailServiceProtocol {
    private let baseUrl: URL? = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/search.php?f=a")
    
    /// allows you to get a list of cocktail by first letter
    func fetchCocktails(by letter: String, completion: @escaping (Result<[Drink], CocktailError>) -> Void) {
        DispatchQueue.global().async {
            let urlString = CocktailAPIEndpoints.getDrinksBy(letter).urlString()
            
            guard let url = URL(string: urlString) else {
                Log.error("fetchCocktails invalid URL")
                return completion(.failure(CocktailError.invalidURL))
            }
            
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let jsonData = data {
                    if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                        do {
                            let response: Response = try JSONDecoder().decode(Response.self, from: jsonData)
                            completion(.success(response.drinks))
                            Log.info("fetchCocktails SUCCESS ->", response.drinks)
                        } catch let error {
                            completion(.failure(CocktailError.decoding))
                            Log.error("fetchCocktails decoding error: ", error.localizedDescription)
                        }
                    } else {
                        completion(.failure(CocktailError.statusCode))
                        Log.error("fetchCocktails statusCode error")
                    }
                } else {
                    if let error = error {
                        completion(.failure(CocktailError.other(error)))
                    } else {
                        completion(.failure(CocktailError.genericError))
                    }
                    Log.error("fetchCocktails error")
                }
            }
            task.resume()
        }
    }
    
}
