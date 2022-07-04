//
//  CocktailAPI.swift
//  Cocktails
//
//  Created by Pasquale on 30/06/22.
//

import Foundation

struct DrinksAPI {
    static fileprivate let APIKey = "1"
    static fileprivate let baseURL = URL(string: "https://www.thecocktaildb.com/api/json/v1/")!
    
    static var authenticatedBaseURL: URL {
        return baseURL.appendingPathComponent(APIKey)
    }
}
