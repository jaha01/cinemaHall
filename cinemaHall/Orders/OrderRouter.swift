//
//  OrderRouter.swift
//  cinemaHall
//
//  Created by Jahongir Anvarov on 09.03.2025.
//

import UIKit

protocol OrderRouterProtocol {
    func showOrder(totalView: TotalView)
}

final class OrderRouter: OrderRouterProtocol {
    
    // MARK: - Public properties
    
    var viewController: UIViewController!
    
     func showOrder(totalView: TotalView) {
         guard let controller = viewController else { return }
         let paymentVC = PaymentBuilder().build(totalView: totalView)
         let nav = UINavigationController(rootViewController: paymentVC)
         nav.navigationBar.backgroundColor = .white
         controller.present(nav, animated: true, completion: nil)
     }
    
}
