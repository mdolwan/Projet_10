//
//  DetailOfRecipePage.swift
//  Recipes
//
//  Created by Mohammad Olwan on 24/03/2022.
//

import UIKit
import CoreData
import AlamofireImage

class DetailOfRecipePage: UIViewController {
    
    private var coreDataManager: CoreDataManager?
    var isInFavorite: Bool = false
    var hitSelected : Hit? = nil
    
    @IBOutlet weak var ingredientOfRecipe: UITableView!
    @IBOutlet weak var imageOfRecipe: UIImageView!
    @IBOutlet weak var titleOfRecipe: UILabel!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    @IBOutlet weak var mainViewStackUp: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainViewStackUp.sendSubviewToBack(imageOfRecipe)
        mainViewStackUp.bringSubviewToFront(titleOfRecipe)
       
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let coredataStack = appdelegate.coreDataStack
        coreDataManager = CoreDataManager(coreDataStack: coredataStack)
       
        isInFavorite = coreDataManager!.isExist(title: (hitSelected?.recipe.label)!)
        setImageBarButton()
        ingredientOfRecipe.delegate = self
        ingredientOfRecipe.dataSource = self
        ingredientOfRecipe.backgroundColor = UIColor.black
        self.view.backgroundColor = UIColor.black
        
        if let url = URL(string: (hitSelected?.recipe.image)!) {
            self.imageOfRecipe.af.setImage(withURL: url)
        } else {
            self.imageOfRecipe.image = nil
            self.imageOfRecipe.backgroundColor = .black
        }
        
        titleOfRecipe.text = hitSelected?.recipe.label
        
    }
    // MARK: - Open safari for more details
    @IBAction func getDirection(_ sender: UIButton) {
        
        if let url = URL(string: (hitSelected?.recipe.url)!) {
            UIApplication.shared.open(url)
        }
    }
    
    // MARK: - Add or Remove Recipe from Favorite
    @IBAction func addRemoveFromfavorite(_ sender: UIBarButtonItem) {
        
        isInFavorite = coreDataManager!.isExist(title: (hitSelected?.recipe.label)!)
        
        if isInFavorite {
            favoriteButton.setBackgroundImage(UIImage(named: "star.png") ,for : UIControl.State.normal, barMetrics: .default)
            coreDataManager!.deleteFromFavoritete(title: (hitSelected?.recipe.label)!)
        }
        else{
            favoriteButton.setBackgroundImage(UIImage(named: "starG.png") ,for : UIControl.State.normal, barMetrics: .default)
            let recipe = Recipe.init(label: (hitSelected?.recipe.label)!,
                                 image: (hitSelected?.recipe.image)!, 
                                 url: (hitSelected?.recipe.url)!,
                                 yield: (hitSelected?.recipe.yield)!,
                                 ingredientLines: (hitSelected?.recipe.ingredientLines)!,
                                 calories: (hitSelected?.recipe.calories)!)
            coreDataManager?.createItemOfFavorite(recipe: recipe)
        }
    }
}



extension DetailOfRecipePage: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (hitSelected?.recipe.ingredientLines.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "integride", for: indexPath)
        cell.textLabel?.text = "- " + (hitSelected?.recipe.ingredientLines[indexPath.row])!
        cell.textLabel?.backgroundColor = .black
        cell.textLabel?.textColor = .white
        return cell
    }
    
    // MARK: - Configuring the photo of favorite
    func setImageBarButton(){
        if isInFavorite {
            favoriteButton.setBackgroundImage(UIImage(named: "starG.png") ,for : UIControl.State.normal, barMetrics: .default)
        }
        else{
            favoriteButton.setBackgroundImage(UIImage(named: "star.png") ,for : UIControl.State.normal, barMetrics: .default)
        }
    }
}



