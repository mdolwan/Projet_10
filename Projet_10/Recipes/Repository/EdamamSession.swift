//
//  ITunesSession.swift
//  Recipes
//
//  Created by Mohammad Olwan on 08/04/2022.
//

import Foundation
import Alamofire

protocol AlamofireSession {
    func request(url: URL, callback: @escaping (AFDataResponse<RecipesSearch>) -> Void)
}

final class EdamamSession: AlamofireSession {
    func request<T: Decodable>(url: URL, callback: @escaping (DataResponse<T, AFError>) -> Void) {
        AF.request(url).responseDecodable { (response: DataResponse<T, AFError>) in
            callback(response)
        }
    }
}
