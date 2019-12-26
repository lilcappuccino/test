//
//  NetworkFetchRequest.swift
//  TestINNOVATIONS
//
//  Created by dewill on 24.12.2019.
//  Copyright © 2019 lilcappucc. All rights reserved.
//

import Foundation

enum Response {
    case success (result: ResponseModel)
    case failure (error: Error?)
}


class NetworkDataFetcher {
    
    let networkService = NetworkService()
    
      func fetchDeclarations(searchTerm: String, completion: @escaping (Response?) -> ()) {
        
        networkService.request(searchTerm: searchTerm) { (data, error) in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                               completion(nil)
            }
            let decode = self.decodeJSON(type: ResponseModel.self, from: data)
            completion(decode)
        }
    }
    
    
      func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> Response {
          let decoder = JSONDecoder()
        guard let data = from else { return Response.failure(error: nil) }
          
          do {
              let objects = try decoder.decode(type.self, from: data)
            return  Response.success(result: objects as! ResponseModel)
          } catch let jsonError {
              print("Failed to decode JSON", jsonError)
               return Response.failure(error: nil)
          }
      }
    
}
