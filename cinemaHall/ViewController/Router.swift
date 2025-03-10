//
//  Router.swift
//  cinemaHall
//
//  Created by Jahongir Anvarov on 06.03.2025.
//

import UIKit
import Foundation

protocol RouterProtocol {
    func navigateToOrderScreen(selectedSeats: [SeatWithPrice], totalView: TotalView)
}

final class Router: RouterProtocol {
    
    // MARK: - Public properties
    
    var viewController: UIViewController!

    // MARK: - Public methods
    
    func navigateToOrderScreen(selectedSeats: [SeatWithPrice], totalView: TotalView) {
        let orderVC = OrderBuilder().build(selectedSeats: selectedSeats)
        let navigationController = viewController.navigationController
        navigationController?.pushViewController(orderVC, animated: true)
    }
}
