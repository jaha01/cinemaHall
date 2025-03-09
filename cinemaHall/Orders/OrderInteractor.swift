//
//  OrderInteractor.swift
//  cinemaHall
//
//  Created by Jahongir Anvarov on 08.03.2025.
//

import Foundation

protocol OrderInteractorProtocol {
    func goToPayment(totalView: TotalView)
}

final class OrderInteractor: OrderInteractorProtocol {
    
    // MARK: - Public properties
    
    var presenter: OrderPresenterProtocol!
    var router: OrderRouter!
    
    // MARK: - Private properties

    
    // MARK: - Public methods
    
    func goToPayment(totalView: TotalView) {
        router.showOrder(totalView: totalView)
    }
    
}
