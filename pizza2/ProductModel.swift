//
//  ProductModel.swift
//  pizza2
//
//  Created by admin on 24.03.2023.
//

import Foundation

protocol Product : Codable{
    
    var title : String { get }
    var imageLink: String {get}
   
}

struct Pizza : Codable, Product{
    
    let title: String
    let imageLink: String
    let description: String
    let price : Price
    let dough : Dough
    
    struct Price : Codable{
        let small: Int?
        let medium : Int?
        let large : Int?
    }
    
    struct Dough : Codable{
        let traditional : String?
        let slim: String?
    }

}

struct Rolls : Codable, Product{
    
    let title: String
    let cost: Int
    let imageLink: String
    let description: String
    let wieght : String
}

struct Promotion : Codable, Product{
    
    let title: String
    let imageLink: String
}


