//
//  FakeEdamamSession.swift
//  RecipesTests
//
//  Created by Mohammad Olwan on 13/04/2022.
//

import Foundation
import Alamofire
@testable import Recipes

struct FakeResponse {
    var response: HTTPURLResponse?
    var data: Data?
}

//
final class FakeEdamamSession: AlamofireSession {
    
    // MARK: - Properties

    private let fakeResponse: FakeResponse

    // MARK: - Initializer

    init(fakeResponse: FakeResponse) {
        self.fakeResponse = fakeResponse
    }
    var recipe = RecipesSearch(links: .init(next: .init(href: "", title: "")), hits: .init())
    // MARK: - Methods

    func request(url: URL, callback: @escaping (AFDataResponse<RecipesSearch>) -> Void) {
        let dataResponse = AFDataResponse<RecipesSearch>( request: nil, response: fakeResponse.response, data: fakeResponse.data, metrics: nil, serializationDuration: 0, result: .success(recipe))
        callback(dataResponse)
    }
}
