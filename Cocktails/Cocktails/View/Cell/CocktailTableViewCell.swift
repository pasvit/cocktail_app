//
//  CocktailTableViewCell.swift
//  Cocktails
//
//  Created by Pasquale on 30/06/22.
//

import UIKit

class CocktailTableViewCell: UITableViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var alcoholicLabel: UILabel!
    
    // ˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜
    //    MARK: - Public var
    // \_____________________________________________________________________/
    var cocktailViewModel: CocktailViewModel? {
        didSet {
            self.styleView()
            self.setupBindings()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func styleView() {
        imgView.image = cocktailViewModel?.image
        imgView.layer.cornerRadius = 10
        
        nameLabel.text = cocktailViewModel?.name
        alcoholicLabel.text = cocktailViewModel?.alcoholic
    }
    
    private func setupBindings() {
        cocktailViewModel?.bindImageToView = { [weak self] in
            DispatchQueue.main.async {
                self?.reloadRow(with: self?.imgView, duration: 0.2, animations: { self?.imgView.image = self?.cocktailViewModel?.image })
            }
        }
    }
    
    private func reloadRow(with view: UIView?, duration: TimeInterval, animations: (() -> Void)?, completion: ((Bool) -> Void)? = nil) {
        guard let view = view else { return }
        UIView.transition(with: view,
                          duration: duration,
                          options: .transitionCrossDissolve,
                          animations: animations,
                          completion: completion)
        
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
}
