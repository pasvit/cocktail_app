//
//  CocktailFacade.swift
//  Cocktails
//
//  Created by Pasquale on 30/06/22.
//

import Foundation
import UIKit

class CocktailServiceFacade {
    class func fetchCocktails(by letter: String, completion: @escaping (Result<[CocktailViewModel], DrinksError>) -> Void) {
        DrinksService().fetchDrinks(by: letter) { result in
            switch result {
            case .success(let drinks):
                let cocktails = drinks.filter({ $0.strCategory == "Cocktail" })
                let cocktailsVM = cocktails.map({ cocktail in
                    CocktailViewModel(id: cocktail.idDrink, name: cocktail.strDrink, category: cocktail.strCategory ?? "", isAlcoholic: cocktail.strAlcoholic=="Alcoholic", instructionsIT: cocktail.strInstructionsIT ?? "", imageUrlString: cocktail.strDrinkThumb ?? "")
                })
                completion(.success(cocktailsVM))
                Log.info("fetchCocktails SUCCESS ->", cocktailsVM)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    class func fetchCocktailImage(with imageUrlString: String, completion: @escaping (Result<UIImage, DrinksError>) -> Void) {
        DrinksService().fetchDrinkImageData(with: imageUrlString) { result in
            switch result {
            case .success(let imageData):
                let cocktailImage = UIImage(data: imageData) ?? UIImage(named: "cocktail_image_default")!
                completion(.success(cocktailImage))
            case .failure(_):
                break
            }
        }
    }
}
