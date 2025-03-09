//
//  Interactor.swift
//  cinemaHall
//
//  Created by Jahongir Anvarov on 06.03.2025.
//

import Foundation
import UIKit

protocol InteractorProtocol {
    func loadData()
    func transferOrder(selectedSeats: [SeatWithPrice], totalView: TotalView)
}

final class Interactor: InteractorProtocol {
    
    // MARK: - Public properties
    
    var presenter: PresenterProtocol!
    var router: RouterProtocol!
    //    weak var delegate: SeatsDelegate?
    
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
                
                DispatchQueue.main.async {
                    self.presenter.prepareHall(session: SessionInfo(date: "\(self.formatDate(session.sessionDate)) \(session.sessionTime)", hall: session.hallName, movieState: session.hasStartedText, freePlaces: String(freePlaces)), seatsType: session.seatsType)
                }
                let seatsWithPrices = session.seats.compactMap { seat -> SeatWithPrice? in
                    guard let seatType = seat.seatType,
                          let seatInfo = session.seatsType.first(where: { $0.seatType == seatType })
                    else { return nil }
                    
                    return SeatWithPrice(seat: seat, price: seatInfo.price)
                }
                
                DispatchQueue.main.async {
                    self.presenter.prepareSeats(seats: seatsWithPrices)
                }
                
            case .failure(let error):
                print("Ошибка: \(error.localizedDescription)")
            }
        }
    }
    
    func transferOrder(selectedSeats: [SeatWithPrice], totalView: TotalView) {
        router.navigateToOrderScreen(selectedSeats: selectedSeats, totalView: totalView)
    }
    
    func formatDate(_ date: Date) -> String {
        return DateFormatter.customDateFormatter.string(from: date)
    }
}


extension DateFormatter {
    static let customDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long // Это будет использовать формат "9 марта 2025"
        formatter.locale = Locale(identifier: "ru_RU") // Устанавливаем русскую локализацию
        return formatter
    }()
}
