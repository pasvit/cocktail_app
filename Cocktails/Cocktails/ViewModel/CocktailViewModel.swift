//
//  CocktailViewModel.swift
//  Cocktails
//
//  Created by Pasquale on 30/06/22.
//

import UIKit

class CocktailViewModel: CustomStringConvertible {
    let id: String
    let name: String
    let category: String
    let glassType: String
    let alcoholic: String
    let instructions: String?
    let ingredientsMeasures: [String: String]
    var imageUrlString: String?
    var image: UIImage? {
        didSet {
            self.bindImageToView()
        }
    }
    
    var description: String {
        let imageInfo = self.image == nil ? "nil" : "loaded"
        return """
        id:\(self.id)
        name:\(self.name)
        category:\(self.category)
        glassType:\(self.glassType)
        alcoholic:\(self.alcoholic)
        instructions:\(self.instructions ?? "empty")
        ingredientsMeasures:\(self.ingredientsMeasures)
        imageUrlString:\(self.imageUrlString ?? "empty")
        image:\(imageInfo)\n\n
        """
    }
    
    // ˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜
    //    MARK: - Binding var
    // \_____________________________________________________________________/
    var bindImageToView : (() -> ()) = {}
    
    // ˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜
    //    MARK: - private var
    // \_____________________________________________________________________/
    private var service: CocktailServiceProtocol
    
    init(service: CocktailServiceProtocol = CocktailServiceFacade(), id: String, name: String, category: String, glassType: String, alcoholic: String, instructions: String, ingredientsMeasures: [String: String], imageUrlString: String) {
        self.service = service
        
        self.id = id
        self.name = name
        self.category = category
        self.glassType = glassType
        self.alcoholic = alcoholic
        self.instructions = instructions
        self.ingredientsMeasures = ingredientsMeasures
        self.imageUrlString = imageUrlString
        self.image = nil
        self.fetchCocktailImage()
    }
    
    // ˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜
    //    MARK: - Private Methods
    // \_____________________________________________________________________/
    private func fetchCocktailImage() {
        guard let imageUrlString = self.imageUrlString else { return }
        service.fetchCocktailImage(with: imageUrlString) { result in
            switch result {
            case .success(let image):
                self.image = image
            case .failure(_):
                break
            }
        }
    }
}
