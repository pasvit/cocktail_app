//
//  RandomCocktailTableViewCell.swift
//  Cocktails
//
//  Created by Pasquale on 01/07/22.
//

import UIKit

class RandomCocktailTableViewCell: UITableViewCell {
    // ˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜
    //    MARK: - View
    // \_____________________________________________________________________/
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // ˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜
    //    MARK: - Life Cycle
    // \_____________________________________________________________________/
    override func awakeFromNib() {
        super.awakeFromNib()
        styleView()
        hideLoader()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // ˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜
    //    MARK: - public func
    // \_____________________________________________________________________/
    func showLoader() {
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        self.isUserInteractionEnabled = false
    }
    
    func hideLoader() {
        self.activityIndicator.isHidden = true
        self.activityIndicator.stopAnimating()
        self.isUserInteractionEnabled = true
    }
    
    
    // ˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜
    //    MARK: - private func
    // \_____________________________________________________________________/
    private func styleView() {
        imgView.image = UIImage(named: "easterEgg_questionMark")
        imgView.layer.cornerRadius = 15
        
        titleLabel.text = "No ideas?"
        subtitleLabel.text = "Click here"
    }
}
