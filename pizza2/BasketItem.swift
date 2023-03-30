//
//  BasketItem.swift
//  pizza2
//
//  Created by Alexey Ivanov on 30/3/23.
//

import Foundation

struct BasketItem: Codable {
    enum ProductType: String, Codable {
        case pizza
        case roll
    }
    let type: ProductType
    let title : String
    let imageLink: String
    let description: String
    let price : Float
}

extension BasketItem {
    init(pizza: Pizza, price: Float) {
        self.init(type: .pizza,
                  title: pizza.title,
                  imageLink: pizza.imageLink,
                  description: pizza.description,
                  price: price)
    }
    
    init(rolls: Rolls) {
        self.init(type: .roll,
                  title: rolls.title,
                  imageLink: rolls.imageLink,
                  description: rolls.description,
                  price: Float(rolls.cost))
    }
}
