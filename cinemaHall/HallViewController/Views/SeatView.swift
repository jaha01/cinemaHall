//
//  SeatView.swift
//  cinemaHall
//
//  Created by Jahongir Anvarov on 06.03.2025.
//

import UIKit

protocol SeatViewDelegate: AnyObject {
    func didTapSeat(seatWithPrice: SeatWithPrice)
    func alertBookedSeat()
}

final class SeatView: UIButton {
    
    // MARK: - Public properties
    
    weak var delegate: SeatViewDelegate?
    
    // MARK: - Private properties
    
    private static let selectedColor = UIColor.green
    var seatWithPrice: SeatWithPrice
    private var initialImage: UIImage?
    
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
//        backgroundColor = seatColor()
        
//        if seat.bookedSeats == 1 {
//            backgroundColor = .lightGray
//            isEnabled = false
//        }
        
        addTarget(self, action: #selector(seatTapped), for: .touchUpInside)
        seatImages()
    }
    
    @objc private func seatTapped() {
        if seatWithPrice.seat.bookedSeats > 0 {
            delegate?.alertBookedSeat()
        } else {
            delegate?.didTapSeat(seatWithPrice: seatWithPrice)
            tappedButton()
        }
    }
    
    private func seatColor() -> UIColor {
        switch seatWithPrice.seat.seatType {
        case "VIP": return .red
        case "COMFORT": return .blue
        case "STANDARD": return .lightGray
        default: return .darkGray
        }
    }
    
    private func seatImages() {
        
        if seatWithPrice.seat.bookedSeats > 0 {
            setImage(UIImage(named: "seat-busy"), for: .normal)
            return
        }
        
        switch seatWithPrice.seat.seatType {
        case "VIP": setImage(UIImage(named: "seat-vip"), for: .normal)
        case "COMFORT": setImage(UIImage(named: "seat-default"), for: .normal)
        case "STANDARD": setImage(UIImage(named: "seat-default"), for: .normal)
        default: return setImage(UIImage(named: ""), for: .normal)
        }
    }

    func tappedButton() {
        if initialImage == nil {
            initialImage = currentImage
        }
        
        let isSelected = currentImage == UIImage(named: "seat-selected")
        let newImage = isSelected ? initialImage : UIImage(named: "seat-selected")
        setImage(newImage, for: .normal)
    }
}
