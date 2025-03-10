//
//  OrderBuilder.swift
//  cinemaHall
//
//  Created by Jahongir Anvarov on 08.03.2025.
//

import UIKit

final class OrderBuilder {
    
    func build(selectedSeats: [SeatWithPrice]) -> UIViewController {
        let controller = OrderViewController()
        let interactor = OrderInteractor()
        let presenter = OrderPresenter()
        let router = OrderRouter()
        
        controller.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = controller
        interactor.selectedSeats = selectedSeats
        router.viewController = controller
        interactor.router = router
        
        return controller
    }
}
