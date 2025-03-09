//
//  Router.swift
//  cinemaHall
//
//  Created by Jahongir Anvarov on 06.03.2025.
//

import UIKit
import Foundation

protocol RouterProtocol {
    func navigateToOrderScreen(selectedSeats: [SeatWithPrice], totalView: TotalView)
}

final class Router: RouterProtocol {
    
    // MARK: - Public properties
    
    var viewController: UIViewController!
    
//    func prepareOrder(selectedSeats: [SeatWithPrice]) {
//        guard let controller = viewController as? ViewController else { return }
//        let tableVC = OrderBuilder().build() as! OrderViewController
//        tableVC.selectedSeats = selectedSeats // Передаем обновленные данные
//
//        // Устанавливаем делегат, чтобы обновить данные
////        tableVC.seatsDelegate = controller
//
//        let nav = UINavigationController(rootViewController: tableVC)
//        nav.navigationBar.backgroundColor = .white
//
//        if let sheet = nav.sheetPresentationController {
//            sheet.detents = [.medium()]
//            sheet.preferredCornerRadius = 25
//            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
//            sheet.prefersGrabberVisible = true
//        }
//
//        viewController.present(nav, animated: true, completion: nil)
//    }
       

    func navigateToOrderScreen(selectedSeats: [SeatWithPrice], totalView: TotalView) {
        totalView.removeTargets()
        let orderVC = OrderBuilder().build(selectedSeats: selectedSeats, totalView: totalView)
        let navigationController = viewController.navigationController
        navigationController?.pushViewController(orderVC, animated: true)
    }
}
