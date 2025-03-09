//
//  OrderViewController.swift
//  cinemaHall
//
//  Created by Jahongir Anvarov on 07.03.2025.
//

import UIKit

protocol OrderViewControllerProtocol: AnyObject {
    
}

final class OrderViewController: UIViewController, OrderViewControllerProtocol {
    
    // MARK: - Public Properties
    
    var interactor: OrderInteractorProtocol!
    var selectedSeats: [SeatWithPrice] = []
    var totalView: TotalView!
    
    private lazy var ticketsList: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.delegate = self
        table.dataSource = self
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Мои билеты"
        view.backgroundColor = .systemBackground
        setup()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setup()
        print("selectedSeats = \(selectedSeats)")
    }
    
    // MARK: - Private methods
    
    private func setup() {
        view.addSubview(ticketsList)
        view.addSubview(totalView)
        totalView.nextBtn.setTitle("Оформить", for: .normal)
        totalView.nextBtn.addTarget(self, action: #selector(order), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            ticketsList.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            ticketsList.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            ticketsList.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            totalView.topAnchor.constraint(equalTo: ticketsList.bottomAnchor),
            totalView.leadingAnchor.constraint(equalTo: ticketsList.leadingAnchor),
            totalView.trailingAnchor.constraint(equalTo: ticketsList.trailingAnchor),
            totalView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc private func order() {
        interactor.goToPayment(totalView: totalView)
    }
    
    // MARK: - Public methods
    
}


extension OrderViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedSeats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = "ряд \(selectedSeats[indexPath.row].seat.rowNum!), место: \(selectedSeats[indexPath.row].seat.place!)                                         цена: \(selectedSeats[indexPath.row].price)"
        return cell
    }
    
}
