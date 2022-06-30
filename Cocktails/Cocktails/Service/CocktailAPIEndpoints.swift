//
//  CocktailAPIEndpoints.swift
//  Cocktails
//
//  Created by Pasquale on 30/06/22.
//

import Foundation

enum CocktailAPIEndpoints {
    case getDrinksBy(String)
    
    func urlString() -> String {
        switch self {
        case .getDrinksBy(let firstLetter):
            return composeURL(path: "/search.php", params: ["f": firstLetter])
        }
    }
}

extension CocktailAPIEndpoints {
    
    fileprivate func composeURL(path: String, params: [String: String]) -> String {
        let url = CocktailAPI.authenticatedBaseURL.appendingPathComponent(path)
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        var queryItems = Array(urlComponents.queryItems ?? [])
        
        for (key, value) in params {
            queryItems.append(URLQueryItem(name: key, value: value))
        }
        
        urlComponents.queryItems = queryItems
        
        return urlComponents.url!.absoluteString
    }
    
}
