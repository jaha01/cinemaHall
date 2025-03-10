//
//  PaymentInteractor.swift
//  cinemaHall
//
//  Created by Jahongir Anvarov on 09.03.2025.
//

import Foundation

protocol PaymentInteractorProtocol {
    func loadData()
}

final class PaymentInteractor: PaymentInteractorProtocol {
    
    // MARK: - Public Properties
    
    var presenter: PaymentPresenterProtocol!
    var selectedSeats: [SeatWithPrice] = []
    
    // MARK: - Public methods
    
    func loadData() {
        presenter.setPrice(sum: selectedSeats.reduce(0) { $0 + $1.price })
    }

}
