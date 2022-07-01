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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Make the navigation bar background clear
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()

        UINavigationBar.appearance().standardAppearance = appearance
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Restore the navigation bar to default
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
    }

    private func styleView() {
        //    MARK: - image
        imgView.image = cocktailViewModel?.image
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

