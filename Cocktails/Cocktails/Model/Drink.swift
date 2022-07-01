//
//  Drink.swift
//  Cocktails
//
//  Created by Pasquale on 30/06/22.
//

import Foundation

struct Response: Codable {
    let drinks: [Drink]
}

struct Drink: Codable {
    let idDrink: String
    let strDrink: String
    let strCategory, strAlcoholic: String?
    let strInstructionsIT: String?
    let strDrinkThumb: String?
    let strIngredient1, strIngredient2, strIngredient3: String?
}

