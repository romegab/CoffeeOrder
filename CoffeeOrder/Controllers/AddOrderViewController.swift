//
//  AddOrderViewController.swift
//  CoffeeOrder
//
//  Created by Ivan Stoilov on 28.05.23.
//

import UIKit

protocol AddOrderViewControllerDelegate: AnyObject {
    func handleOrderCreation(order: Order)
}

class AddOrderViewController: UIViewController {
    
    var viewModel = AddCoffeeOrderViewModel()
    
    weak var delegate: AddOrderViewControllerDelegate?
    
    private var coffeeSizesSegementedControl: UISegmentedControl!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var emailTextField: UITextField!
    
    @IBAction private func saveButtonTapped(_ sender: Any) {
        
        let name = nameTextField.text
        let email = emailTextField.text
        
        let selectedSize = coffeeSizesSegementedControl.titleForSegment(at: coffeeSizesSegementedControl.selectedSegmentIndex)
        
        guard let coffeeTypeIndexPath = tableView.indexPathForSelectedRow?.row else {
            fatalError("No coffee type is selected")
        }
        
        viewModel.name = name
        viewModel.emai = email
        viewModel.selectedSize = selectedSize
        viewModel.selectedType = viewModel.types[coffeeTypeIndexPath]
        
        WebService().load(resource: Order.create(viewModel)) { result in
            switch result {
            case .success(let order):
                guard let order = order else { return }
                
                DispatchQueue.main.async { [weak self] in
                    self?.delegate?.handleOrderCreation(order: order)

                }
            case .failure(let error):
                print(error)
                
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupUI() {
        self.coffeeSizesSegementedControl = UISegmentedControl(items: viewModel.sizes)
        self.coffeeSizesSegementedControl.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(coffeeSizesSegementedControl)
        coffeeSizesSegementedControl.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 20.0).isActive = true
        coffeeSizesSegementedControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
}

extension AddOrderViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
}

extension AddOrderViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.types.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CoffeeTypeTableViewCell") else {
            fatalError("No cell found for coffee type")
        }
        
        cell.textLabel?.text = viewModel.types[indexPath.row]
        
        return cell
    }
    
}
