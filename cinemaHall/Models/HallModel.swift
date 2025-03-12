//
//  HallModel.swift
//  cinemaHall
//
//  Created by Jahongir Anvarov on 12.03.2025.
//

import Foundation

struct SeatWithPrice: Equatable {
    let seat: Seat
    let price: Int
}


struct SessionInfo {
    let date: String
    let hall: String
    let movieState: String
    let freePlaces: String
}
