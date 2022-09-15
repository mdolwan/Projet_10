//
//  CoreDataManager.swift
//  Recipes
//
//  Created by Mohammad Olwan on 06/04/2022.
//

import Foundation
import CoreData

final class CoreDataManager {
    
    // MARK: - Properties
    
    private let coreDataStack: CoreDataStack
    private let managedObjectContext: NSManagedObjectContext
    
    var recipe: [RecipesIntity] {
        let request: NSFetchRequest<RecipesIntity> = RecipesIntity.fetchRequest()
     
        guard let recipe = try? managedObjectContext.fetch(request) else { return [] }
        return recipe
    }
    
    // MARK: - Initializer
    
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
        self.managedObjectContext = coreDataStack.mainContext
    }
    
    // MARK: - Manage Task Entity
    
    func createItemOfFavorite(recipe: Recipe) {
        
        let newValue = RecipesIntity(context: managedObjectContext)
        newValue.label = recipe.label
        newValue.image = recipe.image
        newValue.url = recipe.url
        newValue.yield = Int32(recipe.yield)
        newValue.ingredientLines = recipe.ingredientLines  as NSObject
        newValue.calories = recipe.calories
        coreDataStack.saveContext()
        print("recipe saved")
    }
    
    
    func isExist(title:String)-> Bool{
        
        let request: NSFetchRequest<RecipesIntity> = RecipesIntity.fetchRequest()
        let predicate = NSPredicate(format: "label == %@", title)
        request.predicate = predicate
        let test = try? managedObjectContext.fetch(request)
        if test!.count > 0 {
            
            return true
            
        }else {
            return false }
        
    }
    
    func deleteFromFavoritete(title: String){
        
        let request: NSFetchRequest<RecipesIntity> = RecipesIntity.fetchRequest()
        let predicate = NSPredicate(format: "label == %@", title)
        request.predicate = predicate
        let test = try? managedObjectContext.fetch(request)
        let recipe = test![0]
        managedObjectContext.delete(recipe)
        do{
            try managedObjectContext.save()
            print("table deleted")
        }catch{
            print("error")
        }
    }
    
}

