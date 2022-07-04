//
//  CocktailAPIEndpoints.swift
//  Cocktails
//
//  Created by Pasquale on 30/06/22.
//

import Foundation

enum DrinksAPIEndpoints {
    case getDrinksBy(String)
    case getRandomDrink
    
    func urlString() -> String {
        switch self {
        case .getDrinksBy(let firstLetter):
            return composeURL(path: "/search.php", params: ["f": firstLetter])
        case .getRandomDrink:
            return composeURL(path: "/random.php", params: [:])
        }
    }
}

extension DrinksAPIEndpoints {
    
    fileprivate func composeURL(path: String, params: [String: String]) -> String {
        let url = DrinksAPI.authenticatedBaseURL.appendingPathComponent(path)
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        var queryItems = Array(urlComponents.queryItems ?? [])
        
        for (key, value) in params {
            queryItems.append(URLQueryItem(name: key, value: value))
        }
        
        urlComponents.queryItems = queryItems
        
        return urlComponents.url!.absoluteString
    }
    
}
