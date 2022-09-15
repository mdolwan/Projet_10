//
//  FavoriteCell.swift
//  Recipes
//
//  Created by Mohammad Olwan on 02/04/2022.
//
import AlamofireImage
import UIKit
import CoreData

class FavoriteCell: UITableViewCell {
    
    
    private var getFavorite : CoreDataManager?
    
    @IBOutlet weak var fMainView: UIView!
    @IBOutlet weak var fCaloriesTxt: UILabel!
    @IBOutlet weak var fYieldTxt: UILabel!
    @IBOutlet weak var fbriefInfoView: UIView!
    @IBOutlet weak var fImageView: UIImageView!
    @IBOutlet weak var fTitleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let coredataStack = appdelegate.coreDataStack
        getFavorite = CoreDataManager(coreDataStack: coredataStack)
        //
        fbriefInfoView.layer.cornerRadius = 15
        guard let img = UIImage(named: "BriefBg.png") else { return }
        fbriefInfoView.backgroundColor = UIColor(patternImage: img)
        fMainView.sendSubviewToBack(fImageView)
        fMainView.bringSubviewToFront(fTitleLbl)
        fTitleLbl.backgroundColor = UIColor(patternImage: UIImage(named: "bg.png")!)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

// MARK: - Public Methods

extension FavoriteCell {
    
    func configure(with recipData: Recipe) {
        
        
        self.fTitleLbl.text = recipData.label + "\n"
        self.fTitleLbl.text! += "This recette have \(String(Int(recipData.calories))) of Calories and \(String(recipData.yield)) of yield"
        self.fCaloriesTxt.text = String(recipData.calories)
        self.fYieldTxt.text = String(recipData.yield) + " K"
        
        if let url = URL(string: recipData.image) {
            self.fImageView.af.setImage(withURL: url)
        } else {
            self.fImageView.image = nil
            self.fImageView.backgroundColor = .black
        }
        
        applyAccessibility(recipData)
    }
    
}

// MARK: Accessibility

extension FavoriteCell {
  func applyAccessibility(_ recipData: Recipe) {
      fImageView.accessibilityTraits = .image
      fImageView.accessibilityLabel = recipData.label
  }
}
