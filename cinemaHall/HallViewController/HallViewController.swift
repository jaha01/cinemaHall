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
    func updateHallView(totalPrice: Int)
}

final class HallViewController: UIViewController, ViewControllerProtocol {
    
    // MARK: - Public Properties
    
    var interactor: InteractorProtocol!
    
    // MARK: - Private Properties
    private var selectedSeats: [SeatWithPrice] = []
    
    private let hallView: HallView = {
        let hallView = HallView()
        hallView.translatesAutoresizingMaskIntoConstraints = false
        return hallView
    }()
    
    private let totalView = TotalView()
    
    // MARK: - Public methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        totalView.isHidden = true
        totalView.delegate = self
        interactor.loadData()
    }
    
    func configureHall(sessionInfo: SessionInfo, seatsType: [SeatType]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.hallView.configure(sessionInfo: sessionInfo, seatsType: seatsType)
            self.setupUI()
        }
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
    
    // MARK: - Private methods
    
    func updateHallView(totalPrice: Int) {
        if totalPrice > 0 {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.totalView.isHidden = false
                self.totalView.configure(price: totalPrice, btnName: "Далее")
            }
        } else {
            totalView.isHidden = true
        }
    }
    
    private func setupUI() {
        view.addSubview(hallView)
        hallView.addSubview(totalView)
        
        NSLayoutConstraint.activate([
            hallView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            hallView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            hallView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            hallView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            totalView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            totalView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            totalView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            totalView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
}

extension HallViewController: SeatViewDelegate {
    func didTapSeat(seatWithPrice: SeatWithPrice) {
        
        if let index = selectedSeats.firstIndex(of: seatWithPrice) {
            selectedSeats.remove(at: index)
            updateSeatSelectionState()
        } else {
            selectedSeats.append(seatWithPrice)
            if selectedSeats.count >= 5 {
                AlertManager.showAlert(config: AlertConfig(title: "Внимание", message: "Можно выбрать не более 5 мест"))
                updateSeatSelectionState()
            }
        }
        interactor.calcTotalSum(seats: selectedSeats)
    }
    
    private func updateSeatSelectionState() {
        let shouldDisable = selectedSeats.count >= 5
        for subview in hallView.hallMapView.subviews {
            if let seatView = subview as? SeatView, !selectedSeats.contains(seatView.seatWithPrice) {
                seatView.isEnabled = !shouldDisable
            }
        }
    }
}

extension HallViewController: TotalViewDelegate {
    func didTapNextBtn() {
        interactor.transferOrder(selectedSeats: selectedSeats, totalView: totalView)
    }
}
