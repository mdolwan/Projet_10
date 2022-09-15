//
//  FavoritePage.swift
//  Recipes
//
//  Created by Mohammad Olwan on 15/03/2022.
//


import UIKit
import CoreData

class FavoritePage: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    private var coreDataManager: CoreDataManager?
    @IBOutlet weak var favoriteListTableView: UITableView!
    let favoriteEmptyLabel = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let coredataStack = appdelegate.coreDataStack
        coreDataManager = CoreDataManager(coreDataStack: coredataStack)
        
        favoriteListTableView.delegate = self
        favoriteListTableView.dataSource = self
        self.view.backgroundColor = UIColor.black
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoriteListTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        createLabel()
        return coreDataManager?.recipe.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellOfFavorite", for: indexPath) as? FavoriteCell else {
            return UITableViewCell()
        }
        // MARK: - Converte a row of table to Struct
        let recipe = Recipe.init(label: (coreDataManager?.recipe[indexPath.row].label!)!, image: (coreDataManager?.recipe[indexPath.row].image)!, url: (coreDataManager?.recipe[indexPath.row].url!)!, yield: Int((coreDataManager?.recipe[indexPath.row].yield)!), ingredientLines: coreDataManager?.recipe[indexPath.row].ingredientLines! as! [String], calories: (coreDataManager?.recipe[indexPath.row].calories)!)
        cell.configure(with: recipe)
        cell.textLabel?.backgroundColor = .black
        cell.textLabel?.textColor = .white
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            coreDataManager?.deleteFromFavoritete(title: (coreDataManager?.recipe[indexPath.row].label!)!)
            self.favoriteListTableView.deleteRows(at: [indexPath], with: .fade)
            favoriteListTableView.reloadData()
            createLabel()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailViewController = storyboard?.instantiateViewController(withIdentifier: "DetailedRecipe") as! DetailOfRecipePage
        let recipOfFavorite = Hit(recipe: .init(label: (coreDataManager?.recipe[indexPath.row].label!)!,
                                        image: (coreDataManager?.recipe[indexPath.row].image!)!,
                                        url: (coreDataManager?.recipe[indexPath.row].url!)!,
                                        yield: Int((coreDataManager?.recipe[indexPath.row].yield)!),
                                        ingredientLines: coreDataManager?.recipe[indexPath.row].ingredientLines as! [String],
                                        calories: (coreDataManager?.recipe[indexPath.row].calories)!))
        detailViewController.hitSelected = recipOfFavorite
        navigationController?.pushViewController(detailViewController, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175
    }
}

extension FavoritePage {
    
    // MARK: - To indicate that there are no recipe in favorite
    func createLabel(){
        if coreDataManager?.recipe.count == 0 {
            favoriteEmptyLabel.frame = CGRect(x: 0, y: 0, width: 250, height: 50)
            favoriteEmptyLabel.text = "There are no recipe in Favorite"
            favoriteEmptyLabel.center = self.view.center
            favoriteEmptyLabel.textAlignment = .center
            favoriteEmptyLabel.backgroundColor = UIColor.black
            favoriteEmptyLabel.textColor = UIColor.white
            self.view.addSubview(favoriteEmptyLabel)
        }
        else{
            favoriteEmptyLabel.removeFromSuperview()
        }
    }
}

