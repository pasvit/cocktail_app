//
//  CocktailError.swift
//  Cocktails
//
//  Created by Pasquale on 30/06/22.
//

import Foundation

enum CocktailError: Error {
    case statusCode
    case decoding
    case invalidURL
    case genericError
    case noConnection
    case other(Error)
    
    var localizedDescription: String {
        switch self {
        case .statusCode:
            return "Status Code Error"
        case .decoding:
            return "Decoding Error"
        case .invalidURL:
            return "Invalid URL Error"
        case .genericError:
            return "Generic Error"
        case .noConnection:
            return "Connection Offline Error: I cannot update or load other cocktail"
        case .other(let error):
            return error.localizedDescription
        }
    }
    
    var code: Int? {
        switch self {
        case .other(let error):
            return (error as NSError).code
        default:
            return nil
        }
    }
}
