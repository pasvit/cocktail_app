//
//  DrinksServiceProtocol.swift
//  Cocktails
//
//  Created by Pasquale on 02/07/22.
//

import UIKit

protocol CocktailServiceProtocol {
    func fetchCocktails(by letter: String, completion: @escaping (Result<[CocktailViewModel], DrinksError>) -> Void)
    func fetchCocktailImage(with imageUrlString: String, completion: @escaping (Result<UIImage, DrinksError>) -> Void)
    func fetchRandomCocktail(completion: @escaping (Result<CocktailViewModel, DrinksError>) -> Void)
}
