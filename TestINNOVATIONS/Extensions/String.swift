//
//  String.swift
//  TestINNOVATIONS
//
//  Created by dewill on 24.12.2019.
//  Copyright © 2019 lilcappucc. All rights reserved.
//

import Foundation


//Fix problem with Cyrillic symbols in URL
extension String{
    var encodeUrl : String
    {
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    }
    var decodeUrl : String
    {
        return self.removingPercentEncoding!
    }
}
