//
//  searchPage.swift
//  Recipes
//
//  Created by Mohammad Olwan on 14/04/2022.
//

import Foundation

struct RecipesSearch: Codable {
    let links: Links
    let hits: [Hit]
    
    enum CodingKeys: String, CodingKey {
        case links = "_links"
        case hits
    }
}

// MARK: - Hit
struct Hit: Codable {
    let recipe: Recipe
}

// MARK: - Recipe
struct Recipe: Codable {
    let label: String
    let image: String
    let url: String
    let yield: Int
    let ingredientLines: [String]
    let calories: Double
}

// MARK: - Links
struct Links: Codable {
    let next: Next?
}

// MARK: - Next
struct Next: Codable {
    let href: String?
    let title: String?
}

