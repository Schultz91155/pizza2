//
//  BusketModel.swift
//  pizza2
//
//  Created by admin on 29.03.2023.
//

import Foundation

class Basket {
    static let shared = Basket()
    static let key = "Basket"
    
    private let userDefaults: UserDefaults
    private(set) var items: [BasketItem]
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
        self.items = [BasketItem]()
        setup()
    }

    
    private func setup() {
        self.items = self.read()
    }
    
    func add(pizza: Pizza, price: Float) {
        let item = BasketItem(pizza: pizza, price: price)
        add(item: item)
    }
    
    func add(rolls: Rolls) {
        let item = BasketItem(rolls: rolls)
        add(item: item)
    }
    
    func add(item: BasketItem) {
        items.append(item)
        save()
    }
    
    func read() -> [BasketItem] {
        guard
            let data = UserDefaults.standard.data(forKey: Basket.key),
            let items = try? PropertyListDecoder().decode([BasketItem].self, from: data)
        else { return [] }
        return items
    }
    
    func save(){
        do{
            let data = try PropertyListEncoder().encode(items)
            UserDefaults.standard.set(data, forKey: Basket.key)
        }
        catch{
            print(error)
        }
    }
}
