//
//  NetworkFetchRequest.swift
//  TestINNOVATIONS
//
//  Created by dewill on 24.12.2019.
//  Copyright © 2019 lilcappucc. All rights reserved.
//

import Foundation


class NetworkDataFetcher {
    
    let networkService = NetworkService()
    
      func fetchDeclarations(searchTerm: String, completion: @escaping (ResponseModel?) -> ()) {
        
        networkService.request(searchTerm: searchTerm) { (data, error) in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                               completion(nil)
            }
            let decode = self.decodeJSON(type: ResponseModel.self, from: data)
            completion(decode)
        }
    }
    
    
      func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
          let decoder = JSONDecoder()
          guard let data = from else { return nil }
          
          do {
              let objects = try decoder.decode(type.self, from: data)
              return objects
          } catch let jsonError {
              print("Failed to decode JSON", jsonError)
              return nil
          }
      }
    
}
