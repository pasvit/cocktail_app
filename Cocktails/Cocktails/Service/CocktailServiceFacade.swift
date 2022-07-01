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
                let cocktails = drinks.filter({ $0.strCategory == "Cocktail" || $0.strCategory == "Ordinary Drink" })
                let cocktailsVM = cocktails.map({ cocktail in
                    CocktailViewModel(id: cocktail.idDrink, name: cocktail.strDrink, category: cocktail.strCategory ?? "", glassType: cocktail.strGlass ?? "", alcoholic: cocktail.strAlcoholic ?? "", instructions: cocktail.strInstructions ?? "", ingredientsMeasures: getIngredientsMeasures(from: cocktail), imageUrlString: cocktail.strDrinkThumb ?? "")
                })
                completion(.success(cocktailsVM))
                Log.info("fetchCocktails SUCCESS ->", cocktailsVM)
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        func getIngredientsMeasures(from drink: Drink) -> [String: String] {
            var ingredientsMeasures: [String: String] = [:]
            
            if let ingredient = drink.strIngredient1, let measure = drink.strMeasure1, !ingredient.isEmpty, !measure.isEmpty {
                ingredientsMeasures[ingredient] = measure
            }
            if let ingredient = drink.strIngredient2, let measure = drink.strMeasure2, !ingredient.isEmpty, !measure.isEmpty {
                ingredientsMeasures[ingredient] = measure
            }
            if let ingredient = drink.strIngredient3, let measure = drink.strMeasure3, !ingredient.isEmpty, !measure.isEmpty {
                ingredientsMeasures[ingredient] = measure
            }
            if let ingredient = drink.strIngredient4, let measure = drink.strMeasure4, !ingredient.isEmpty, !measure.isEmpty {
                ingredientsMeasures[ingredient] = measure
            }
            if let ingredient = drink.strIngredient5, let measure = drink.strMeasure5, !ingredient.isEmpty, !measure.isEmpty {
                ingredientsMeasures[ingredient] = measure
            }
            if let ingredient = drink.strIngredient6, let measure = drink.strMeasure6, !ingredient.isEmpty, !measure.isEmpty {
                ingredientsMeasures[ingredient] = measure
            }
            if let ingredient = drink.strIngredient7, let measure = drink.strMeasure7, !ingredient.isEmpty, !measure.isEmpty {
                ingredientsMeasures[ingredient] = measure
            }
            if let ingredient = drink.strIngredient8, let measure = drink.strMeasure8, !ingredient.isEmpty, !measure.isEmpty {
                ingredientsMeasures[ingredient] = measure
            }
            if let ingredient = drink.strIngredient9, let measure = drink.strMeasure9, !ingredient.isEmpty, !measure.isEmpty {
                ingredientsMeasures[ingredient] = measure
            }
            if let ingredient = drink.strIngredient10, let measure = drink.strMeasure10, !ingredient.isEmpty, !measure.isEmpty {
                ingredientsMeasures[ingredient] = measure
            }
            if let ingredient = drink.strIngredient11, let measure = drink.strMeasure11, !ingredient.isEmpty, !measure.isEmpty {
                ingredientsMeasures[ingredient] = measure
            }
            
            return ingredientsMeasures
        }
    }
    
    class func fetchCocktailImage(with imageUrlString: String, completion: @escaping (Result<UIImage, DrinksError>) -> Void) {
        DrinksService().fetchDrinkImageData(with: imageUrlString) { result in
            switch result {
            case .success(let imageData):
                let cocktailImage = UIImage(data: imageData) ?? UIImage()
                completion(.success(cocktailImage))
            case .failure(_):
                break
            }
        }
    }
}
