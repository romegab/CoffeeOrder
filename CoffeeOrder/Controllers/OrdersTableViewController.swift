//
//  OrdersTableViewController.swift
//  CoffeeOrder
//
//  Created by Ivan Stoilov on 28.05.23.
//

import UIKit

class OrdersTableViewController: UITableViewController {
    
    var viewModel = OrderListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        populateOrders()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navigationController = segue.destination as? UINavigationController,
              let controller = navigationController.viewControllers.first as? AddOrderViewController else {
            return
        }
        
        controller.delegate = self
    }
    
    private func populateOrders() {
        
        WebService().load(resource: Order.all) { [weak self] result in
            switch result  {
            case .success(let orders):
                self?.viewModel.orders = orders.map(OrderViewModel.init)
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.orders.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let order = viewModel.orderViewModel(at: indexPath.row)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTableViewCell", for: indexPath)
        
        cell.textLabel?.text = order.type
        cell.detailTextLabel?.text = order.size
        
        return cell
    }
    
}

extension OrdersTableViewController: AddOrderViewControllerDelegate {
    func handleOrderCreation(order: Order) {
        viewModel.orders.append(OrderViewModel(order: order))
        
        self.tableView.reloadData()
    }
}
