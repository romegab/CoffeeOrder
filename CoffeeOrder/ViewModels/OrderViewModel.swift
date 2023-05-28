//
//  OrderViewModel.swift
//  CoffeeOrder
//
//  Created by Ivan Stoilov on 28.05.23.
//

import Foundation

struct OrderViewModel {
    let order: Order
    
    var name: String {
        return order.name
    }
    
    var email: String {
        return order.email
    }
    
    var type: String {
        return order.type.rawValue.capitalized
    }
    
    var size: String {
        return order.size.rawValue.capitalized
    }
}
