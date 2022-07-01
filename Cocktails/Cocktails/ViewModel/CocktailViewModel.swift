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
    let alcoholic: String
    let instructionsIT: String?
    var imageUrlString: String?
    var image: UIImage? {
        didSet {
            self.bindImageToView()
        }
    }
    
    var description: String {
        """
        id:\(self.id)
        name:\(self.name)
        category:\(self.category)
        alcoholic:\(self.alcoholic)
        instructionsIT:\(self.instructionsIT ?? "empty")
        imageUrlString:\(self.imageUrlString ?? "empty")\n\n
        """
    }
    
    // ˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜
    //    MARK: - Binding var
    // \_____________________________________________________________________/
    var bindImageToView : (() -> ()) = {}
    
    init(id: String, name: String, category: String, alcoholic: String, instructionsIT: String, imageUrlString: String) {
        self.id = id
        self.name = name
        self.category = category
        self.alcoholic = alcoholic
        self.instructionsIT = instructionsIT
        self.imageUrlString = imageUrlString
        self.image = nil
        fetchCocktailImage()
    }
    
    // ˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜
    //    MARK: - Private Methods
    // \_____________________________________________________________________/
    private func fetchCocktailImage() {
        guard let imageUrlString = self.imageUrlString else { return }
        CocktailServiceFacade.fetchCocktailImage(with: imageUrlString) { result in
            switch result {
            case .success(let image):
                self.image = image
            case .failure(_):
                break
            }
        }
    }
}
