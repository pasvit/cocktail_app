//
//  RandomCocktailTableViewCell.swift
//  Cocktails
//
//  Created by Pasquale on 01/07/22.
//

import UIKit

class RandomCocktailTableViewCell: UITableViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    // ˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜
    //    MARK: - Public var
    // \_____________________________________________________________________/
    override func awakeFromNib() {
        super.awakeFromNib()
        styleView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func styleView() {
        imgView.image = UIImage(named: "easterEgg_questionMark")
        imgView.layer.cornerRadius = 15
        
        titleLabel.text = "No ideas?"
        subtitleLabel.text = "Click here"
    }
}
