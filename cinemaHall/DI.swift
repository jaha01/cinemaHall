//
//  DI.swift
//  cinemaHall
//
//  Created by Jahongir Anvarov on 06.03.2025.
//

import Foundation

final class DI {
    
    static let shared = DI()

    lazy var networkClient: NetworkManager = {
        return NetworkManager()
    }()
    
}
