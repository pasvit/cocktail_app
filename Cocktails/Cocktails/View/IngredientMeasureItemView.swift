//
//  IngredientMeasureItemView.swift
//  Cocktails
//
//  Created by Pasquale on 01/07/22.
//

import UIKit

class IngredientMeasureItemView: UIView {
    // ˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜
    //    MARK: - View - lazy var
    // \_____________________________________________________________________/
    lazy var measureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var ingredientLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // ˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜
    //    MARK: - init
    // \_____________________________________________________________________/
    convenience init(ingredient: String, measure: String) {
        self.init(frame: .zero)
        setup()
        style(with: ingredient, and: measure)
        layout()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // ˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜
    //    MARK: - private func
    // \_____________________________________________________________________/
    private func setup() {
        addSubview(measureLabel)
        addSubview(ingredientLabel)
        addSubview(separatorView)
    }
    
    private func style(with ingredient: String, and measure: String) {
        measureLabel.text = measure
        ingredientLabel.text = ingredient
        ingredientLabel.textColor = UIColor.black
    }
    
    private func layout() {
        // MARK: - Constraints self View
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 60)
        ])
        
        // MARK: - Constraints measureLabel
        NSLayoutConstraint.activate([
            measureLabel.topAnchor.constraint(equalTo: topAnchor, constant:15),
            measureLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant:0),
            measureLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant:0)
        ])
        
        // MARK: - Constraints ingredientLabel
        NSLayoutConstraint.activate([
            ingredientLabel.topAnchor.constraint(equalTo: measureLabel.bottomAnchor, constant:0),
            ingredientLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant:0),
            ingredientLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant:0)
        ])
        
        // MARK: - Constraints separatorView
        NSLayoutConstraint.activate([
            separatorView.topAnchor.constraint(equalTo: ingredientLabel.bottomAnchor, constant:10),
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant:0),
            separatorView.bottomAnchor.constraint(equalTo: bottomAnchor, constant:0),
            separatorView.heightAnchor.constraint(equalToConstant: 1),
            separatorView.widthAnchor.constraint(equalToConstant: 30),
        ])
    }
}
