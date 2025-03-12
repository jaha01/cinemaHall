//
//  HallView.swift
//  cinemaHall
//
//  Created by Jahongir Anvarov on 12.03.2025.
//

import Foundation

import UIKit

protocol HallViewModelProtocol {
    var configureSeats: (([SeatWithPrice]) -> Void)? { get set }
    var configureHall: ((SessionInfo, [SeatType]) -> Void)? { get set }
    var updateHallView: ((Int) -> Void)? { get set}

    func loadData()
    func transferOrder(selectedSeats: [SeatWithPrice], totalView: TotalView)
    func calcTotalSum(seats: [SeatWithPrice])
    func canAddTickets(selectedSeats: [SeatWithPrice]) -> Bool 
}

final class HallViewModel: HallViewModelProtocol {
    
    // MARK: - Public properties
    
    var configureSeats: (([SeatWithPrice]) -> Void)?
    var configureHall: ((SessionInfo, [SeatType]) -> Void)?
    var updateHallView: ((Int) -> Void)?

    var router: RouterProtocol!
    
    // MARK: - Private properties
    private let networkService: NetworkManagerProtocol
    
    init(networkService: NetworkManagerProtocol) {
        self.networkService = networkService
    }
    
    // MARK: - Public methods
    
    func loadData() {
        networkService.request { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let session):
                
                let freePlaces = session.seats.filter { $0.bookedSeats == 0 }.count

                let seatsWithPrices = session.seats.compactMap { seat -> SeatWithPrice? in
                    guard let seatType = seat.seatType,
                          let seatInfo = session.seatsType.first(where: { $0.seatType == seatType })
                    else { return nil }
                    
                    return SeatWithPrice(seat: seat, price: seatInfo.price)
                }
                
                DispatchQueue.main.async {
                    self.configureHall?(SessionInfo(date: "\(self.formatDate(session.sessionDate)) \(session.sessionTime)", hall: session.hallName, movieState: session.hasStartedText, freePlaces: String(freePlaces)), session.seatsType)
                    self.configureSeats?(seatsWithPrices)
                }
                
            case .failure(let error):
                print("Ошибка: \(error.localizedDescription)")
            }
        }
    }
    
    func calcTotalSum(seats: [SeatWithPrice]) {
        self.updateHallView?(seats.reduce(0) { $0 + $1.price })
    }
    
    func transferOrder(selectedSeats: [SeatWithPrice], totalView: TotalView) {
        router.navigateToOrderScreen(selectedSeats: selectedSeats, totalView: totalView)
    }
 
    func canAddTickets(selectedSeats: [SeatWithPrice]) -> Bool {
        return selectedSeats.count < 5
    }
    
    // MARK: - Private Methods
    
    private func formatDate(_ date: Date) -> String {
        return DateFormatter.longDateFormat.string(from: date)
    }
}
