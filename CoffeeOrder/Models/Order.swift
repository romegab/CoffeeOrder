//
//  Order.swift
//  CoffeeOrder
//
//  Created by Ivan Stoilov on 28.05.23.
//

import Foundation

enum CoffeeType: String, Codable, CaseIterable {
    case cappuccino
    case latte
    case espresso
    case cortado
}

enum CoffeeSize: String, Codable, CaseIterable {
    case small
    case medium
    case large
}

struct Order: Codable {
    
    let name: String
    let email: String
    let type: CoffeeType
    let size: CoffeeSize
    
}

extension Order {
    
    static var all: Resource<[Order]> = {
        
        guard let url = URL(string: "https://warp-wiry-rugby.glitch.me/orders") else {
            fatalError("The url is incorect")
        }
        
        return Resource<[Order]>(url: url)
    }()
    
    static func create(_ viewModel: AddCoffeeOrderViewModel) -> Resource<Order?> {
          
        let order = Order(viewModel)
        
        guard let url = URL(string: "https://warp-wiry-rugby.glitch.me/orders") else {
            fatalError("The url is incorect")
        }
        
        guard let data = try?JSONEncoder().encode(order) else {
            fatalError("Encoding error")
        }
        
        var resource = Resource<Order?>(url: url)
        resource.httpMethod = .post
        resource.body = data
        
        return resource
    }
}

extension Order {
    
    init?(_ viewModel: AddCoffeeOrderViewModel) {
        
        guard let name = viewModel.name,
              let email = viewModel.emai,
              let selectedType = CoffeeType(rawValue: viewModel.selectedType!.lowercased()),
              let selectedSize = CoffeeSize(rawValue: viewModel.selectedSize!.lowercased()) else {
            return nil
        }
        
        self.name = name
        self.email = email
        self.type = selectedType
        self.size = selectedSize
    }
    
}
