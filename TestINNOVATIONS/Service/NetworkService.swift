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
        let params = preapreParams(searchTerm: searchTerm)
        guard let url = self.url(params: params) else { return }
        print(url)
        var request = URLRequest(url: url)
        request.httpMethod = "get"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = createDataTask(from: request, completion: completion)
        task.resume()

    }
    

    private func preapreParams(searchTerm: String) -> [String: String] {
        var params =  [String: String]()
        params["q"] = searchTerm.encodeUrl
        return params
    }

    private func url(params: [String: String]) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "public-api.nazk.gov.ua"
        components.path = "/v1/declaration"
        components.queryItems = params.map{ URLQueryItem(name: $0, value: $1) }
        return components.url
    }
    
    
    private  func createDataTask(from request : URLRequest, completion: @escaping (Data? , Error?) -> Void) -> URLSessionDataTask {
        return  URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
}
