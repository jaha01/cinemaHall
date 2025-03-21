//
//  OrderPresenter.swift
//  cinemaHall
//
//  Created by Jahongir Anvarov on 08.03.2025.
//

import Foundation

protocol OrderPresenterProtocol {
    func passData(selectedSeats: [SeatWithPrice], sum: Int)
}

final class OrderPresenter: OrderPresenterProtocol {
    // MARK: - Public properties
   
    var viewController: OrderViewControllerProtocol!
    
    // MARK: - Public methods
    
    func passData(selectedSeats: [SeatWithPrice], sum: Int) {
        viewController.updateViews(selectedSeats: selectedSeats, price: sum)
    }
}
