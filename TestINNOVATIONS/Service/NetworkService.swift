//
//  NetworkService.swift
//  TestINNOVATIONS
//
//  Created by dewill on 24.12.2019.
//  Copyright © 2019 lilcappucc. All rights reserved.
//

import Foundation

class NetworkService {
    
    
    func request(searchTerm: String, completion: @escaping (Data?, Error?) -> Void){
        guard let url = URL(string: "https://public-api.nazk.gov.ua/v1/declaration/?q=\(searchTerm.encodeUrl)") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "get"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = createDataTask(from: request, completion: completion)
        task.resume()

    }
    
    
    private  func createDataTask(from request : URLRequest, completion: @escaping (Data? , Error?) -> Void) -> URLSessionDataTask {
        return  URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
}
