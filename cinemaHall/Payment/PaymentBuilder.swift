//
//  PaymentBuilder.swift
//  cinemaHall
//
//  Created by Jahongir Anvarov on 09.03.2025.
//

import UIKit

final class PaymentBuilder {
    
    func build(selectedSeats: [SeatWithPrice]) -> UIViewController {
        let controller = PaymentViewController()
        let interactor = PaymentInteractor()
        let presenter = PaymentPresenter()
        
        controller.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = controller
        interactor.selectedSeats = selectedSeats
        
        return controller
    }
}
