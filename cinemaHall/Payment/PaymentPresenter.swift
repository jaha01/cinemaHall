//
//  PaymentPresenter.swift
//  cinemaHall
//
//  Created by Jahongir Anvarov on 09.03.2025.
//

import Foundation

protocol PaymentPresenterProtocol {
    func setPrice(sum: Int)
}

final class PaymentPresenter: PaymentPresenterProtocol {
    
    // MARK: - Public Properties
    
    var viewController: PaymentViewControllerProtocol!
    
    // MARK: - Public methods
    
    func setPrice(sum: Int) {
        viewController.updateTotalView(price: sum)
    }
}
