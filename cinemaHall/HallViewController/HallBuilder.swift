//
//  Builder.swift
//  cinemaHall
//
//  Created by Jahongir Anvarov on 06.03.2025.
//

import UIKit

final class HallBuilder {
    
    func build() -> UIViewController {
        let controller = HallViewController()
        let interactor = HallInteractor(networkService: DI.shared.networkClient)
        let presenter = HallPresenter()
        let router = HallRouter()
        
        controller.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = controller
        router.viewController = controller
        interactor.router = router
        
        return controller
    }
}
