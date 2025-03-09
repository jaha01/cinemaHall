//
//  Presenter.swift
//  cinemaHall
//
//  Created by Jahongir Anvarov on 06.03.2025.
//

import Foundation

protocol PresenterProtocol {
    func prepareSeats(seats: [SeatWithPrice])
    func prepareHall(session: SessionInfo, seatsType: [SeatType])
}

final class Presenter: PresenterProtocol {
    // MARK: - Public properties
    var viewController: ViewControllerProtocol!
    
    // MARK: - Public methods
    
    func prepareHall(session: SessionInfo, seatsType: [SeatType]) {
        viewController.configureHall(sessionInfo: session, seatsType: seatsType)
    }
    
    func prepareSeats(seats: [SeatWithPrice]) {
        viewController.configureSeats(seats: seats)
    }
}
