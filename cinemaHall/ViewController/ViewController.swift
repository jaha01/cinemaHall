//
//  ViewController.swift
//  cinemaHall
//
//  Created by Jahongir Anvarov on 05.03.2025.
//

import UIKit

protocol ViewControllerProtocol: AnyObject {
    func configureSeats(seats: [SeatWithPrice])
    func configureHall(sessionInfo: SessionInfo, seatsType: [SeatType])
}


final class ViewController: UIViewController, ViewControllerProtocol, SeatViewDelegate {
    
    // MARK: - Public Properties
    
    var interactor: InteractorProtocol!
    var selectedSeats: [SeatWithPrice] = []
    
    // MARK: - Private Properties
    private var hallView: HallView!
    private let totalView = TotalView()
    
    
    // MARK: - Public methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        interactor.loadData()
        totalView.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateHallView()
        totalView.nextBtn.addTarget(self, action: #selector(didTapNextBtn), for: .touchUpInside)
    }
    
    func configureHall(sessionInfo: SessionInfo, seatsType: [SeatType]) {
        
        hallView = HallView(sessionInfo: sessionInfo, seatsType: seatsType)
        setupUI()
    }
    
    func configureSeats(seats: [SeatWithPrice]) {
        for seatWithPrice in seats {
            let seatView = SeatView(seatWithPrice: seatWithPrice)
            let seat = seatWithPrice.seat
            let xPosition = seat.left*7/5
            let yPosition = seat.top*7/5
            seatView.delegate = self
            seatView.frame = CGRect(x: xPosition-200, y: yPosition-100, width: 40, height: 40)
            hallView.hallMapView.addSubview(seatView)
        }
    }
    
    func didTapSeat(seatWithPrice: SeatWithPrice) {
        if let index = selectedSeats.firstIndex(of: seatWithPrice) {
            selectedSeats.remove(at: index)
        } else {
            selectedSeats.append(seatWithPrice)
        }
        
        updateHallView()
    }
    
    
    func didUpdateSelectedSeats(selectedSeats: [SeatWithPrice]) {
        self.selectedSeats = selectedSeats
        print("Данные обновлены в ViewController: \(selectedSeats)")
    }
    
    
    // MARK: - Private methods
    
    private func updateHallView() {
        if selectedSeats.count > 0 {
            totalView.isHidden = false
                // MARK: - ИЛИ ЛУЧШЕ ВЫЗВАТЬ ИНИТ А В ЭЛС ДЕИНИТ?
            let totalPrice = selectedSeats.reduce(0) { $0 + $1.price } // interactor!
            totalView.total.text = String(totalPrice)
            hallView.addSubview(totalView) // MARK: - !!!!!!!!!!!
            NSLayoutConstraint.activate([
                hallView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                hallView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                hallView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                hallView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                
                totalView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                totalView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                totalView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//                totalView.topAnchor.constraint(equalTo: totalView.bottomAnchor, constant: -80) heightAnchor!
                ])
        } else {
            totalView.isHidden = true
        }
    }
    
    private func setupUI() {
        view.addSubview(hallView)
        hallView.addSubview(totalView)
        hallView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            hallView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            hallView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            hallView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            hallView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            totalView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            totalView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            totalView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            totalView.topAnchor.constraint(equalTo: totalView.bottomAnchor, constant: -80)
        ])
    }
    
    @objc private func didTapNextBtn() {
        print("didTapNextBtn")
        interactor.transferOrder(selectedSeats: selectedSeats, totalView: totalView)
    }
    
    
}


