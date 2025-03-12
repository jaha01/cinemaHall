//
//  HallBuilderr.swift
//  cinemaHall
//
//  Created by Jahongir Anvarov on 12.03.2025.
//

import UIKit

final class HallBuilderr {
    
    func build() -> UIViewController {
        
        let controller = HallVieww()
        let viewModel = HallViewModel(networkService: DI.shared.networkClient)
        let router = HallRouter()
        
        controller.viewModel = viewModel
        viewModel.view = controller
        router.viewController = controller
        viewModel.router = router
        
        return controller
    }
}
