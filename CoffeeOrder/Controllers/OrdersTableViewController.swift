//
//  OrdersTableViewController.swift
//  CoffeeOrder
//
//  Created by Ivan Stoilov on 28.05.23.
//

import UIKit

class OrdersTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        populateOrders()
    }
    
    private func populateOrders() {
        guard let coffeeOrdersURL = URL(string: "https://warp-wiry-rugby.glitch.me/orders") else {
             fatalError("URL for coffee orders is incorrect")
         }
        
        let resource = Resource<[Order]>(url: coffeeOrdersURL )
        
        WebService().load(resource: resource) { result in
            switch result {
            case .success(let orders):
                print(orders)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
