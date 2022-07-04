//
//  MockDrinksService.swift
//  Cocktails
//
//  Created by Pasquale on 02/07/22.
//

import UIKit

class MockCocktailService: CocktailServiceProtocol {
    // ˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜
    //    MARK: - static let
    // \_____________________________________________________________________/
    static let mockedGinTonic = CocktailViewModel(id: "178365", name: "Gin Tonic", category: "Cocktail", glassType: "Highball glass", alcoholic: "Alcoholic", instructions: "Fill a highball glass with ice, pour the gin, top with tonic water and squeeze a lemon wedge and garnish with a lemon wedge.", ingredientsMeasures: ["Lemon Peel": "1 Slice", "Gin": "4 cl", "Tonic Water": "10 cl", "Ice": "cubes"], imageUrlString: "https://www.thecocktaildb.com/images/media/drink/qcgz0t1643821443.jpg")
    static let mockedMargarita = CocktailViewModel(id: "11007", name: "Margarita", category: "Ordinary Drink", glassType: "Cocktail glass", alcoholic: "Alcoholic", instructions: "Rub the rim of the glass with the lime slice to make the salt stick to it. Take care to moisten only the outer rim and sprinkle the salt on it. The salt should present to the lips of the imbiber and never mix into the cocktail. Shake the other ingredients with ice, then carefully pour into the glass.", ingredientsMeasures: ["Tequila": "1 1/2 oz ", "Lime juice": "1 oz ", "Triple sec": "1/2 oz "], imageUrlString: "https://www.thecocktaildb.com/images/media/drink/5noda61589575158.jpg")
    static let mockedDrinks: [CocktailViewModel] = [mockedGinTonic, mockedMargarita]
    
    // ˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜
    //    MARK: - public var
    // \_____________________________________________________________________/
    var fetchCocktailsResult: Result<[CocktailViewModel], DrinksError>?
    var fetchCocktailImageResult: Result<UIImage, DrinksError>?
    
    // ˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜
    //    MARK: - public func
    // \_____________________________________________________________________/
    func fetchCocktails(by letter: String, completion: @escaping (Result<[CocktailViewModel], DrinksError>) -> Void) {
        guard let result = fetchCocktailsResult else { return }
        completion(result)
    }
    
    func fetchCocktailImage(with imageUrlString: String, completion: @escaping (Result<UIImage, DrinksError>) -> Void) {
        guard let result = fetchCocktailImageResult else { return }
        completion(result)
    }
    
    func fetchRandomCocktail(completion: @escaping (Result<CocktailViewModel, DrinksError>) -> Void) {}
}
