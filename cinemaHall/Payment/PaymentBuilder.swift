//
//  PaymentBuilder.swift
//  cinemaHall
//
//  Created by Jahongir Anvarov on 09.03.2025.
//

import UIKit

final class PaymentBuilder {
    
    func build(totalView: TotalView) -> UIViewController {
        let controller = PaymentViewController()
        let interactor = PaymentInteractor()
        let presenter = PaymentPresenter()
        
        controller.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = controller
        controller.totalView = totalView
        
        return controller
    }
}
