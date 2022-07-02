//
//  CocktailService.swift
//  Cocktails
//
//  Created by Pasquale on 30/06/22.
//

import Foundation

class DrinksService {
    /// allows you to get a list of drinks by first letter
    func fetchDrinks(by letter: String, completion: @escaping (Result<[Drink], DrinksError>) -> Void) {
        DispatchQueue.global().async {
            let urlString = DrinksAPIEndpoints.getDrinksBy(letter).urlString()
            
            guard let url = URL(string: urlString) else {
                Log.error("fetchDrinks invalid URL")
                return completion(.failure(DrinksError.invalidURL))
            }
            
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let jsonData = data {
                    if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                        do {
                            let response: Response = try JSONDecoder().decode(Response.self, from: jsonData)
                            completion(.success(response.drinks))
                        } catch let error {
                            completion(.failure(DrinksError.decoding))
                            Log.error("fetchDrinks decoding error: ", error.localizedDescription)
                        }
                    } else {
                        completion(.failure(DrinksError.statusCode))
                        Log.error("fetchDrinks statusCode error")
                    }
                } else {
                    if let error = error {
                        completion(.failure(DrinksError.other(error)))
                    } else {
                        completion(.failure(DrinksError.genericError))
                    }
                    Log.error("fetchDrinks error")
                }
            }
            task.resume()
        }
    }
    
    /// allows you to get a random drink
    func fetchRandomDrink(completion: @escaping (Result<Drink?, DrinksError>) -> Void) {
        DispatchQueue.global().async {
            let urlString = DrinksAPIEndpoints.getRandomDrink.urlString()
            
            guard let url = URL(string: urlString) else {
                Log.error("fetchRandomDrink invalid URL")
                return completion(.failure(DrinksError.invalidURL))
            }
            
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let jsonData = data {
                    if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                        do {
                            let response: Response = try JSONDecoder().decode(Response.self, from: jsonData)
                            completion(.success(response.drinks.first))
                        } catch let error {
                            completion(.failure(DrinksError.decoding))
                            Log.error("fetchRandomDrink decoding error: ", error.localizedDescription)
                        }
                    } else {
                        completion(.failure(DrinksError.statusCode))
                        Log.error("fetchRandomDrink statusCode error")
                    }
                } else {
                    if let error = error {
                        completion(.failure(DrinksError.other(error)))
                    } else {
                        completion(.failure(DrinksError.genericError))
                    }
                    Log.error("fetchRandomDrink error")
                }
            }
            task.resume()
        }
    }
    
    /// given the url of the drink image, it allows you to retrieve the DATA of the image
    func fetchDrinkImageData(with imageUrlString: String, completion: @escaping (Result<Data, DrinksError>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            let url: URL? = URL(string: imageUrlString)
            
            guard let url = url else {
                Log.error("fetchCocktailImageData invalid URL")
                return completion(.failure(DrinksError.invalidURL))
            }
            
            let task = URLSession.shared.dataTask(with: url)
            { (data, response, error) in
                if let response = response as? HTTPURLResponse,
                   response.statusCode == 200 {
                    if let data = data {
                        completion(.success(data))
                        Log.info("fetchCocktailImageData SUCCESS")
                    } else {
                        completion(.failure(DrinksError.decoding))
                        Log.error("fetchCocktailImageData decoding error")
                    }
                } else {
                    completion(.failure(DrinksError.statusCode))
                    Log.error("fetchCocktailImageData statusCode error")
                }
            }
            task.resume()
        }
    }
    
}
