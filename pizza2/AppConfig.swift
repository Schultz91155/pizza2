//
//  AppConfig.swift
//  pizza2
//
//  Created by admin on 24.03.2023.
//

import Foundation

struct AppConfig : Codable{

    let productList : ProductList
    
    struct ProductList : Codable {
        let pizzaList : [Pizza]
        let rollsList : [Rolls]
        let promotionList : [Promotion]
    }
}
