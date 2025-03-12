//
//  Model.swift
//  cinemaHall
//
//  Created by Jahongir Anvarov on 06.03.2025.
//

import Foundation

struct Session: Decodable {
    let sessionDate: Date
    let sessionTime: String
    let mapWidth: Int
    let mapHeight: Int
    let hallName: String
    let merchantId: Int
    let hasOrzu: Bool
    let hasStarted: Bool
    let hasStartedText: String
    let seats: [Seat]
    let seatsType: [SeatType]
}

struct Seat: Decodable, Equatable {
    let seatId: Int
    let sector: String?
    let rowNum: String?
    let place: String?
    let top: Int
    let left: Int
    let bookedSeats: Int
    let seatView: String
    let placeName: String?
    let seatType: String?
    let objectType: String
    let objectDescription: String
    let objectTitle: String
}

struct SeatType: Decodable {
    let ticketId: Int
    let ticketType: String
    let name: String
    let price: Int
    let seatType: String
}

class CustomError: Error {
    var message: String
    init(message: String) {
        self.message = message
    }
}
