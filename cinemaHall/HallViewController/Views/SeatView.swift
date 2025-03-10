//
//  SeatView.swift
//  cinemaHall
//
//  Created by Jahongir Anvarov on 06.03.2025.
//

import UIKit

protocol SeatViewDelegate: AnyObject {
    func didTapSeat(seatWithPrice: SeatWithPrice)
}

final class SeatView: UIButton {
    
    // MARK: - Public properties
    
    weak var delegate: SeatViewDelegate?
    
    // MARK: - Private properties
    
    private static let selectedColor = UIColor.green
    private let seatWithPrice: SeatWithPrice
    
    init(seatWithPrice: SeatWithPrice) {
        self.seatWithPrice = seatWithPrice
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func setupView() {
        let seat = seatWithPrice.seat
        setTitle(seat.place ?? "?", for: .normal)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 12, weight: .bold)
        
        layer.cornerRadius = 8
        layer.masksToBounds = true
        backgroundColor = seatColor()
        
        if seat.bookedSeats == 1 {
            backgroundColor = .lightGray
            isEnabled = false
        }
        
        addTarget(self, action: #selector(seatTapped), for: .touchUpInside)
    }
    
    @objc private func seatTapped() {
//        let seat = seatWithPrice.seat
//        let price = seatWithPrice.price MARK: - DELETEEEEEE
        delegate?.didTapSeat(seatWithPrice: seatWithPrice)
        backgroundColor = backgroundColor == SeatView.selectedColor ? seatColor() : SeatView.selectedColor
    }
    
    private func seatColor() -> UIColor {
        switch seatWithPrice.seat.seatType {
        case "VIP": return .red
        case "COMFORT": return .blue
        case "STANDARD": return .lightGray
        default: return .darkGray
        }
    }
}
