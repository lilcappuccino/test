//
//  ResponseModel.swift
//  TestINNOVATIONS
//
//  Created by dewill on 24.12.2019.
//  Copyright © 2019 lilcappucc. All rights reserved.
//

import Foundation

struct ResponseModel: Codable {
    let page: PageResponseModel
    let items: [ItemResponseModel]
}

struct PageResponseModel: Codable {
    let batchSize, currentPage: Int
    let totalItems: String
    
}

struct ItemResponseModel: Codable {
    let id, firstname, lastname, placeOfWork: String
    let linkPDF, position: String?
}
