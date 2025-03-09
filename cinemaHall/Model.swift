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
    
    enum CodingKeys: String, CodingKey { // SnakKeys
        case sessionDate = "session_date"
        case sessionTime = "session_time"
        case mapWidth = "map_width"
        case mapHeight = "map_height"
        case hallName = "hall_name"
        case merchantId = "merchant_id"
        case hasOrzu = "has_orzu"
        case hasStarted = "has_started"
        case hasStartedText = "has_started_text"
        case seats
        case seatsType = "seats_type"
    }

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
    
    enum CodingKeys: String, CodingKey {
        case seatId = "seat_id"
        case sector
        case rowNum = "row_num"
        case place
        case top
        case left
        case bookedSeats = "booked_seats"
        case seatView = "seat_view"
        case placeName = "place_name"
        case seatType = "seat_type"
        case objectType = "object_type"
        case objectDescription = "object_description"
        case objectTitle = "object_title"
    }
}

struct SeatType: Decodable {
    let ticketId: Int
    let ticketType: String
    let name: String
    let price: Int
    let seatType: String
    
    enum CodingKeys: String, CodingKey {
        case ticketId = "ticket_id"
        case ticketType = "ticket_type"
        case name
        case price
        case seatType = "seat_type"
    }
}

// Сейчас Seat не содержит цену, поэтому добавим:
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

class CustomError: Error {
    var message: String
    init(message: String) {
        self.message = message
    }
}
