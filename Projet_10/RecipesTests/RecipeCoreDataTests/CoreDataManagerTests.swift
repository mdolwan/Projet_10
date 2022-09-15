//
//  CoreDataManagerTests.swift
//  RecipesTests
//
//  Created by Mohammad Olwan on 13/04/2022.
//


@testable import Recipes
import XCTest

final class CoreDataManagerTests: XCTestCase {
    
    // MARK: - Properties
    
    var coreDataStack: MockCoreDataStack!
    var coreDataManager: CoreDataManager!
    var recipeInstance = Recipe(label: "Pan con Tomate with Fried Eggs", image: "https://google.com", url: "http://image.google.com", yield: 2, ingredientLines: [ "4 thick slices of country style bread", "olive oil", "1 fat clove of garlic, peeled", "1 large ripe tomato, cut in half","4 large eggs","salt and pepper"], calories: 567)
    
    //MARK: - Tests Life Cycle
    
    override func setUp() {
        super.setUp()
        coreDataStack = MockCoreDataStack()
        coreDataManager = CoreDataManager(coreDataStack: coreDataStack)
    }
    
    override func tearDown() {
        super.tearDown()
        coreDataManager = nil
        coreDataStack = nil
    }
    
    // MARK: - Tests
    // RecipesIntity
    func testCreateItemOfFavoriteMethods_WhenAnEntityIsCreated_ThenShouldBeCorrectlySaved() {
        coreDataManager.createItemOfFavorite(recipe:recipeInstance)
        XCTAssertTrue(!coreDataManager.recipe.isEmpty)
        XCTAssertTrue(coreDataManager.recipe.count == 1)
        XCTAssertTrue(coreDataManager.recipe[0].label! == "Pan con Tomate with Fried Eggs")
    }
    
    func testDeletedeleteFromFavoriteteMethod_WhenAnEntityIsCreated_ThenShouldBeCorrectlyDeleted() {
        coreDataManager.createItemOfFavorite(recipe:recipeInstance)
        coreDataManager.deleteFromFavoritete(title: "Pan con Tomate with Fried Eggs")
        print(coreDataManager.recipe.isEmpty)
        XCTAssertTrue(coreDataManager.recipe.isEmpty)
    }
    
    func testIsExistRecipeMethod_ThenShouldGiveTrueValue(){
        
        coreDataManager.createItemOfFavorite(recipe:recipeInstance)
        print(coreDataManager.isExist(title: recipeInstance.label))
        XCTAssertTrue(coreDataManager.isExist(title: recipeInstance.label))
    }
    
    func testNotIsExistrecipeMethod_ThenShouldGiveFalseValue(){
        print(coreDataManager.isExist(title: "cheeze with Milk"))
        XCTAssertFalse(coreDataManager.isExist(title: "cheeze with Milk"))
    }
    
}
