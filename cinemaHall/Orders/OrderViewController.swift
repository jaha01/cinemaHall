//
//  OrderViewController.swift
//  cinemaHall
//
//  Created by Jahongir Anvarov on 07.03.2025.
//

import UIKit

protocol OrderViewControllerProtocol: AnyObject {
    func updateViews(selectedSeats: [SeatWithPrice], price: Int)
}

final class OrderViewController: UIViewController, OrderViewControllerProtocol, TotalViewDelegate {
    
    // MARK: - Public Properties
    
    var interactor: OrderInteractorProtocol!
    
    // MARK: - Private properties
    
    private let totalView = TotalView()
    private var selectedSeats: [SeatWithPrice] = []
    
    private lazy var ticketsList: UITableView = {
        let table = UITableView()
        table.register(OrderTableViewCell.self, forCellReuseIdentifier: OrderTableViewCell.cellIdentifier)
        table.delegate = self
        table.dataSource = self
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Мои билеты"
        view.backgroundColor = .systemBackground
        totalView.delegate = self
        interactor.loadData()
        setup()

    }
    
    // MARK: - Public methods
    
    func updateViews(selectedSeats: [SeatWithPrice], price: Int) {
        DispatchQueue.main.async { [weak self] in // MARK: - ЗДЕСЬ ПРАВИЛЬНО? или self.selectedSeats = selectedSeats выносим?
            guard let self = self else { return }
            self.selectedSeats = selectedSeats
            self.totalView.configure(price: price, bntName: "Оформить")
            self.ticketsList.reloadData()
        }
    }
    
    func didTapNextBtn() {
        interactor.goToPayment()
    }
    
    // MARK: - Private methods
    
    private func setup() {
        view.addSubview(ticketsList)
        view.addSubview(totalView)
        
        NSLayoutConstraint.activate([
            ticketsList.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            ticketsList.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            ticketsList.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            ticketsList.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            totalView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            totalView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            totalView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            totalView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
}


extension OrderViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedSeats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrderTableViewCell.cellIdentifier, for: indexPath) as! OrderTableViewCell
        cell.configure(seat: selectedSeats[indexPath.row])
        return cell
    }
    
}
