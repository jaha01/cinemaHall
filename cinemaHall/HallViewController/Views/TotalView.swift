//
//  TotalView.swift
//  cinemaHall
//
//  Created by Jahongir Anvarov on 09.03.2025.
//

import UIKit

protocol TotalViewDelegate: AnyObject {
    func didTapNextBtn()
}

final class TotalView: UIView {
    
    // MARK: - Public Properties
    
    weak var delegate: TotalViewDelegate?
    
    // MARK: - Private properties
    
    private let nextBtn: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.blue, for: .selected)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.isUserInteractionEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapNextBtn), for: .touchUpInside)
        return button
    }()
    
    private let total: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        layer.cornerRadius = 20
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        layer.masksToBounds = true
        backgroundColor = .darkGray
        isUserInteractionEnabled = true
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(nextBtn)
        addSubview(total)
        setupConstraints() 
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Public methods
    
    func configure(price: Int, btnName: String){
        total.text = String(price)
        nextBtn.setTitle(btnName, for: .normal)
    }
    
    // MARK: Private methods
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            nextBtn.centerYAnchor.constraint(equalTo: centerYAnchor),
            nextBtn.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            nextBtn.bottomAnchor.constraint(equalTo: nextBtn.topAnchor, constant: 40),
            nextBtn.leadingAnchor.constraint(equalTo: nextBtn.trailingAnchor, constant: -112),
            
            total.centerYAnchor.constraint(equalTo: nextBtn.centerYAnchor),
            total.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            total.bottomAnchor.constraint(equalTo: total.topAnchor, constant: 40),
            total.trailingAnchor.constraint(equalTo: nextBtn.leadingAnchor, constant: -12)
        ])
    }
    
    @objc private func didTapNextBtn() {
        delegate?.didTapNextBtn()
    }
}
