//
//  OrderTableViewCell.swift
//  cinemaHall
//
//  Created by Jahongir Anvarov on 10.03.2025.
//

import UIKit

class OrderTableViewCell: UITableViewCell {

    static let cellIdentifier = "OrderTableViewCell"
    
    // MARK: - Private properties
    
    private let placeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Gill Sans SemiBold", size: 18)!
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Gill Sans SemiBold", size: 18)!
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public properties
    
    func configure(seat: SeatWithPrice) {
        placeLabel.text = "ряд \(seat.seat.rowNum!), место: \(seat.seat.place!)"
        priceLabel.text = "цена: \(seat.price)"
    }
    
    // MARK: - Private methods
    
    private func setup() {
        contentView.addSubview(placeLabel)
        contentView.addSubview(priceLabel)
        
        NSLayoutConstraint.activate([
             placeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
             placeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
             placeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),

             priceLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
             priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
             priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
         ])
    }
}
