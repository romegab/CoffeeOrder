//
//  AddCoffeeOrderViewModel.swift
//  CoffeeOrder
//
//  Created by Ivan Stoilov on 28.05.23.
//

import Foundation

struct AddCoffeeOrderViewModel {
    
    var name: String?
    var emai: String?
    
    var selectedType: String?
    var selectedSize: String?
    
    var types: [String] {
        CoffeeType.allCases.map {
            $0.rawValue.capitalized
        }
    }
    
    var sizes: [String] {
        CoffeeSize.allCases.map {
            $0.rawValue.capitalized
        }
    }
    
}
