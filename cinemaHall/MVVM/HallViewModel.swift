//
//  HallView.swift
//  cinemaHall
//
//  Created by Jahongir Anvarov on 12.03.2025.
//

import Foundation

import UIKit

protocol HallViewModelProtocol {
    func loadData()
    func transferOrder(selectedSeats: [SeatWithPrice], totalView: TotalView)
    func calcTotalSum(seats: [SeatWithPrice])
}

final class HallViewModel: HallViewModelProtocol {
    
    // MARK: - Public properties
    
    var view: HallViewProtocol!
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
                    self.view.configureHall(sessionInfo: SessionInfo(date: "\(self.formatDate(session.sessionDate)) \(session.sessionTime)", hall: session.hallName, movieState: session.hasStartedText, freePlaces: String(freePlaces)), seatsType: session.seatsType)
                    self.view.configureSeats(seats: seatsWithPrices)
                }
                
            case .failure(let error):
                print("Ошибка: \(error.localizedDescription)")
            }
        }
    }
    
    func calcTotalSum(seats: [SeatWithPrice]) {
        view.updateHallView(totalPrice: seats.reduce(0) { $0 + $1.price })
    }
    
    func transferOrder(selectedSeats: [SeatWithPrice], totalView: TotalView) {
        router.navigateToOrderScreen(selectedSeats: selectedSeats, totalView: totalView)
    }
    
    func formatDate(_ date: Date) -> String {
        return DateFormatter.longDateFormat.string(from: date)
    }
}

