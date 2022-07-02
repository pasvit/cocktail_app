//
//  CocktailDetailViewController.swift
//  Cocktails
//
//  Created by Pasquale on 01/07/22.
//

import UIKit

class CocktailDetailViewController: UIViewController, Storyboarded {
    //    MARK: - Coordinator
    weak var coordinator: MainCoordinator?
    
    // ˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜
    //    MARK: - View
    // \_____________________________________________________________________/
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var glassLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var alcoholicLabel: UILabel!
    @IBOutlet weak var instructionsLabel: UILabel!
    @IBOutlet weak var measuresIngredientStackView: UIStackView!
    
    // ˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜
    //    MARK: - public Var
    // \_____________________________________________________________________/
    var cocktailViewModel: CocktailViewModel?
    
    // ˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜
    //    MARK: - Init
    // \_____________________________________________________________________/
    override func viewDidLoad() {
        super.viewDidLoad()
        styleView()
    }

    // ˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜
    //    MARK: - private func
    // \_____________________________________________________________________/
    private func styleView() {
        //    MARK: - image
        if let image = cocktailViewModel?.image {
            imgView.image = image
        } else {
            cocktailViewModel?.bindImageToView = { [weak self] in
                DispatchQueue.main.async {
                    self?.imgView.image = self?.cocktailViewModel?.image
                }
            }
        }
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = 30
        imgView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        //    MARK: - glass
        glassLabel.text = cocktailViewModel?.glassType
        
        //    MARK: - name
        nameLabel.text = cocktailViewModel?.name
        
        //    MARK: - alcoholic
        alcoholicLabel.text = cocktailViewModel?.alcoholic
        
        //    MARK: - instructions
        instructionsLabel.text = cocktailViewModel?.instructions?.replacingOccurrences(of: "\r", with: "")
        instructionsLabel.textColor = .black
        
        //    MARK: - ingredients - measures
        if let ingredientsMeasures = cocktailViewModel?.ingredientsMeasures {
            let ingredients = Array<String>(ingredientsMeasures.keys)
            for ingredient in ingredients {
                let view = IngredientMeasureItemView(ingredient: ingredient, measure: ingredientsMeasures[ingredient] ?? "")
                measuresIngredientStackView.addArrangedSubview(view)
            }
        }
        
        view.layoutIfNeeded()
    }
}

