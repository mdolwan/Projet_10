//
//  RequestService.swift
//  Recipes
//
//  Created by Mohammad Olwan on 08/04/2022.
//

import Foundation

final class RequestService {
    
    // MARK: - Properties
    private let session: AlamofireSession
    static var TermSearched:[String] = []
    // MARK: - Initializer
    var isPagination: Bool = false
    var urlOrigin = "https://api.edamam.com/api/recipes/v2?app_key=5e7f04a3e17119880911425a28facd3c&type=public&app_id=8a76e4ee&q="
    var url: URL!
    
    init(session: AlamofireSession = EdamamSession() ) {
        self.session = session
    }
    
    // MARK: - Management
    func getRecipe(Pagination: Bool, getUrl:String, callback: @escaping (Result<RecipesSearch, RecipeError>) -> Void) {
        
        if !Pagination{
            urlOrigin += getTermfromArray()
            url = URL(string: urlOrigin)
        }else{
            url = URL(string: getUrl)
            isPagination = true
        }
        session.request(url: self.url) { [ self] dataResponse in
            guard let data = dataResponse.data else {
                callback(.failure(.noData))
                return
            }
            guard dataResponse.response?.statusCode == 200 else {
                callback(.failure(.invalidResponse))
                return
            }
            guard let dataDecoded = try? JSONDecoder().decode(RecipesSearch.self, from: data) else {
                callback(.failure(.undecodableData))
                return
            }
            callback(.success(dataDecoded))
            if Pagination {
                isPagination = false
            }
        }
    }
    
    func traitTermTypedTextField(text: String)->[String]{
        
        var tempArray:[String] = []
        var  elements: [String] {
            text.components(separatedBy: ",")
        }
        for element in elements {
            let element = element.trimmingCharacters(in: .whitespacesAndNewlines)
            tempArray.append(element)
            if tempArray.last == "" {tempArray.removeLast()}
        }
        return tempArray
    }
    func getTermfromArray()-> String {
        
        let q = RequestService.TermSearched.joined(separator: ",")
        return q
    }
}
