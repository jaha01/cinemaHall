//
//  HallBuilderr.swift
//  cinemaHall
//
//  Created by Jahongir Anvarov on 12.03.2025.
//

import UIKit

final class HallBuilder {
    
    func build() -> UIViewController {
        let viewModel = HallViewModel(networkService: DI.shared.networkClient)
        let controller = HallViewController(viewModel: viewModel)
        let router = HallRouter()
        
        router.viewController = controller
        viewModel.router = router
        
        return controller
    }
}
