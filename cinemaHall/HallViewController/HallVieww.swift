//
//  HallVC.swift
//  cinemaHall
//
//  Created by Jahongir Anvarov on 12.03.2025.
//

import UIKit

final class HallViewController: UIViewController {
    
    // MARK: - Private Properties
    private var viewModel: HallViewModelProtocol!
    private var selectedSeats: [SeatWithPrice] = []
    
    private let hallView: HallView = {
        let hallView = HallView()
        hallView.translatesAutoresizingMaskIntoConstraints = false
        return hallView
    }()
    
    private let totalView = TotalView()
    
    // MARK: - Public methods

    init(viewModel: HallViewModelProtocol) {
      super.init(nibName: nil, bundle: nil)
      self.viewModel = viewModel
      setupBindings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        totalView.isHidden = true
        totalView.delegate = self
        viewModel.loadData()
    }
    
    // MARK: - Private methods
    
    private func setupBindings() {
        
      viewModel.configureSeats = { [weak self] seats in
        for seatWithPrice in seats {
            let seatView = SeatView(seatWithPrice: seatWithPrice)
            let seat = seatWithPrice.seat
            let xPosition = seat.left*7/5
            let yPosition = seat.top*7/5
            seatView.delegate = self
            seatView.frame = CGRect(x: xPosition-200, y: yPosition-100, width: 40, height: 40)
            self?.hallView.configSeatView(seatView: seatView)
        }
      }

      viewModel.configureHall = { [weak self] sessionInfo, seatsType in
         DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
             self.hallView.configure(sessionInfo: sessionInfo, seatsType: seatsType)
             self.setupUI()
        }
      }

      viewModel.updateHallView = { [weak self] totalPrice in
        if totalPrice > 0 {
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.totalView.isHidden = false
                self.totalView.configure(price: totalPrice, btnName: "Далее")
            }
        } else {
            self?.totalView.isHidden = true
        }
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
        } else {
            selectedSeats.append(seatWithPrice)
            
            if !viewModel.canAddTickets(selectedSeats: selectedSeats) {
                AlertManager.showAlert(config: AlertConfig(title: "Внимание", message: "Можно выбрать не более 5 мест"))
            }
        }
        hallView.configureSeats(seatWithPrice: seatWithPrice, selectedSeats: selectedSeats)
        viewModel.calcTotalSum(seats: selectedSeats)
    }
    
    func alertBookedSeat() {
        AlertManager.showAlert(config: AlertConfig(title: "Место забронировано", message: "Это место уже забронировано. Пожалуйста, выберите другое."))
    }
}

extension HallViewController: TotalViewDelegate {
    func didTapNextBtn() {
        viewModel.transferOrder(selectedSeats: selectedSeats, totalView: totalView)
    }
}
