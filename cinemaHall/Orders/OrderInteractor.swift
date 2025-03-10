//
//  OrderInteractor.swift
//  cinemaHall
//
//  Created by Jahongir Anvarov on 08.03.2025.
//

import Foundation

protocol OrderInteractorProtocol {
    func loadData()
    func goToPayment()
}

final class OrderInteractor: OrderInteractorProtocol {
    
    // MARK: - Public properties
    
    var presenter: OrderPresenterProtocol!
    var router: OrderRouter!
    var selectedSeats: [SeatWithPrice] = []
    
    // MARK: - Public methods
    
    func loadData() {
        presenter.passData(selectedSeats: selectedSeats, sum: selectedSeats.reduce(0) { $0 + $1.price })
    }
    
    func goToPayment() {
        router.showOrder(selectedSeats: selectedSeats)
    }
    
}
