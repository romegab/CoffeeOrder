//
//  OrderListViewModel.swift
//  CoffeeOrder
//
//  Created by Ivan Stoilov on 28.05.23.
//

import Foundation

class OrderListViewModel {
    var orders: [OrderViewModel]
    
    init() {
        self.orders = []
    }
}

extension OrderListViewModel {
    func orderViewModel(at index: Int) -> OrderViewModel {
        return self.orders[index ]
    }
}
