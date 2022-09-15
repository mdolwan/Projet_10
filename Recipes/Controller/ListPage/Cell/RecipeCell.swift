//
//  RecipeCell.swift
//  Recipes
//
//  Created by Mohammad Olwan on 20/03/2022.
//

import AlamofireImage
import UIKit

class RecipeCell: UITableViewCell {
    
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var yieldValueText: UILabel!
    @IBOutlet weak var caloriesValueText: UILabel!
    @IBOutlet weak var briefInfoView: UIView!
    @IBOutlet weak var mainView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        guard let img = UIImage(named: "BriefBg.png") else { return }
        briefInfoView.layer.cornerRadius = 15
        briefInfoView.backgroundColor = UIColor(patternImage: img)
        mainView.sendSubviewToBack(recipeImageView)
        mainView.bringSubviewToFront(titleLabel)
        titleLabel.backgroundColor = UIColor(patternImage: UIImage(named: "bg.png")!)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

// MARK: - Public Methods

extension RecipeCell {
    
    func configure(with recipe: Recipe) {
        
        titleLabel.text = recipe.label + "\n"
        titleLabel.text! += "This recette have \(String(Int(recipe.calories))) of Calories and \(String(recipe.yield)) of yield"
        caloriesValueText.text = (" \(String(Int(recipe.calories))) K")
        yieldValueText.text = (" \(String(recipe.yield))")
        if let url = URL(string: recipe.image) {
            self.recipeImageView.af.setImage(withURL: url)
        } else {
            self.recipeImageView.image = nil
            self.recipeImageView.backgroundColor = .black
        }
        
        applyAccessibility(recipe)
    }
}



// MARK: Accessibility

extension RecipeCell {
  func applyAccessibility(_ recipe: Recipe) {
      recipeImageView.accessibilityTraits = .image
      recipeImageView.accessibilityLabel = recipe.label
  }
}
