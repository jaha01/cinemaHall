//
//  OrderRouter.swift
//  cinemaHall
//
//  Created by Jahongir Anvarov on 09.03.2025.
//

import UIKit

protocol OrderRouterProtocol {
    func showOrder(selectedSeats: [SeatWithPrice])
}

final class OrderRouter: OrderRouterProtocol {
    
    // MARK: - Public properties
    
    var viewController: UIViewController!
    
    // MARK: - Public methods
    
     func showOrder(selectedSeats: [SeatWithPrice]) {
         guard let controller = viewController else { return }
         let paymentVC = PaymentBuilder().build(selectedSeats: selectedSeats)
         let nav = UINavigationController(rootViewController: paymentVC)
         nav.navigationBar.backgroundColor = .white
         controller.present(nav, animated: true, completion: nil)
     }
    
}
